import 'package:statekit/statekit.dart';
import '../binding/settings_screen_binding.dart';

class SettingsScreenController extends StateController<SettingsScreenBinding> {
  bool isSoundEnabled = true;
  bool isMusicEnabled = true;
  bool isVibrationEnabled = true;
  String currentLanguage = 'English';

  void toggleSound() {
    isSoundEnabled = !isSoundEnabled;
    update();
  }

  void toggleMusic() {
    isMusicEnabled = !isMusicEnabled;
    update();
  }

  void toggleVibration() {
    isVibrationEnabled = !isVibrationEnabled;
    update();
  }

  void setLanguage(String language) {
    currentLanguage = language;
    update();
  }
}