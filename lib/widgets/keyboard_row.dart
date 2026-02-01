import 'package:flutter/material.dart';
import 'package:pooring_keyboard/models/key_model.dart';
import 'package:pooring_keyboard/widgets/keyboard_button.dart';

class KeyboardRow extends StatelessWidget {
  final List<KeyModel> keys;
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isShiftActive;
  final bool isCapsLock;
  final bool isCtrlActive;
  final bool isAltActive;

  final VoidCallback onShiftPressed;
  final VoidCallback onCapsLockPressed;
  final VoidCallback onCtrlPressed;
  final VoidCallback onAltPressed;
  final Function(String) onKeyTap;

  const KeyboardRow({
    super.key,
    required this.keys,
    required this.focusNode,
    required this.controller,
    required this.isShiftActive,
    required this.isCapsLock,
    required this.onShiftPressed,
    required this.onCapsLockPressed,
    required this.onCtrlPressed,
    required this.onAltPressed,
    required this.isCtrlActive,
    required this.isAltActive,
    required this.onKeyTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: keys.map((keyData) {
        final String lowerKey = keyData.centerLabel.toLowerCase();

        bool active = false;
        if (lowerKey == 'shift' || keyData.icon == Icons.arrow_upward) {
          active = isShiftActive;
        } else if (lowerKey == 'caps' ||
            keyData.icon == Icons.keyboard_capslock) {
          active = isCapsLock;
        } else if (lowerKey == 'ctrl' ||
            keyData.icon == Icons.keyboard_control) {
          active = isCtrlActive;
        } else if (lowerKey == 'alt' || keyData.icon == Icons.keyboard_alt) {
          active = isAltActive;
        }

        String centerLabel = keyData.centerLabel;
        String leftLabel = keyData.leftLabel ?? "";
        String rightLabel = keyData.rightLabel ?? "";

        if (isCapsLock) {
          centerLabel = rightLabel;
          rightLabel = keyData.centerLabel;
        }

        if (isShiftActive) {
          String tmp = centerLabel;
          centerLabel = rightLabel;
          rightLabel = tmp;
        }

        if (isAltActive) {
          centerLabel = leftLabel;
          leftLabel = "";
          rightLabel = "";
        }

        if (_isSystemKey(lowerKey)) {
          centerLabel = keyData.centerLabel;
          leftLabel = "";
          rightLabel = "";
        }

        bool isUpperCase =
            centerLabel == centerLabel.toUpperCase() &&
            centerLabel != centerLabel.toLowerCase();

        return Expanded(
          flex: (keyData.width / 10).round(),
          child: KeyboardButton(
            centerLabel: centerLabel,
            leftLabel: leftLabel,
            rightLabel: rightLabel,
            variations: keyData.variations,
            icon: keyData.icon,
            width: keyData.width,
            color: keyData.color ?? Colors.white,
            isActive: active,
            onLongPress: (vars) => {
              _showAccentPopup(
                context,
                vars.map((char) {
                  return isUpperCase ? char.toUpperCase() : char.toLowerCase();
                }).toList(),
              ),
            },
            onTap: (val) => _onKeyHandle(keyData, val),
          ),
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

  void _onKeyHandle(KeyModel keyData, String currentVal) {
    final String lowerKey = keyData.centerLabel.toLowerCase();

    if (lowerKey == 'caps' || keyData.icon == Icons.keyboard_capslock) {
      onCapsLockPressed();
    } else if (lowerKey == 'shift' || keyData.icon == Icons.arrow_upward) {
      onShiftPressed();
    } else if (lowerKey == 'ctrl' || keyData.icon == Icons.keyboard_control) {
      onCtrlPressed();
    } else if (lowerKey == 'alt' || keyData.icon == Icons.keyboard_alt) {
      onAltPressed();
    } else if (lowerKey == 'delete' ||
        keyData.icon == Icons.backspace_outlined) {
      _handleBackspace(controller);
    } else if (lowerKey == 'tab' || keyData.icon == Icons.tab) {
      _insertText('\t', controller);
    } else if (lowerKey == 'enter' || keyData.icon == Icons.keyboard_return) {
      _insertText('\n', controller);
    } else {
      _insertText(currentVal, controller);
      onKeyTap(currentVal);
    }

    Future.microtask(() => focusNode.requestFocus());
  }

  void _showAccentPopup(BuildContext context, List<String> variations) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Zone pour fermer en cliquant ailleurs
          GestureDetector(
            onTap: () => entry.remove(),
            child: Container(color: Colors.transparent),
          ),

          // La petite boîte flottante
          Center(
            // On centre pour l'instant, ou on positionne
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFFECEFF1), // Gris clair pro
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize
                      .min, // INDISPENSABLE : la boîte s'adapte au contenu
                  children: variations
                      .map(
                        (char) => _buildMiniKey(char, () {
                          _insertText(char, controller);
                          entry.remove();
                        }),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    overlay.insert(entry);
  }

  Widget _buildMiniKey(String char, VoidCallback onTap) {
    bool _isMiniPressed =
        false; // Il faudra transformer ce widget en StatefulWidget ou utiliser un StatefulBuilder

    return StatefulBuilder(
      builder: (context, setMiniState) {
        return GestureDetector(
          onTapDown: (_) => setMiniState(() => _isMiniPressed = true),
          onTapUp: (_) => setMiniState(() => _isMiniPressed = false),
          onTapCancel: () => setMiniState(() => _isMiniPressed = false),
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 60),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: _isMiniPressed ? Colors.grey.shade400 : Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: _isMiniPressed
                  ? []
                  : [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 2,
                        offset: Offset(0, 2),
                      ),
                    ],
            ),
            child: Center(
              child: Text(char, style: const TextStyle(fontSize: 18)),
            ),
          ),
        );
      },
    );
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
