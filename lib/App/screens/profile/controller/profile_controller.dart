import 'package:statekit/statekit.dart';
import 'package:colours/App/core/models/user_profile_model.dart';
import '../binding/profile_binding.dart';

class ProfileController extends StateController<ProfileBinding> {
  UserProfileModel _userProfile = const UserProfileModel();
  bool _isLoading = true;

  UserProfileModel get userProfile => _userProfile;
  bool get isLoading => _isLoading;

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  Future<void> loadProfile() async {
    _isLoading = true;
    update();
    _userProfile = await UserProfileModel.loadFromPrefs();
    _isLoading = false;
    update();
  }

  Future<void> toggleGoogleSignIn() async {
    if (_userProfile.isGoogleSignedIn) {
      // Sign out
      _userProfile = _userProfile.copyWith(
        isGoogleSignedIn: false,
        userEmail: null,
      );
    } else {
      // Simulate Google Sign In
      _userProfile = _userProfile.copyWith(
        username: _userProfile.username == 'Guest User' ? 'Alex Rivera' : _userProfile.username,
        isGoogleSignedIn: true,
        userEmail: 'alex.rivera@gmail.com',
      );
    }
    await _userProfile.saveToPrefs();
    update();
  }
}