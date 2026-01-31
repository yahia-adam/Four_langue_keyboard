import 'package:flutter/material.dart';
import 'package:pooring_keyboard/widgets/keyboard_button.dart';
import 'package:pooring_keyboard/models/key_model.dart';

class KeyboardRow extends StatelessWidget {
  const KeyboardRow({super.key, required this.keys});

  // Maintenant on reçoit une liste d'objets KeyModel
  final List<KeyModel> keys;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: keys.map((keyData) {
        return KeyboardButton(
          centerLabel: keyData.centerLabel,
          leftLabel: keyData.leftLabel,
          rightLabel: keyData.rightLabel,
          icon: keyData.icon,
          width: keyData.width,
          color: keyData.color ?? Colors.white,
          onTap: () => print('Tap: ${keyData.centerLabel}'),
        );
      }).toList(),
    );
  }
}
