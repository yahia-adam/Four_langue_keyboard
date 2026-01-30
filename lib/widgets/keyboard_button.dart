import 'package:flutter/material.dart';

class KeyboardButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const KeyboardButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // Dimensions typiques d'une touche
        width: 45,
        height: 50,
        margin: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6), // Coins légèrement arrondis
          boxShadow: [
            // Ombre du bas pour l'effet 3D de la touche
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.5),
              spreadRadius: 0,
              blurRadius: 1,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(color: Colors.grey.shade300, width: 0.5),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 18,
              fontWeight: FontWeight.w400,
              fontFamily: 'sans-serif', // Proche du style Apple
            ),
          ),
        ),
      ),
    );
  }
}
