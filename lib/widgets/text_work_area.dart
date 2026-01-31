import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextWorkArea extends StatelessWidget {
  final TextEditingController controller;

  const TextWorkArea({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5), // Fond gris très clair
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          // 1. Barre de boutons d'accès rapide (Top)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(11),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildActionButton(
                  "PARTAGER",
                  Icons.share,
                  Colors.deepPurple.shade300,
                ),
                const SizedBox(width: 8),
                _buildActionButton(
                  "INSTALLER",
                  Icons.download,
                  Colors.teal.shade400,
                ),
                const SizedBox(width: 8),
                _buildActionButton(
                  "CHERCHER",
                  Icons.search,
                  Colors.blue.shade600,
                ),
              ],
            ),
          ),

          // 2. Zone de saisie de texte
          Container(
            height: 200,
            padding: const EdgeInsets.all(12),
            color: Colors.white,
            child: TextField(
              controller: controller,
              maxLines: null, // Permet plusieurs lignes
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Écrire en Sárí ici...",
              ),
              style: const TextStyle(fontSize: 18, fontFamily: 'serif'),
            ),
          ),

          // 3. Barre d'outils d'édition (Bottom right)
          Padding(
            padding: const EdgeInsets.only(bottom: 8, right: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildEditIcon(Icons.undo, () => print("Annuler")),
                _buildEditIcon(Icons.redo, () => print("Rétablir")),
                _buildEditIcon(Icons.delete_outline, () => controller.clear()),
                _buildEditIcon(Icons.copy, () {
                  Clipboard.setData(ClipboardData(text: controller.text));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Texte copié !")),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper pour les gros boutons du haut
  Widget _buildActionButton(String label, IconData icon, Color color) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 16, color: Colors.white),
      label: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        padding: const EdgeInsets.symmetric(horizontal: 12),
      ),
    );
  }

  // Helper pour les petites icônes bleues d'édition
  Widget _buildEditIcon(IconData icon, VoidCallback onPressed) {
    return IconButton(
      icon: Icon(icon, color: Colors.indigo.shade400, size: 22),
      onPressed: onPressed,
    );
  }
}
