import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileModel {
  final String username;
  final int avatarId;
  final String countryName;
  final String countryCode;
  final String countryFlag;
  final bool isGoogleSignedIn;
  final String? userEmail;

  const UserProfileModel({
    this.username = 'Guest User',
    this.avatarId = 0,
    this.countryName = 'United States',
    this.countryCode = 'US',
    this.countryFlag = '🇺🇸',
    this.isGoogleSignedIn = false,
    this.userEmail,
  });

  UserProfileModel copyWith({
    String? username,
    int? avatarId,
    String? countryName,
    String? countryCode,
    String? countryFlag,
    bool? isGoogleSignedIn,
    String? userEmail,
  }) {
    return UserProfileModel(
      username: username ?? this.username,
      avatarId: avatarId ?? this.avatarId,
      countryName: countryName ?? this.countryName,
      countryCode: countryCode ?? this.countryCode,
      countryFlag: countryFlag ?? this.countryFlag,
      isGoogleSignedIn: isGoogleSignedIn ?? this.isGoogleSignedIn,
      userEmail: userEmail ?? this.userEmail,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'avatarId': avatarId,
      'countryName': countryName,
      'countryCode': countryCode,
      'countryFlag': countryFlag,
      'isGoogleSignedIn': isGoogleSignedIn,
      'userEmail': userEmail,
    };
  }

  factory UserProfileModel.fromMap(Map<String, dynamic> map) {
    return UserProfileModel(
      username: map['username'] as String? ?? 'Guest User',
      avatarId: map['avatarId'] as int? ?? 0,
      countryName: map['countryName'] as String? ?? 'United States',
      countryCode: map['countryCode'] as String? ?? 'US',
      countryFlag: map['countryFlag'] as String? ?? '🇺🇸',
      isGoogleSignedIn: map['isGoogleSignedIn'] as bool? ?? false,
      userEmail: map['userEmail'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfileModel.fromJson(String source) =>
      UserProfileModel.fromMap(json.decode(source) as Map<String, dynamic>);

  static const String _prefKey = 'app_user_profile_data';

  static Future<UserProfileModel> loadFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? jsonStr = prefs.getString(_prefKey);
      if (jsonStr != null && jsonStr.isNotEmpty) {
        return UserProfileModel.fromJson(jsonStr);
      }
    } catch (_) {}
    return const UserProfileModel();
  }

  Future<bool> saveToPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.setString(_prefKey, toJson());
    } catch (_) {
      return false;
    }
  }
}
