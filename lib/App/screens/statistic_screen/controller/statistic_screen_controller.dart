import 'package:statekit/statekit.dart';
import '../repository/statistic_screen_repository.dart';
import '../binding/statistic_screen_binding.dart';

class StatisticScreenController extends StateController<StatisticScreenBinding> {
  final StatisticScreenRepository _repository = StatisticScreenRepository();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }
}