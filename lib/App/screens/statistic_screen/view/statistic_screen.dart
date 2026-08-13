import 'package:statekit/statekit.dart';
import 'package:flutter/material.dart';
import 'package:colours/App/core/constants/color_constants.dart';
import '../../base_screen/view/base_screen.dart';
import '../../base_screen/view/custom_appbar.dart';
import '../binding/statistic_screen_binding.dart';
import '../controller/statistic_screen_controller.dart';

class StatisticScreen extends StatekitView<StatisticScreenController>
    implements StatisticScreenBinding {
  StatisticScreen({super.key, super.tag});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      useGradientBackground: true,
      gradientColors: AppColors.splashGradient,
      extendBodyBehindAppBar: true,
      appBar: const CustomAppbar(titleText: 'Statistics'),
      body: StateBuilder<StatisticScreenController>(
        controller: controller,
        builder: (context, ctrl, child) {
          return Center(child: Text("statistic"));
        },
      ),
    );
  }

  @override
  void doSomething() {}
}
