import 'package:flutter/material.dart';
import 'package:pooring_keyboard/widgets/keyboard_button.dart';

class KeyboardRow extends StatelessWidget {
  const KeyboardRow({super.key, required this.keys});

  final List<String> keys;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: keys
          .map((key) => KeyboardButton(centerLabel: key, onTap: () {}))
          .toList(),
    );
  }
}
