import 'package:statekit/statekit.dart';
import '../binding/dashboard_binding.dart';

class DashboardController extends StateController<DashboardBinding> {
  int selectedIndex = 0;

  void changeTab(int index) {
    selectedIndex = index;
    update();
  }
}
