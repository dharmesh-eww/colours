import 'package:flutter/material.dart';
import 'package:statekit/statekit.dart';
import 'package:colours/App/core/constants/country_data.dart';
import 'package:colours/App/core/models/user_profile_model.dart';
import '../binding/profile_edit_binding.dart';

class ProfileEditController extends StateController<ProfileEditBinding> {
  final TextEditingController nameTextController = TextEditingController();
  int selectedAvatarId = 0;
  CountryItem selectedCountry = CountryData.allCountries.firstWhere(
    (c) => c.code == 'US',
    orElse: () => CountryData.allCountries[0],
  );

  String searchQuery = '';
  List<CountryItem> filteredCountries = CountryData.allCountries;
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    isLoading = true;
    update();

    final profile = await UserProfileModel.loadFromPrefs();
    nameTextController.text = profile.username;
    selectedAvatarId = profile.avatarId;
    selectedCountry = CountryData.findByCode(profile.countryCode);

    filteredCountries = CountryData.allCountries;
    isLoading = false;
    update();
  }

  void selectAvatar(int id) {
    selectedAvatarId = id;
    update();
  }

  void selectCountry(CountryItem country) {
    selectedCountry = country;
    update();
  }

  void filterCountries(String query) {
    searchQuery = query;
    if (query.trim().isEmpty) {
      filteredCountries = CountryData.allCountries;
    } else {
      final q = query.trim().toLowerCase();
      filteredCountries = CountryData.allCountries.where((c) {
        return c.name.toLowerCase().contains(q) ||
            c.code.toLowerCase().contains(q);
      }).toList();
    }
    update();
  }

  Future<bool> saveProfile() async {
    final String name = nameTextController.text.trim().isEmpty
        ? 'Guest User'
        : nameTextController.text.trim();

    final current = await UserProfileModel.loadFromPrefs();
    final updated = current.copyWith(
      username: name,
      avatarId: selectedAvatarId,
      countryName: selectedCountry.name,
      countryCode: selectedCountry.code,
      countryFlag: selectedCountry.flag,
    );

    final success = await updated.saveToPrefs();
    return success;
  }

  @override
  void dispose() {
    nameTextController.dispose();
    super.dispose();
  }
}