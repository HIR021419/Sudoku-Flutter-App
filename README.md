# Sudoku Flutter App

Application Sudoku en Flutter avec sauvegarde automatique, statistiques locales, thème clair/sombre et plusieurs modes de contrôle des erreurs.

## Fonctionnalités

- Génération de grilles par difficulté : `Easy`, `Medium`, `Hard`, `Expert`
- Reprise automatique d'une partie en cours
- Statistiques locales par difficulté
- Thème `System`, `Light`, `Dark`
- Trois modes de validation :
  - `auto-check` : erreurs affichées immédiatement
  - `validate` : vérification via un bouton manuel
  - `no-check` : vérification automatique uniquement quand la grille est complète
- Notes, mode rapide, annulation et indices
- Confirmation avant abandon d'une partie en cours

## Lancer le projet

```bash
flutter pub get
flutter run
```

## Tests

```bash
flutter test
```

## Structure utile

- `lib/pages/` : écrans principaux
- `lib/models/` : logique de jeu, état et contrôleurs
- `lib/widgets/` : grille, toolbar, clavier numérique
- `lib/data/` : persistance locale
- `lib/l10n/` : traductions
- `docs/RELEASE.md` : notes de publication et procédure release

## Persistance

Les réglages, statistiques et sauvegardes de partie sont stockés localement via `SharedPreferences`.

## Release

La procédure de publication est documentée dans [docs/RELEASE.md](docs/RELEASE.md).
