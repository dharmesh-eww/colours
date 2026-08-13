import 'package:statekit/statekit.dart';
import 'package:flutter/material.dart';
import 'package:colours/App/core/constants/color_constants.dart';
import '../../base_screen/view/base_screen.dart';
import '../../base_screen/view/custom_appbar.dart';
import '../binding/settings_screen_binding.dart';
import '../controller/settings_screen_controller.dart';

class SettingsScreen extends StatekitView<SettingsScreenController>
    implements SettingsScreenBinding {
  SettingsScreen({super.key, super.tag});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      useGradientBackground: true,
      gradientColors: AppColors.splashGradient,
      extendBodyBehindAppBar: true,
      appBar: const CustomAppbar(titleText: 'Settings'),
      body: StateBuilder<SettingsScreenController>(
        controller: controller,
        builder: (context, ctrl, child) {
          return Center(child: Text("Settings"));
        },
      ),
    );
  }

  @override
  void doSomething() {}
}
