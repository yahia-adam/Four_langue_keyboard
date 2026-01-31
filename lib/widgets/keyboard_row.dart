import 'package:flutter/material.dart';
import 'package:pooring_keyboard/models/key_model.dart';
import 'package:pooring_keyboard/widgets/keyboard_button.dart';

class KeyboardRow extends StatelessWidget {
  final List<KeyModel> keys;
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isUppercase;
  final bool isShiftActive;
  final bool isCapsLock;

  // Nouveaux paramètres pour gérer les différents types de Majuscules
  final VoidCallback onShiftPressed;
  final VoidCallback onCapsLockPressed;
  final Function(String) onKeyTap;

  const KeyboardRow({
    super.key,
    required this.keys,
    required this.focusNode,
    required this.controller,
    required this.isUppercase,
    required this.isShiftActive,
    required this.isCapsLock,
    required this.onShiftPressed,
    required this.onCapsLockPressed,
    required this.onKeyTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: keys.map((keyData) {
        final String lowerKey = keyData.centerLabel.toLowerCase();

        // --- LOGIQUE POUR ALLUMER LA TOUCHE ---
        bool active = false;
        if (lowerKey == 'shift' || keyData.icon == Icons.arrow_upward) {
          active = isShiftActive;
        } else if (lowerKey == 'caps' ||
            keyData.icon == Icons.keyboard_capslock) {
          active = isCapsLock;
        }

        // --- LOGIQUE D'AFFICHAGE DU TEXTE ---
        String displayLabel = keyData.centerLabel;
        if (isUppercase && !_isSystemKey(lowerKey)) {
          displayLabel = keyData.centerLabel.toUpperCase();
        } else if (!_isSystemKey(lowerKey)) {
          displayLabel = keyData.centerLabel.toLowerCase();
        }

        return KeyboardButton(
          centerLabel: displayLabel,
          leftLabel: keyData.leftLabel,
          rightLabel: keyData.rightLabel,
          icon: keyData.icon,
          width: keyData.width,
          color: keyData.color ?? Colors.white,
          isActive: active,
          onTap: (val) {
            final String lowerKey = keyData.centerLabel.toLowerCase();

            // 1. Détection Caps Lock
            if (lowerKey == 'caps' || keyData.icon == Icons.keyboard_capslock) {
              onCapsLockPressed();
            }
            // 2. Détection Shift
            else if (lowerKey == 'shift' ||
                keyData.icon == Icons.arrow_upward) {
              onShiftPressed();
            }
            // 3. Détection Delete
            else if (lowerKey == 'delete' ||
                keyData.icon == Icons.backspace_outlined) {
              _handleBackspace(controller);
            }
            // 4. Détection tabulation
            else if (lowerKey == 'tab' || keyData.icon == Icons.tab) {
              _insertText('\t', controller);
            }
            // 5. Détection Enter
            else if (lowerKey == 'enter' ||
                keyData.icon == Icons.arrow_forward) {
              _insertText('\n', controller);
            }
            // 6. Touches normales
            else {
              _insertText(val, controller);
              onKeyTap(val); // Indique au parent qu'une lettre a été tapée
            }

            // Garder le focus sur le champ de texte
            Future.microtask(() => focusNode.requestFocus());
          },
        );
      }).toList(),
    );
  }

  void _insertText(String myText, TextEditingController controller) {
    final text = controller.text;
    final selection = controller.selection;
    if (selection.start >= 0) {
      final newText = text.replaceRange(selection.start, selection.end, myText);
      controller.value = controller.value.copyWith(
        text: newText,
        selection: TextSelection.collapsed(
          offset: selection.start + myText.length,
        ),
      );
    } else {
      controller.text += myText;
    }
  }

  void _handleBackspace(TextEditingController controller) {
    final text = controller.text;
    final selection = controller.selection;
    if (text.isNotEmpty && selection.start > 0) {
      final newText = text.replaceRange(
        selection.start - 1,
        selection.start,
        '',
      );
      controller.value = controller.value.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: selection.start - 1),
      );
    }
  }

  // Petite fonction utilitaire à mettre en bas de ta classe KeyboardRow
  bool _isSystemKey(String label) {
    final lowLabel = label.toLowerCase();
    const systemKeys = [
      'ctrl',
      'alt',
      'shift',
      'caps',
      'tab',
      'enter',
      'delete',
      'backspace',
    ];
    return systemKeys.contains(lowLabel);
  }
}
