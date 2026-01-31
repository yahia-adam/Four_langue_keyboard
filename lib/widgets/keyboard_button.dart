import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class KeyboardButton extends StatelessWidget {
  final String? centerLabel;
  final String? leftLabel;
  final String? rightLabel;
  final IconData? icon; // Pour les icônes (Delete, Shift, etc.)
  final double width; // Largeur ajustable
  final Color? color; // Couleur de fond (blanc ou gris)
  final VoidCallback onTap;

  const KeyboardButton({
    super.key,
    this.centerLabel,
    this.leftLabel,
    this.rightLabel,
    this.icon,
    this.width = 55, // Par défaut 55, mais on pourra mettre 80 ou 100
    this.color = Colors.white,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width, // Utilisation de la largeur personnalisée
        height: 55,
        margin: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: color,
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
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
          child: Stack(
            children: [
              // Caractères en haut
              if (leftLabel != null || rightLabel != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildLabel(leftLabel ?? "", fontSize: 11),
                    _buildLabel(rightLabel ?? "", fontSize: 11),
                  ],
                ),

              // Contenu principal (Texte OU Icône)
              // Dans le build du KeyboardButton, remplace l'Align central par ceci :
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (icon != null)
                      Icon(icon, size: 16, color: Colors.black54),
                    if (centerLabel != null && centerLabel!.isNotEmpty)
                      Text(
                        centerLabel!,
                        style: TextStyle(
                          fontSize: icon != null
                              ? 10
                              : 18, // Plus petit si une icône est présente
                          fontWeight: FontWeight.w400,
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
