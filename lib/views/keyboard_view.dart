import 'package:flutter/material.dart';
import 'package:pooring_keyboard/models/key_model.dart';
import 'package:pooring_keyboard/widgets/keyboard_row.dart';

class KeyboardView extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const KeyboardView({
    super.key,
    required this.controller,
    required this.focusNode,
  });

  @override
  State<KeyboardView> createState() => _KeyboardViewState();
}

class _KeyboardViewState extends State<KeyboardView> {
  bool isCapsLock = false;
  bool isShiftActive = false;

  // La condition pour savoir si on affiche en MAJUSCULE
  bool get shouldShowUppercase => isCapsLock || isShiftActive;

  void toggleShift() {
    setState(() {
      isShiftActive = !isShiftActive;
    });
  }

  void toggleCapsLock() {
    setState(() {
      isCapsLock = !isCapsLock;
      if (isCapsLock) isShiftActive = false; // Désactive shift si caps est mis
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // RANGÉE 1
        KeyboardRow(
          controller: widget.controller,
          focusNode: widget.focusNode,
          isUppercase: shouldShowUppercase, // Utilise la logique combinée
          onKeyTap: (val) {
            // Si on tape une lettre et que le Shift était actif (mais pas Caps Lock)
            if (isShiftActive && !isCapsLock) {
              setState(() => isShiftActive = false); // On repasse en minuscule
            }
          },
          onShiftPressed: toggleShift,
          onCapsLockPressed: toggleCapsLock,
          keys: [
            KeyModel(centerLabel: '1'),
            KeyModel(centerLabel: '2'),
            KeyModel(centerLabel: '3'),
            KeyModel(centerLabel: '4'),
            KeyModel(centerLabel: '5'),
            KeyModel(centerLabel: '6'),
            KeyModel(centerLabel: '7'),
            KeyModel(centerLabel: '8'),
            KeyModel(centerLabel: '9'),
            KeyModel(centerLabel: '0'),
            KeyModel(
              centerLabel: 'delete',
              icon: Icons.backspace_outlined,
              width: 85,
              color: Colors.grey[200],
            ),
          ],
        ),

        // RANGÉE 2
        KeyboardRow(
          controller: widget.controller,
          focusNode: widget.focusNode,
          isUppercase: shouldShowUppercase, // Utilise la logique combinée
          onKeyTap: (val) {
            // Si on tape une lettre et que le Shift était actif (mais pas Caps Lock)
            if (isShiftActive && !isCapsLock) {
              setState(() => isShiftActive = false); // On repasse en minuscule
            }
          },
          onShiftPressed: toggleShift,
          onCapsLockPressed: toggleCapsLock,
          keys: [
            KeyModel(
              centerLabel: 'tab',
              icon: Icons.keyboard_tab,
              width: 75,
              color: Colors.grey[200],
            ),
            KeyModel(centerLabel: 'a̱'),
            KeyModel(centerLabel: 'w'),
            KeyModel(centerLabel: 'e'),
            KeyModel(centerLabel: 'r'),
            KeyModel(centerLabel: 't'),
            KeyModel(centerLabel: 'y'),
            KeyModel(centerLabel: 'u'),
            KeyModel(centerLabel: 'i'),
            KeyModel(centerLabel: 'o'),
            KeyModel(centerLabel: 'p'),
          ],
        ),

        // RANGÉE 3
        KeyboardRow(
          controller: widget.controller,
          focusNode: widget.focusNode,
          isUppercase: shouldShowUppercase, // Utilise la logique combinée
          onKeyTap: (val) {
            // Si on tape une lettre et que le Shift était actif (mais pas Caps Lock)
            if (isShiftActive && !isCapsLock) {
              setState(() => isShiftActive = false); // On repasse en minuscule
            }
          },
          onShiftPressed: toggleShift,
          onCapsLockPressed: toggleCapsLock,
          keys: [
            KeyModel(
              centerLabel: 'caps',
              icon: Icons.keyboard_capslock,
              width: 90,
              color: Colors.grey[200],
            ),
            KeyModel(centerLabel: 'a'),
            KeyModel(centerLabel: 's'),
            KeyModel(centerLabel: 'd'),
            KeyModel(centerLabel: 'ɨ'),
            KeyModel(centerLabel: 'g'),
            KeyModel(centerLabel: 'h'),
            KeyModel(centerLabel: 'j'),
            KeyModel(centerLabel: 'k'),
            KeyModel(centerLabel: 'l'),
            KeyModel(
              centerLabel: "enter",
              icon: Icons.keyboard_return,
              width: 95,
              color: Colors.blue[50],
            ),
          ],
        ),

        // RANGÉE 4
        KeyboardRow(
          controller: widget.controller,
          focusNode: widget.focusNode,
          isUppercase: shouldShowUppercase, // Utilise la logique combinée
          onKeyTap: (val) {
            // Si on tape une lettre et que le Shift était actif (mais pas Caps Lock)
            if (isShiftActive && !isCapsLock) {
              setState(() => isShiftActive = false); // On repasse en minuscule
            }
          },
          onShiftPressed: toggleShift,
          onCapsLockPressed: toggleCapsLock,
          keys: [
            KeyModel(
              centerLabel: 'shift',
              icon: Icons.arrow_upward,
              width: 115,
              color: Colors.grey[200],
            ),
            KeyModel(centerLabel: 'z'),
            KeyModel(centerLabel: 'ŋ'),
            KeyModel(centerLabel: 'ny'),
            KeyModel(centerLabel: 'ʉ'),
            KeyModel(centerLabel: 'b'),
            KeyModel(centerLabel: 'n'),
            KeyModel(centerLabel: 'm'),
            KeyModel(
              centerLabel: 'shift',
              icon: Icons.arrow_upward,
              width: 115,
              color: Colors.grey[200],
            ),
          ],
        ),

        // RANGÉE 5
        KeyboardRow(
          controller: widget.controller,
          focusNode: widget.focusNode,
          isUppercase: shouldShowUppercase, // Utilise la logique combinée
          onKeyTap: (val) {
            // Si on tape une lettre et que le Shift était actif (mais pas Caps Lock)
            if (isShiftActive && !isCapsLock) {
              setState(() => isShiftActive = false); // On repasse en minuscule
            }
          },
          onShiftPressed: toggleShift,
          onCapsLockPressed: toggleCapsLock,
          keys: [
            KeyModel(centerLabel: 'ctrl', width: 60, color: Colors.grey[200]),
            KeyModel(centerLabel: 'alt', width: 60, color: Colors.grey[200]),
            KeyModel(centerLabel: ' ', width: 300), // ESPACE
            KeyModel(centerLabel: 'alt', width: 60, color: Colors.grey[200]),
            KeyModel(centerLabel: 'ctrl', width: 60, color: Colors.grey[200]),
          ],
        ),
      ],
    );
  }
}
