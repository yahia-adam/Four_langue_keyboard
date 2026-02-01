import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pooring_keyboard/models/key_model.dart';
import 'package:pooring_keyboard/widgets/keyboard_row.dart';

class KeyboardView extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String keyboardConfig;

  const KeyboardView({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.keyboardConfig,
  });

  @override
  State<KeyboardView> createState() => _KeyboardViewState();
}

class _KeyboardViewState extends State<KeyboardView> {
  bool isCapsLock = false;
  bool isShiftActive = false;
  bool isCtrlActive = false;
  bool isAltActive = false;
  bool get shouldShowUppercase => isCapsLock ^ isShiftActive;

  void toggleShift() => setState(() => isShiftActive = !isShiftActive);
  void toggleCtrl() => setState(() => isCtrlActive = !isCtrlActive);
  void toggleAlt() => setState(() => isAltActive = !isAltActive);

  void toggleCapsLock() {
    setState(() {
      isCapsLock = !isCapsLock;
      if (isCapsLock) isShiftActive = false;
    });
  }

  Future<List<List<KeyModel>>> loadKeyboardConfig() async {
    final String response = await rootBundle.loadString(widget.keyboardConfig);
    final data = json.decode(response);
    List<List<KeyModel>> rows = [];
    for (var row in data['rows']) {
      List<KeyModel> keyModels = [];
      for (var key in row) {
        Color? color;
        if (key['color'] == 'grey') {
          color = Colors.grey[200];
        } else if (key['color'] == 'blue') {
          color = Colors.blue[50];
        } else {
          color = Colors.white;
        }

        final variations = key['variations'] != null
            ? List<String>.from(key['variations'])
            : null;

        keyModels.add(
          KeyModel(
            centerLabel: key['center'] ?? "",
            rightLabel: key['shift'],
            leftLabel: key['alt'],
            variations: variations,
            width: (key['width'] as num?)?.toDouble() ?? 55.0,
            color: color,
            icon: _mapIcon(key['icon']),
          ),
        );
      }
      rows.add(keyModels);
    }

    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<List<KeyModel>>>(
      future: loadKeyboardConfig(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        final keyboardData = snapshot.data!;

        return Column(
          children: keyboardData.map((rowKeys) {
            return KeyboardRow(
              keys: rowKeys,
              controller: widget.controller,
              focusNode: widget.focusNode,
              isShiftActive: isShiftActive,
              isCapsLock: isCapsLock,
              isCtrlActive: isCtrlActive,
              isAltActive: isAltActive,
              onShiftPressed: toggleShift,
              onCapsLockPressed: toggleCapsLock,
              onCtrlPressed: toggleCtrl,
              onAltPressed: toggleAlt,
              onKeyTap: (val) {
                if (isShiftActive && !isCapsLock) {
                  setState(() => isShiftActive = false);
                }
              },
            );
          }).toList(),
        );
      },
    );
  }

  IconData? _mapIcon(String? iconName) {
    if (iconName == null) return null;
    const map = {
      'backspace': Icons.backspace_outlined,
      'tab': Icons.tab,
      'caps': Icons.keyboard_capslock,
      'enter': Icons.keyboard_return,
      'shift': Icons.arrow_upward,
    };
    return map[iconName];
  }
}
