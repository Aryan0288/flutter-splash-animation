import 'package:flutter/material.dart';

/// WalletFeatureModel represents each value proposition card
/// displayed on the Blinkit Money dashboard.
class WalletFeatureModel {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;

  const WalletFeatureModel({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
  });
}
