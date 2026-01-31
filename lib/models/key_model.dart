import 'package:flutter/material.dart';

class KeyModel {
  final String centerLabel;
  final String? leftLabel;
  final String? rightLabel;
  final IconData? icon;
  final double width;
  final Color? color;

  KeyModel({
    required this.centerLabel,
    this.leftLabel,
    this.rightLabel,
    this.icon,
    this.width = 55.0,
    this.color,
  });
}
