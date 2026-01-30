import 'package:flutter/material.dart';

class KeyboardButton extends StatelessWidget {
  final String centerLabel;
  final String? leftLabel;
  final String? rightLabel;
  final VoidCallback onTap;

  const KeyboardButton({
    super.key,
    required this.centerLabel,
    this.leftLabel,
    this.rightLabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60, // Légèrement élargi pour le confort visuel
        height: 55,
        margin: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              offset: const Offset(0, 2),
              blurRadius: 1,
            ),
          ],
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
          child: Stack(
            children: [
              // 1. Les caractères du haut (Gauche et Droite)
              if (leftLabel != null || rightLabel != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceBetween, // C'est ici que l'espace se crée
                  children: [
                    _buildLabel(leftLabel ?? "", isSide: true),
                    _buildLabel(rightLabel ?? "", isSide: true),
                  ],
                ),

              // 2. Le caractère principal bien au centre
              Align(
                alignment: Alignment.center,
                child: Text(
                  centerLabel,
                  style: const TextStyle(
                    fontSize: 20, // Un peu plus grand pour bien le distinguer
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text, {required bool isSide}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 11, // Taille réduite pour le style "Mac" en haut
        fontWeight: FontWeight.w300,
        color: Colors.grey.shade700,
      ),
    );
  }
}
