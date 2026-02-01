import 'package:flutter/material.dart';

class KeyboardButton extends StatefulWidget {
  final String centerLabel;
  final String? leftLabel;
  final String? rightLabel;
  final List<String>? variations;
  final IconData? icon;
  final double width;
  final Color color;
  final bool isActive;
  final Function(String) onTap;
  final Function(List<String>) onLongPress;

  const KeyboardButton({
    super.key,
    required this.centerLabel,
    this.leftLabel,
    this.rightLabel,
    this.variations,
    this.icon,
    this.width = 55,
    required this.color,
    this.isActive = false,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  State<KeyboardButton> createState() => _KeyboardButtonState();
}

class _KeyboardButtonState extends State<KeyboardButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    // LOGIQUE DE COULEUR :
    // 1. Si la touche est "Active" (Shift/Caps activé) -> Elle prend la couleur grise des touches de contrôle
    // 2. Si on appuie (Pressed) -> Elle change radicalement pour montrer le clic
    // 3. Sinon -> Couleur standard (Blanc ou Gris selon le modèle)
    Color backgroundColor;
    if (widget.isActive) {
      backgroundColor = Colors.blue.shade50; // Couleur distinctive quand actif
    } else if (_isPressed) {
      backgroundColor = Colors.grey.shade400; // Couleur plus sombre au clic
    } else {
      backgroundColor = widget.color;
    }

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: () {
        widget.onTap(widget.centerLabel);
      },
      onLongPress: () {
        if (widget.variations != null && widget.variations!.isNotEmpty) {
          widget.onLongPress(widget.variations!);
        } else {
          widget.onTap(widget.centerLabel);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 80,
        ), // Animation rapide pour le clic
        width: widget.width,
        height: 55,
        margin: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(6),
          boxShadow: _isPressed || widget.isActive
              ? [] // Touche enfoncée : pas d'ombre
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    offset: const Offset(
                      0,
                      3,
                    ), // Un peu plus bas pour le look PC
                    blurRadius: 1,
                  ),
                ],
          border: Border.all(
            color: widget.isActive
                ? Colors.blue.shade300
                : Colors.grey.shade300,
            width: widget.isActive ? 2 : 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
          child: Stack(
            children: [
              // 1. Caractères secondaires (Gauche/Droite)
              if (widget.leftLabel != null || widget.rightLabel != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildLabel(widget.leftLabel ?? "", fontSize: 11),
                    _buildLabel(widget.rightLabel ?? "", fontSize: 11),
                  ],
                ),

              // 2. Contenu principal (Texte OU Icône)
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.icon != null)
                      Icon(
                        widget.icon,
                        size: 18,
                        color: widget.isActive
                            ? Colors.blue.shade900
                            : Colors.black54,
                      ),
                    if (widget.centerLabel.isNotEmpty)
                      Text(
                        widget.centerLabel,
                        style: TextStyle(
                          fontSize: widget.icon != null ? 10 : 18,
                          fontWeight: widget.isActive
                              ? FontWeight.bold
                              : FontWeight.w400,
                          color: Colors.black87,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text, {required double fontSize}) {
    return Text(
      text,
      style: TextStyle(fontSize: fontSize, color: Colors.grey.shade700),
    );
  }
}
