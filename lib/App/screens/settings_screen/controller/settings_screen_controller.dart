import 'package:statekit/statekit.dart';
import '../repository/settings_screen_repository.dart';
import '../binding/settings_screen_binding.dart';

class SettingsScreenController extends StateController<SettingsScreenBinding> {
  final SettingsScreenRepository _repository = SettingsScreenRepository();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }
}