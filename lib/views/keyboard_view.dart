import 'package:flutter/material.dart';
import 'package:pooring_keyboard/models/key_model.dart';
import 'package:pooring_keyboard/widgets/keyboard_row.dart';

class KeyboardView extends StatelessWidget {
  const KeyboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // RANGÉE 1 : Chiffres
        KeyboardRow(
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

        // RANGÉE 2 : AZERTY / QWERTY modifié
        KeyboardRow(
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

        // RANGÉE 3 : Milieu
        KeyboardRow(
          keys: [
            KeyModel(
              centerLabel: 'caps',
              icon: Icons.keyboard_capslock,
              width: 90,
              color: Colors.grey[200],
            ),
            KeyModel(centerLabel: 'a'), KeyModel(centerLabel: 's'),
            KeyModel(centerLabel: 'd'),
            KeyModel(centerLabel: '†'), // Tiré du clavier noir
            KeyModel(centerLabel: 'g'), KeyModel(centerLabel: 'h'),
            KeyModel(centerLabel: 'j'), KeyModel(centerLabel: 'k'),
            KeyModel(centerLabel: 'l'),
            KeyModel(
              centerLabel: " ",
              icon: Icons.keyboard_return,
              width: 95,
              color: Colors.blue[50],
            ),
          ],
        ),

        // RANGÉE 4 : Bas (avec les lettres spéciales Four)
        KeyboardRow(
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

        // RANGÉE 5 : Barre d'espace et fonctions
        KeyboardRow(
          keys: [
            KeyModel(centerLabel: 'ctrl', width: 60, color: Colors.grey[200]),
            KeyModel(centerLabel: 'alt', width: 60, color: Colors.grey[200]),
            KeyModel(centerLabel: '', width: 300), // ESPACE
            KeyModel(centerLabel: 'alt', width: 60, color: Colors.grey[200]),
            KeyModel(centerLabel: 'ctrl', width: 60, color: Colors.grey[200]),
          ],
        ),
      ],
    );
  }
}
