# Guide Flutter : Architecture, Dossiers et Tutoriel

Bienvenue dans le développement Flutter ! Ce fichier vous servira de référence pour comprendre comment Flutter fonctionne et comment démarrer efficacement.

## 1. L'Architecture de Flutter

### Tout est un Widget
En Flutter, presque tout est un **Widget**.
- **Visualisation** : Un bouton, du texte, une image sont des widgets.
- **Mise en page** : Les lignes (`Row`), les colonnes (`Column`), le centrage (`Center`) sont aussi des widgets.
- **Architecture** : Votre application elle-même est un widget root.

### Arbre des Widgets (Widget Tree)
Vous construisez votre interface en imbriquant des widgets les uns dans les autres (ex: Un `Container` contient un `Center` qui contient un `Text`).

### Rendu (Rendering)
Contrairement aux solutions web (HTML/CSS) ou natives classiques, Flutter dessine chaque pixel à l'écran grâce à son propre moteur de rendu (Skia ou Impeller). Cela garantit des performances élevées (60/120 fps) et une apparence identique sur toutes les plateformes.

### Gestion d'État (State Management)
*   **StatelessWidget** : Pour les éléments statiques qui ne changent jamais après leur création (ex: Une icône, un label fixe).
*   **StatefulWidget** : Pour les éléments qui changent dynamiquement (ex: Un compteur, un formulaire, une animation).

---

## 2. Dossiers et Fichiers Importants

Ouvrez votre explorateur de fichiers pour repérer ces éléments clés :

*   **`lib/`** : 🌟 **LE PLUS IMPORTANT**. C'est ici que vit 99% de votre code Dart.
    *   [main.dart](file:///home/adam/Documents/adam/pooring_bele/pooring_keyboard/lib/main.dart) : Le point d'entrée de votre application. C'est le premier fichier exécuté.
*   **[pubspec.yaml](file:///home/adam/Documents/adam/pooring_bele/pooring_keyboard/pubspec.yaml)** : 📦 Le fichier de configuration.
    *   C'est ici que vous ajoutez des dépendances (librairies), définissez la version du SDK, et déclarez des assets (images, polices).
*   **`android/`, `ios/`, `windows/`, `linux/`, `macos/`, `web/`** : **OUI, Flutter marche pour tout ça !**
    *   Ce sont les dossiers des "projets hôtes". Flutter compile ton code Dart (`lib/`) et l'injecte dans chacune de ces applications natives.
    *   Tu peux exécuter ton app sur n'importe laquelle de ces plateformes avec le même code.
    *   Tu n'as généralement pas besoin d'y toucher, sauf pour des configurations spécifiques (icônes, permissions, signature).
*   **[.gitignore](file:///home/adam/Documents/adam/pooring_bele/pooring_keyboard/.gitignore)** : Définit les fichiers à ne pas inclure dans Git.
*   **[analysis_options.yaml](file:///home/adam/Documents/adam/pooring_bele/pooring_keyboard/analysis_options.yaml)** : Configure les règles de "linter" (analyse statique) pour garder votre code propre.

---

## 3. Comment Développer (Workflow)

Flutter offre une expérience de développement ("DX") très rapide :

1.  **Lancer l'app** : Ouvrez un terminal dans votre projet et faites `flutter run` (ou appuyez sur "Run/Play" dans votre éditeur).
2.  **Hot Reload (⚡)** : C'est la magie de Flutter.
    *   Changez une couleur, un texte ou une logique dans votre code.
    *   Sauvegardez (ou appuyez sur le bouton éclair).
    *   L'application se met à jour **instantanément** sans perdre l'état (le compteur ne revient pas à zéro).
3.  **Hot Restart** : Redémarre complètement l'application (utile si vous changez l'état initial ou des dépendances majeures).

---

## 4. Pour les Développeurs Android (Kotlin / Jetpack Compose)

C'est une excellente nouvelle ! **Flutter est conceptuellement presque identique à Jetpack Compose.** Compose a d'ailleurs été fortement inspiré par Flutter.

### Jetpack Compose vs Flutter

| Concept Android (Compose) | Concept Flutter | Note |
| :--- | :--- | :--- |
| **`@Composable` fun** | **`Widget`** (class) | Au lieu de fonctions annotées, on utilise des Classes immuables. |
| **Modifier** | **Widget Parents** | En Flutter, le padding, l'alignement, etc. sont des Widgets qui enveloppent votre widget (ex: `Padding(child: Text(...))`). |
| **`State<T>` / `remember`** | **`StatefulWidget` / `setState`** | `StatefulWidget` couple un Widget et une classe State persistante. |
| **`Column`, `Row`** | **`Column`, `Row`** | Même nom, même fonctionnement. |
| **`LazyColumn`** | **`ListView.builder`** | Pour les listes infinies ou performantes. |

### Architecture : Et le MVVM ?

En Flutter, on n'utilise pas strictement le pattern "MVVM" standard d'Android (XML + ViewModel + LiveData), mais on utilise des principes très similaires de **séparation de la logique et de la vue**.

Le "ViewModel" (la classe qui tient l'état et la logique) est souvent géré par des librairies de **State Management**.

Voici les équivalents les plus populaires :

1.  **Provider / ChangeNotifier** (Le "Standard" simple)
    *   **ViewModel** -> `class MyModel extends ChangeNotifier`
    *   **LiveData** -> `notifyListeners()` (diffuse le changement)
    *   **Observer** -> `Consumer<MyModel>` (reconstruit le widget quand ça change)
2.  **Riverpod** (Le "Successeur" de Provider, très populaire et puissant)
    *   Plus sûr et flexible que Provider, très proche de ce qu'on fait en moderne Android.
3.  **BLoC / Cubit** (Business Logic Component)
    *   Très structuré, basé sur des `Streams`. Ressemble un peu à MVI (Model-View-Intent) ou à l'utilisation intensive de RxJava/Flow. C'est le favori des très grosses équipes/banques.

### Material Design

Flutter embarque son propre rendu des composants Material.
*   En Android natif, les composants dépendent de la version d'Android du téléphone (un bouton sur Android 5 est moche).
*   En Flutter, **les composants Material sont dessinés par Flutter**. Un bouton Material 3 sera identique et magnifique sur un vieux Android 8, sur iOS, ou sur Windows.

Vous avez accès à tous les widgets Material officiels via `import 'package:flutter/material.dart';`.

---

## 5. Tutoriel Rapide : "Counter App"

Votre projet actuel contient l'application par défaut "Counter App" dans [lib/main.dart](file:///home/adam/Documents/adam/pooring_bele/pooring_keyboard/lib/main.dart). Analysons-la rapidement.

### Structure [lib/main.dart](file:///home/adam/Documents/adam/pooring_bele/pooring_keyboard/lib/main.dart)

```dart
// 1. Import du package UI principal (Material Design)
import 'package:flutter/material.dart';

// 2. Point d'entrée main()
void main() {
  runApp(const MyApp()); // Lance votre Widget racine
}

// 3. Le Widget Racine (L'application elle-même)
class MyApp extends StatelessWidget {
    // ... configure le thème et la page d'accueil
}

// 4. La Page d'Accueil (Stateful car le compteur change)
// Équivalent à une Screen Composable avec un state interne
class MyHomePage extends StatefulWidget {
    // ...
}

// 5. La Logique et l'UI de la page d'accueil
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0; // State<Int>

  void _incrementCounter() {
    setState(() {
      _counter++; // myState.value++
    });
    // setState() redéclenche le build() (la recomposition)
  }

  @override
  Widget build(BuildContext context) {
    // Équivalent au corps de votre fonction @Composable
    return Scaffold( // Le "Screen" de base Material
      appBar: AppBar(title: Text(widget.title)), // TopAppBar
      body: Center(
        child: Column(
          children: [
            const Text('You have pushed the button this many times:'),
            Text('$_counter', style: ...),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

---

## 6. Déploiement (Build) - Récapitulatif

Voici le tableau complet des commandes pour générer tes exécutables de production (Mode Release).

| Plateforme | Commande Build | Sortie (Output) | Comment Lancer (Run) |
| :--- | :--- | :--- | :--- |
| **🤖 Android (APK)** | `flutter build apk` | `build/app/outputs/flutter-apk/app-release.apk` | Transférer sur le téléphone et installer. |
| **🤖 Android (Store)**| `flutter build appbundle`| `build/app/outputs/bundle/release/app-release.aab`| Uploader sur la Google Play Console. |
| **🍎 iOS** | `flutter build ipa` | `build/ios/archive/Runner.xcarchive` | Uploader via Xcode / Transporter. |
| **🐧 Linux** | `flutter build linux` | `build/linux/x64/release/bundle/` | `cd [dossier] && ./pooring_keyboard` |
| **🪟 Windows** | `flutter build windows` | `build/windows/x64/runner/Release/` | Double-cliquer sur le `.exe`. |
| **🍎 macOS** | `flutter build macos` | `build/macos/Build/Products/Release/` | Double-cliquer sur l'application `.app`. |
| **🌍 Web** | `flutter build web` | `build/web/` | `cd [dossier] && python3 -m http.server 8000` |


---

## 7. Gérer les Différences entre Plateformes

Parfois, tu veux un comportement ou une UI différente selon la plateforme (ex: un look Cupertino sur iOS et Material sur Android, ou une fonctionnalité web-only).

Flutter rend ça très facile avec des instructions conditionnelles (`if/else`).

### Vérifier la Plateforme

```dart
import 'dart:io' show Platform; // Attention: ne marche pas sur le Web
import 'package:flutter/foundation.dart' show kIsWeb;

// ...

if (kIsWeb) {
  // Spécifique au Web
  print('Je suis sur le Web !');
} else if (Platform.isAndroid) {
  // Spécifique Android
  print('Je suis un Android');
} else if (Platform.isIOS) {
  // Spécifique iOS
  print('Je suis un iPhone');
} else if (Platform.isLinux) {
  // Spécifique Linux
  print('Je suis sur Linux');
}
```

### UI Adaptative

Tu peux aussi conditionner ton affichage. C'est très courant pour les dialogues d'alerte ou les switchs.

```dart
Widget build(BuildContext context) {
  // Exemple : Switch adaptatif qui change de look automatiquement (iOS vs Android)
  return Switch.adaptive(
    value: _isSwitched,
    onChanged: (value) => setState(() => _isSwitched = value),
  );
}

// Ou manuellement :
Widget getLoadingIcon() {
  if (Platform.isIOS) {
    return CupertinoActivityIndicator(); // Spinner style iOS
  } else {
    return CircularProgressIndicator(); // Spinner style Material
  }
}
```

---

## 8. Conseils avant de commencer (Pièges à éviter ⚠️)

Venant d'Android, voici quelques pièges classiques à surveiller :

### 1. Ne bloque pas le UI Thread !
Dart est "Single Threaded" (comme Javascript).
*   **Jamais** de gros calculs ou d'appels réseaux synchrones dans le build().
*   Utilise toujours `async / await` pour tout ce qui est long (DB, API).

### 2. "BuildContext" est ton ami (et ton ennemi)
*   Le `BuildContext` est la position de ton widget dans l'arbre.
*   **Piège** : Ne jamais utiliser un `BuildContext` à travers un `await` async si le widget risque d'être détruit entre temps.
    *   *Mauvais* : `await Future.delayed(...); Navigator.of(context).pop();` (Si l'écran est fermé pendant le délai, crash !).
    *   *Bon* : `if (!context.mounted) return;` avant d'utiliser `context` après un await.

### 3. Découpe tes Widgets
*   ne fais pas un fichier `main.dart` de 2000 lignes.
*   Dès qu'une partie de ton UI se répète ou devient complexe -> **Extrais-la dans un nouveau Widget**.

### 4. Attention aux `libs` (Packages)
*   Vérifie toujours la popularité et la maintenance d'un package sur [pub.dev](https://pub.dev) avant de l'ajouter. Ne réinvente pas la roue, mais ne dépend pas de paquets abandonnés.

### 5. `setState` c'est bien, mais...
*   Pour commencer, `setState` est parfait.
*   Mais dès que ton app grossit (plusieurs écrans qui partagent des données), passe vite à un vrai State Manager (Riverpod ou Provider). Ne passe pas tes données de widget en widget sur 10 niveaux ("Prop Drilling").
