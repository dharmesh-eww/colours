import 'package:flutter/material.dart';
import 'package:statekit/statekit.dart';
import 'package:colours/App/core/constants/avatar_data.dart';
import 'package:colours/App/core/constants/color_constants.dart';
import '../../base_screen/view/base_screen.dart';
import '../binding/profile_edit_binding.dart';
import '../controller/profile_edit_controller.dart';

class ProfileEdit extends StatekitView<ProfileEditController> implements ProfileEditBinding {
  ProfileEdit({super.key, super.tag});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      useGradientBackground: false,
      backgroundColor: AppColors.homeNavyDark,
      padding: EdgeInsets.zero,
      body: StateBuilder<ProfileEditController>(
        controller: controller,
        builder: (context, ctrl, child) {
          if (ctrl.isLoading) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primaryPurple));
          }

          final selectedAvatar = AvatarData.getAvatar(ctrl.selectedAvatarId);

          return SafeArea(
            child: Column(
              children: [
                // ── Header Bar ─────────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: AppColors.homeCardNavy,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: AppColors.homeCardBorder, width: 1),
                          ),
                          child: const Icon(
                            Icons.arrow_back_rounded,
                            color: AppColors.textPrimary,
                            size: 22,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Text(
                        'EDIT PROFILE',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ── Live Hero Preview Card ──────────────────────────
                        Center(
                          child: Column(
                            children: [
                              Material(
                                color: Colors.transparent,
                                child: Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    Container(
                                      width: 96,
                                      height: 96,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: LinearGradient(
                                          colors: selectedAvatar.gradient,
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: selectedAvatar.gradient.first.withValues(
                                              alpha: 0.4,
                                            ),
                                            blurRadius: 18,
                                            spreadRadius: 2,
                                          ),
                                        ],
                                        border: Border.all(
                                          color: Colors.white.withValues(alpha: 0.8),
                                          width: 3,
                                        ),
                                      ),
                                      child: Icon(
                                        selectedAvatar.icon,
                                        color: selectedAvatar.iconColor,
                                        size: 48,
                                      ),
                                    ),
                                    Material(
                                      color: Colors.transparent,
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: AppColors.homeNavyDark,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: AppColors.homeCardBorder,
                                            width: 2,
                                          ),
                                        ),
                                        child: Text(
                                          ctrl.selectedCountry.flag,
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 12),

                              Material(
                                color: Colors.transparent,
                                child: ValueListenableBuilder<TextEditingValue>(
                                  valueListenable: ctrl.nameTextController,
                                  builder: (context, val, child) {
                                    final displayStr = val.text.trim().isEmpty
                                        ? 'Guest User'
                                        : val.text.trim();
                                    return Text(
                                      displayStr,
                                      style: const TextStyle(
                                        color: AppColors.textPrimary,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // ── Section 1: Username Input ──────────────────────
                        const Text(
                          'USERNAME',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.homeCardNavy,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(color: AppColors.homeCardBorder, width: 1.5),
                          ),
                          child: TextField(
                            controller: ctrl.nameTextController,
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Enter username',
                              hintStyle: TextStyle(
                                color: AppColors.textSecondary.withValues(alpha: 0.6),
                                fontSize: 14,
                              ),
                              prefixIcon: const Icon(
                                Icons.person_outline_rounded,
                                color: AppColors.primaryPurpleLight,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // ── Section 2: Country Selection ───────────────────
                        const Text(
                          'COUNTRY & FLAG',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () => _showCountryPickerModal(context, ctrl),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            decoration: BoxDecoration(
                              color: AppColors.homeCardNavy,
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(color: AppColors.homeCardBorder, width: 1.5),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  ctrl.selectedCountry.flag,
                                  style: const TextStyle(fontSize: 24),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    '${ctrl.selectedCountry.name} (${ctrl.selectedCountry.code})',
                                    style: const TextStyle(
                                      color: AppColors.textPrimary,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: AppColors.textSecondary,
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // ── Section 3: Select Avatar (25 Options) ──────────
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'SELECT AVATAR',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.2,
                              ),
                            ),
                            Text(
                              '${AvatarData.presets.length} Avatars',
                              style: const TextStyle(
                                color: AppColors.primaryPurpleLight,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 1.0,
                          ),
                          itemCount: AvatarData.presets.length,
                          itemBuilder: (context, index) {
                            final preset = AvatarData.presets[index];
                            final bool isSelected = ctrl.selectedAvatarId == preset.id;

                            return GestureDetector(
                              onTap: () => ctrl.selectAvatar(preset.id),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: preset.gradient,
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  border: Border.all(
                                    color: isSelected ? Colors.white : Colors.transparent,
                                    width: isSelected ? 3 : 0,
                                  ),
                                  boxShadow: [
                                    if (isSelected)
                                      BoxShadow(
                                        color: preset.gradient.first.withValues(alpha: 0.6),
                                        blurRadius: 10,
                                        spreadRadius: 2,
                                      ),
                                  ],
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Icon(preset.icon, color: preset.iconColor, size: 26),
                                    if (isSelected)
                                      Positioned(
                                        top: 2,
                                        right: 2,
                                        child: Container(
                                          padding: const EdgeInsets.all(2),
                                          decoration: const BoxDecoration(
                                            color: AppColors.accentGold,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.check_rounded,
                                            color: Colors.black,
                                            size: 10,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 32),

                        // ── Save Changes Button ────────────────────────────
                        GestureDetector(
                          onTap: () async {
                            final ok = await ctrl.saveProfile();
                            if (ok && context.mounted) {
                              Navigator.pop(context, true);
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            height: 54,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(colors: AppColors.primaryGradient),
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primaryPurple.withValues(alpha: 0.4),
                                  blurRadius: 16,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Text(
                                'SAVE CHANGES',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showCountryPickerModal(BuildContext context, ProfileEditController ctrl) {
    ctrl.filterCountries('');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StateBuilder<ProfileEditController>(
          controller: ctrl,
          builder: (context, controller, child) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.75,
              decoration: const BoxDecoration(
                color: AppColors.homeNavyDark,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                border: Border(top: BorderSide(color: AppColors.homeCardBorder, width: 1.5)),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  // Drag Handle
                  Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: AppColors.textSecondary.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'SELECT YOUR COUNTRY',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.homeCardNavy,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.homeCardBorder),
                      ),
                      child: TextField(
                        onChanged: controller.filterCountries,
                        style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
                        decoration: InputDecoration(
                          hintText: 'Search country or code...',
                          hintStyle: TextStyle(
                            color: AppColors.textSecondary.withValues(alpha: 0.6),
                            fontSize: 14,
                          ),
                          prefixIcon: const Icon(
                            Icons.search_rounded,
                            color: AppColors.textSecondary,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Country List
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      itemCount: controller.filteredCountries.length,
                      separatorBuilder: (context, index) =>
                          const Divider(color: AppColors.divider, height: 1),
                      itemBuilder: (context, index) {
                        final country = controller.filteredCountries[index];
                        final bool isSelected = controller.selectedCountry.code == country.code;

                        return ListTile(
                          onTap: () {
                            controller.selectCountry(country);
                            Navigator.pop(context);
                          },
                          leading: Text(country.flag, style: const TextStyle(fontSize: 26)),
                          title: Text(
                            country.name,
                            style: TextStyle(
                              color: isSelected ? AppColors.primaryCyan : AppColors.textPrimary,
                              fontWeight: isSelected ? FontWeight.w900 : FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          trailing: isSelected
                              ? const Icon(Icons.check_circle_rounded, color: AppColors.primaryCyan)
                              : Text(
                                  country.code,
                                  style: const TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  void doSomething() {}
}
