import 'package:statekit/statekit.dart';
import 'package:flutter/material.dart';
import 'package:colours/App/core/constants/color_constants.dart';
import '../../base_screen/view/base_screen.dart';
import '../../home/view/home.dart';
import '../../level_selection/view/level_selection.dart';
import '../../profile/view/profile.dart';
import '../binding/dashboard_binding.dart';
import '../controller/dashboard_controller.dart';

class Dashboard extends StatekitView<DashboardController> implements DashboardBinding {
  Dashboard({super.key, super.tag});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      useGradientBackground: false,
      backgroundColor: AppColors.homeNavyDark,
      padding: EdgeInsets.zero,
      body: StateBuilder<DashboardController>(
        controller: controller,
        builder: (context, ctrl, child) {
          return switch (ctrl.selectedIndex) {
            0 => Home(),
            1 => LevelSelection(),
            2 => Profile(),
            _ => SizedBox(),
          };
        },
      ),
      bottomNavigationBar: StateBuilder<DashboardController>(
        controller: controller,
        builder: (context, ctrl, child) {
          return _buildBottomNav(context);
        },
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    final int selected = controller.selectedIndex;

    final items = [
      _NavItem(icon: Icons.home_rounded, label: 'HOME'),
      _NavItem(icon: Icons.grid_view_rounded, label: 'LEVELS'),
      _NavItem(icon: Icons.person_rounded, label: 'PROFILE'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.bottomNavBackground,
        border: Border(top: BorderSide(color: AppColors.homeCardBorder, width: 1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 70,
          child: Row(
            children: List.generate(items.length, (index) {
              final bool isActive = selected == index;
              return Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => controller.changeTab(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                      color: isActive
                          ? AppColors.primaryPurple.withValues(alpha: 0.18)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          items[index].icon,
                          color: isActive ? AppColors.primaryPurple : AppColors.textSecondary,
                          size: 26,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          items[index].label,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: isActive ? AppColors.primaryPurple : AppColors.textSecondary,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  @override
  void doSomething() {}
}

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem({required this.icon, required this.label});
}
