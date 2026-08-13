import 'package:flutter/material.dart';

class AvatarPreset {
  final int id;
  final String label;
  final IconData icon;
  final List<Color> gradient;
  final Color iconColor;

  const AvatarPreset({
    required this.id,
    required this.label,
    required this.icon,
    required this.gradient,
    required this.iconColor,
  });
}

class AvatarData {
  static const List<AvatarPreset> presets = [
    AvatarPreset(
      id: 0,
      label: 'Cyber Fox',
      icon: Icons.pets_rounded,
      gradient: [Color(0xFF7C5CFC), Color(0xFF00E5FF)],
      iconColor: Colors.white,
    ),
    AvatarPreset(
      id: 1,
      label: 'Neon Panther',
      icon: Icons.sports_esports_rounded,
      gradient: [Color(0xFFFF2A6D), Color(0xFF9A00E6)],
      iconColor: Colors.white,
    ),
    AvatarPreset(
      id: 2,
      label: 'Golden Crown',
      icon: Icons.military_tech_rounded,
      gradient: [Color(0xFFFFD700), Color(0xFFFF8C00)],
      iconColor: Colors.black87,
    ),
    AvatarPreset(
      id: 3,
      label: 'Starlight',
      icon: Icons.auto_awesome_rounded,
      gradient: [Color(0xFF00E5FF), Color(0xFF1E88E5)],
      iconColor: Colors.white,
    ),
    AvatarPreset(
      id: 4,
      label: 'Cosmic Wizard',
      icon: Icons.psychology_rounded,
      gradient: [Color(0xFF8E24AA), Color(0xFF3F51B5)],
      iconColor: Colors.white,
    ),
    AvatarPreset(
      id: 5,
      label: 'Fire Ninja',
      icon: Icons.local_fire_department_rounded,
      gradient: [Color(0xFFFF5252), Color(0xFFFF7043)],
      iconColor: Colors.white,
    ),
    AvatarPreset(
      id: 6,
      label: 'Aqua Shield',
      icon: Icons.verified_user_rounded,
      gradient: [Color(0xFF00B0FF), Color(0xFF00E676)],
      iconColor: Colors.white,
    ),
    AvatarPreset(
      id: 7,
      label: 'Lightning Hero',
      icon: Icons.bolt_rounded,
      gradient: [Color(0xFFFFEA00), Color(0xFFFF9100)],
      iconColor: Colors.black87,
    ),
    AvatarPreset(
      id: 8,
      label: 'Galaxy Pilot',
      icon: Icons.rocket_launch_rounded,
      gradient: [Color(0xFF651FFF), Color(0xFF00B0FF)],
      iconColor: Colors.white,
    ),
    AvatarPreset(
      id: 9,
      label: 'Diamond Ace',
      icon: Icons.diamond_rounded,
      gradient: [Color(0xFF00E5FF), Color(0xFF7C5CFC)],
      iconColor: Colors.white,
    ),
    AvatarPreset(
      id: 10,
      label: 'Shadow Blade',
      icon: Icons.security_rounded,
      gradient: [Color(0xFF37474F), Color(0xFF263238)],
      iconColor: Color(0xFF00E5FF),
    ),
    AvatarPreset(
      id: 11,
      label: 'Emerald King',
      icon: Icons.workspace_premium_rounded,
      gradient: [Color(0xFF00E676), Color(0xFF1B5E20)],
      iconColor: Colors.white,
    ),
    AvatarPreset(
      id: 12,
      label: 'Hyper Speed',
      icon: Icons.speed_rounded,
      gradient: [Color(0xFFFF1744), Color(0xFFD500F9)],
      iconColor: Colors.white,
    ),
    AvatarPreset(
      id: 13,
      label: 'Mystic Orb',
      icon: Icons.lens_blur_rounded,
      gradient: [Color(0xFF673AB7), Color(0xFFE91E63)],
      iconColor: Colors.white,
    ),
    AvatarPreset(
      id: 14,
      label: 'Solar Flare',
      icon: Icons.wb_sunny_rounded,
      gradient: [Color(0xFFFF6D00), Color(0xFFFFD600)],
      iconColor: Colors.white,
    ),
    AvatarPreset(
      id: 15,
      label: 'Frost Dragon',
      icon: Icons.ac_unit_rounded,
      gradient: [Color(0xFF80DEEA), Color(0xFF0097A7)],
      iconColor: Colors.white,
    ),
    AvatarPreset(
      id: 16,
      label: 'Night Owl',
      icon: Icons.dark_mode_rounded,
      gradient: [Color(0xFF303F9F), Color(0xFF1A237E)],
      iconColor: Color(0xFFFFD700),
    ),
    AvatarPreset(
      id: 17,
      label: 'Pixel Knight',
      icon: Icons.videogame_asset_rounded,
      gradient: [Color(0xFFE040FB), Color(0xFF7C4DFF)],
      iconColor: Colors.white,
    ),
    AvatarPreset(
      id: 18,
      label: 'Target Strike',
      icon: Icons.track_changes_rounded,
      gradient: [Color(0xFFFF3D00), Color(0xFFDD2C00)],
      iconColor: Colors.white,
    ),
    AvatarPreset(
      id: 19,
      label: 'Quantum Core',
      icon: Icons.all_inclusive_rounded,
      gradient: [Color(0xFF1DE9B6), Color(0xFF00B0FF)],
      iconColor: Colors.white,
    ),
    AvatarPreset(
      id: 20,
      label: 'Golden Trophy',
      icon: Icons.emoji_events_rounded,
      gradient: [Color(0xFFFFC107), Color(0xFFFF8F00)],
      iconColor: Colors.black87,
    ),
    AvatarPreset(
      id: 21,
      label: 'Vortex Pulse',
      icon: Icons.blur_circular_rounded,
      gradient: [Color(0xFFAA00FF), Color(0xFF00E5FF)],
      iconColor: Colors.white,
    ),
    AvatarPreset(
      id: 22,
      label: 'Cyber Shield',
      icon: Icons.shield_rounded,
      gradient: [Color(0xFF2962FF), Color(0xFF00E5FF)],
      iconColor: Colors.white,
    ),
    AvatarPreset(
      id: 23,
      label: 'Prism Spark',
      icon: Icons.filter_tilt_shift_rounded,
      gradient: [Color(0xFFFF4081), Color(0xFFFFD700)],
      iconColor: Colors.white,
    ),
    AvatarPreset(
      id: 24,
      label: 'Master Gamer',
      icon: Icons.extension_rounded,
      gradient: [Color(0xFF6200EA), Color(0xFF00B8D4)],
      iconColor: Colors.white,
    ),
  ];

  static AvatarPreset getAvatar(int id) {
    if (id < 0 || id >= presets.length) return presets[0];
    return presets[id];
  }
}
