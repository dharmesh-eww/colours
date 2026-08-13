import 'package:colours/App/screens/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:statekit/statekit.dart';

import './app_routes.dart';
import '../screens/splash_screen/view/splash_screen.dart';
import '../screens/play_screen/view/play_screen.dart';
import '../screens/play_screen/controller/play_screen_controller.dart';
import '../screens/level_selection/controller/level_selection_controller.dart';
import '../screens/settings_screen/view/settings_screen.dart';
import '../screens/settings_screen/controller/settings_screen_controller.dart';
import '../screens/statistic_screen/view/statistic_screen.dart';
import '../screens/statistic_screen/controller/statistic_screen_controller.dart';
import '../screens/dashboard/view/dashboard.dart';
import '../screens/dashboard/controller/dashboard_controller.dart';
import '../screens/profile/controller/profile_controller.dart';
import '../screens/profile_edit/view/profile_edit.dart';
import '../screens/profile_edit/controller/profile_edit_controller.dart';

abstract class RouteNavigator {
  static final Map<String, Widget Function(BuildContext)> routes = {
    Routes.splash: (BuildContext context) => const SplashScreen(),
    Routes.dashboard: (BuildContext context) => StateProvider.multi(
      stateProviders: [
        StatekitProvider(create: () => DashboardController()),
        StatekitProvider(create: () => HomeController()..loadData()),
        StatekitProvider(create: () => LevelSelectionController()..loadData()),
        StatekitProvider(create: () => ProfileController()),
      ],
      child: Dashboard(),
    ),
    Routes.playScreen: (BuildContext context) => StateProvider(
      stateProvider: StatekitProvider(create: () => PlayScreenController()),
      child: PlayScreen(),
    ),
    Routes.settingsScreen: (BuildContext context) => StateProvider(
      stateProvider: StatekitProvider(create: () => SettingsScreenController()),
      child: SettingsScreen(),
    ),
    Routes.statisticScreen: (BuildContext context) => StateProvider(
      stateProvider: StatekitProvider(create: () => StatisticScreenController()),
      child: StatisticScreen(),
    ),

    Routes.profileEdit: (BuildContext context) => StateProvider(
      stateProvider: StatekitProvider(create: () => ProfileEditController()),
      child: ProfileEdit(),
    ),
  };
}
