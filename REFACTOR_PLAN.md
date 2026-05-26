# Plan d'implémentation — Refactor Sudoku App
_Dernière mise à jour : v1.2.1 → v1.3 pre-refactor_

---

## État actuel (audit du code)

### Métriques des fichiers clés

| Fichier | Lignes | Problème principal |
|---|---|---|
| `entities/game_session.dart` | 551 | Codec + règles + undo + snapshots + géométrie |
| `pages/sudoku_page.dart` | 383 | Dialogs + effets + layout + `_formatDuration` |
| `widgets/tile_widget.dart` | 212 | Palette + sémantique + notes (extractable) |
| `widgets/stats_card_widget.dart` | 164 | `_formatDuration` dupliqué |
| `controllers/game_controller.dart` | 284 | Pipeline mutation répétée 6×, save coordinator intégré |
| `pages/settings_page.dart` | 180 | `RadioListTile` dépréciés, `_SectionCard` réutilisable |
| `widgets/resume_game_card.dart` | 133 | `_formatDuration` + `_parseDifficulty` dupliqués |
| `pages/home_page.dart` | 187 | Stable — P3 seulement |
| `widgets/number_pad_widget.dart` | 158 | `_completedNumbersMask` logique métier côté UI |

### Duplications confirmées

**`_formatDuration(Duration d) → String`** — implémentation identique dans 3 fichiers :
- `sudoku_page.dart` (lignes 226–236)
- `resume_game_card.dart` (lignes 122–132)
- `stats_card_widget.dart` (lignes 155–162)

**Calculs géométriques `row/col/box`** — inline dans 5 endroits :
- `game_session._snapshotForValue` (lignes 477–491) — calcul peers complet
- `game_session._autoCleanNotes` (lignes 514–529) — même calcul
- `game_controller.isRelated` (lignes 67–71) — row/col/box inlinés
- `sudoku_utils._isValid` (lignes 41–55) — row/col/startRow/startCol
- `tile_widget.build` (lignes 44–45) — row/col pour le label sémantique

**`_readIntList(dynamic raw) → List<int>?`** — dupliqué dans :
- `game_session.dart` (ligne 193)
- `migration_utils.dart` (ligne de helper privé)

**`_parseDifficulty`** — dans `resume_game_card.dart` seulement, mais `game_session.fromJson` fait la même lookup manuellement (`DifficultyEnum.values.where(...).firstOrNull`).

### Code mort confirmé

| Symbole | Fichier | Preuve |
|---|---|---|
| `TileStateEnum` | `entities/type/tile_state_enum.dart` | Aucune référence dans toute la lib |
| `GameController.isInitialized` | `game_controller.dart` | Non référencé côté UI ni tests |
| `GameController.uiState` | `game_controller.dart` | Non référencé côté UI ni tests |
| `GameController.initNewGame()` | `game_controller.dart` | Remplacé par `initFromGenerated()`, jamais appelé |

### Warnings `flutter analyze`

`settings_page.dart` — 6 lignes concernées (130, 131, 140, 141, 150, 151) :
```
'groupValue' is deprecated — use RadioGroup ancestor instead.
'onChanged' is deprecated — use RadioGroup to handle value change.
```

---

## Plan d'implémentation fichier par fichier

### Étape 1 — Refactors sans risque métier _(zéro impact sur la logique)_

#### 1.1 Créer `utils/game_formatters.dart` _(nouveau)_

Extraire la fonction partagée :
```dart
/// Formate une durée en HH:MM:SS (si h > 0) ou MM:SS.
String formatDuration(Duration d) {
  final h = d.inHours;
  final m = d.inMinutes % 60;
  final s = d.inSeconds % 60;
  final mm = m.toString().padLeft(2, '0');
  final ss = s.toString().padLeft(2, '0');
  if (h > 0) return '${h.toString().padLeft(2, '0')}:$mm:$ss';
  return '$mm:$ss';
}
```

**Fichiers à modifier :** `sudoku_page.dart`, `resume_game_card.dart`, `stats_card_widget.dart`
— supprimer `_formatDuration`, ajouter `import 'package:sudoku/utils/game_formatters.dart'`, remplacer les appels.

---

#### 1.2 Modifier `entities/type/difficulty_enum.dart`

Ajouter une méthode statique pour centraliser le parsing :
```dart
static DifficultyEnum? tryParse(String? raw) {
  if (raw == null) return null;
  for (final d in DifficultyEnum.values) {
    if (d.name == raw) return d;
  }
  return null;
}
```

**Fichiers à modifier :**
- `resume_game_card.dart` — supprimer `_parseDifficulty`, utiliser `DifficultyEnum.tryParse`
- `game_session.dart` (`fromJson`) — remplacer `DifficultyEnum.values.where((d) => d.name == diffName).firstOrNull` par `DifficultyEnum.tryParse(diffName)`

---

#### 1.3 Créer `utils/board_geometry.dart` _(nouveau)_

```dart
/// Géométrie du plateau Sudoku 9×9. Toutes les fonctions opèrent
/// sur un index linéaire [0..80].

int rowOf(int index) => index ~/ 9;
int colOf(int index) => index % 9;
int boxOf(int index) => (index ~/ 9 ~/ 3) * 3 + (index % 9 ~/ 3);

/// Indices de toutes les cellules de la même ligne, colonne et bloc,
/// en excluant [index] lui-même.
Iterable<int> peerIndexesOf(int index) sync* {
  final row = rowOf(index);
  final col = colOf(index);
  final boxRow = (row ~/ 3) * 3;
  final boxCol = (col ~/ 3) * 3;
  final seen = <int>{index};
  for (int i = 0; i < 9; i++) {
    final r = row * 9 + i;
    final c = i * 9 + col;
    if (seen.add(r)) yield r;
    if (seen.add(c)) yield c;
  }
  for (int r = 0; r < 3; r++) {
    for (int c = 0; c < 3; c++) {
      final idx = (boxRow + r) * 9 + (boxCol + c);
      if (seen.add(idx)) yield idx;
    }
  }
}
```

**Fichiers à modifier :**
- `game_session.dart` — `_snapshotForValue` et `_autoCleanNotes` utilisent `peerIndexesOf`
- `game_controller.dart` — `isRelated` utilise `rowOf`, `colOf`, `boxOf`
- `sudoku_utils.dart` — `_isValid` utilise `rowOf`, `colOf`, plus les constantes boxRow/boxCol
- `tile_widget.dart` — `build` utilise `rowOf`/`colOf` pour `semanticLabel`

---

### Étape 2 — Migration `json_serializable` pour `GameSession`

La toolchain est déjà présente dans `pubspec.yaml` (`json_annotation`, `json_serializable`, `build_runner`).

#### 2.0 Pré-requis : convertir `UndoCell` record → classe `@JsonSerializable`

`json_serializable` ne supporte pas les records Dart anonymes. `UndoCell` doit devenir une vraie classe dans `entities/type/undo_type.dart` :

```dart
import 'package:json_annotation/json_annotation.dart';
part 'undo_type.g.dart';

@JsonSerializable()
class UndoCell {
  const UndoCell({
    required this.index,
    required this.value,
    required this.notes,
    required this.hasVisibleError,
    required this.isValidatedCorrect,
  });

  final int index;
  final int value;
  @_IntSetConverter()
  final Set<int> notes;
  final bool hasVisibleError;
  final bool isValidatedCorrect;

  factory UndoCell.fromJson(Map<String, dynamic> json) => _$UndoCellFromJson(json);
  Map<String, dynamic> toJson() => _$UndoCellToJson(this);
}

typedef UndoEntry = List<UndoCell>;
```

Tous les usages du record `(index: ..., value: ..., notes: ..., ...)` deviennent `UndoCell(index: ..., value: ..., notes: ..., ...)`.
Tous les accès `.index`, `.value`, `.notes` restent identiques.

#### 2.1 Annoter `GameSession` avec `@JsonSerializable`

Converters nécessaires pour les types non standards :

```dart
// Converter Map<int, Set<int>> ↔ Map<String, List<int>>
class _NotesConverter implements JsonConverter<Map<int, Set<int>>, Map<String, dynamic>> { ... }

// Converter Set<int> ↔ List<int>
class _IntSetConverter implements JsonConverter<Set<int>, List<dynamic>> { ... }
```

La factory `GameSession.fromJson` wrape le code généré pour la migration :
```dart
factory GameSession.fromJson(Map<String, dynamic> json) {
  final migrated = MigrationUtils.migrateToLatest(json);
  if (migrated == null) throw const FormatException('Unknown schema version');
  return _$GameSessionFromJson(migrated);
}
```

`_readIntList` et `_readIntList` de `migration_utils.dart` → supprimer les doublons après génération.

#### 2.2 Simplifier `_snapshotForValue` et `_autoCleanNotes` _(dans game_session.dart)_

Après création de `board_geometry.dart` (Étape 1.3) et migration json_serializable, ces deux méthodes se simplifient :
- `_snapshotForValue` : boucle `peerIndexesOf` remplace les 3 boucles imbriquées
- `_autoCleanNotes` : même remplacement

#### Commandes à lancer après l'étape 2

```bash
flutter pub run build_runner build --delete-conflicting-outputs
flutter analyze
```

---

### Étape 3 — Refactor de `GameController`

#### 3.1 Extraire `_commitMutation` _(dans game_controller.dart)_

Pattern répété 6 fois :
```dart
if (changed) {
  _syncCompletedNumberState();
  _scheduleSave();
  notifyListeners();
}
```

Remplacer par :
```dart
void _commitMutation(bool changed) {
  if (!changed) return;
  _syncCompletedNumberState();
  _scheduleSave();
  notifyListeners();
}
```

Méthodes concernées : `onTileTap`, `onNumberPadTap`, `eraseCell`, `undo`, `hint`, `validateBoard`.

#### 3.2 Exposer `completedNumbersMask` depuis `GameController`

Déplacer la logique de `number_pad_widget.dart` vers le contrôleur :
```dart
// Dans GameController
int get completedNumbersMask {
  int mask = 0;
  for (int number = 1; number <= 9; number++) {
    if (session.isNumberCompleted(number)) mask |= 1 << (number - 1);
  }
  return mask;
}
```

`NumberPadWidget` retire sa fonction top-level `_completedNumbersMask` et utilise `c.completedNumbersMask` dans le `context.select`.

#### 3.3 Supprimer le code mort

- `bool get isInitialized` — supprimer
- `GameUiNotifier get uiState` — supprimer
- `void initNewGame(DifficultyEnum diff)` — supprimer (vérifier absence de références externes avant)

#### 3.4 Extraire `GameSaveCoordinator` _(optionnel, P2)_

Si `game_controller.dart` reste > 220 lignes après 3.1–3.3, extraire dans `models/game_save_coordinator.dart` :
- `_scheduleSave()`
- `_flushSave()`
- `flushSave()`
- La logique `_onUiChanged` côté persistance

Sinon, laisser dans le contrôleur (cohérence fonctionnelle forte avec `_session`).

---

### Étape 4 — Allègement de `SudokuPage`

#### 4.1 Créer `pages/sudoku_dialogs.dart` _(nouveau)_

Extraire les dialogs comme fonctions libres :
```dart
Future<void> showWinDialog(BuildContext context, {
  required Duration duration,
  required int errors,
  required int hints,
  required String difficultyLabel,
});

Future<bool> showAbandonDialog(BuildContext context);
```

`_WinStat` → `widgets/game/win_stat.dart` ou dans `sudoku_dialogs.dart` selon la taille.

**Impact sur `sudoku_page.dart`** : `_showWinDialog` et `_showAbandonDialog` deviennent des appels délégués. La page garde la logique de navigation (`_handleExitAttempt`).

#### 4.2 Extraire le layout _(optionnel, Étape 4 P3)_

`_buildPortrait`, `_buildLandscape`, `_shakingGrid` → `pages/sudoku_layout.dart` ou widget `SudokuLayout`.

Pré-requis : évaluer si `sudoku_page.dart` reste > 250 lignes après 4.1. Si oui, extraire.

---

### Étape 5 — Refactor UI secondaire

#### 5.1 Fix `RadioListTile` dans `settings_page.dart` _(warnings flutter analyze)_

Migrer les 3 groupes RadioListTile (validation mode) vers `RadioGroup` :
```dart
RadioGroup<ValidationModeEnum>(
  groupValue: settings.validationMode,
  onChanged: (value) {
    if (value != null) controller.setValidationMode(value);
  },
  children: [
    RadioListTile(...),
    RadioListTile(...),
    RadioListTile(...),
  ],
)
```

Lignes concernées : 126–155. Zéro impact fonctionnel.

#### 5.2 Créer `widgets/app_card.dart` _(nouveau)_

Mutualiser le pattern `Material + borderRadius(14) + color` :
```dart
class AppCard extends StatelessWidget {
  const AppCard({super.key, required this.children, this.color});
  // color null → surfaceContainerLow (défaut)
  // AppCard.primary → primaryContainer
}
```

`_SectionCard` de `settings_page.dart` et le `Material` de `stats_card_widget.dart` et `resume_game_card.dart` utilisent `AppCard`.

#### 5.3 Extraire `app/app_theme.dart` _(nouveau, optionnel)_

`SudokuApp._buildTheme` est compact (20 lignes) mais croîtra avec les futurs thèmes v2.
```dart
class AppTheme {
  static ThemeData build(Brightness brightness) { ... }
}
```

#### 5.4–5.6 Extraction `TileWidget` _(optionnel, P3)_

Si `tile_widget.dart` doit être découpé :
- `widgets/game/tile_palette.dart` ← `_backgroundColor`, `_textColor`
- `widgets/game/tile_notes_grid.dart` ← `_buildNotes`
- `widgets/game/tile_semantics.dart` ← `_buildSemanticLabel`

---

### Étape 6 — Nettoyage final

- Supprimer `entities/type/tile_state_enum.dart`
- Vérifier `flutter analyze` → objectif : 0 warning
- Harmoniser les imports (pas de `package:` relatifs)
- Revue finale de la structure de dossiers

---

## Structure cible

```
lib/
  app/
    app_theme.dart                    ← nouveau (Étape 5.3, optionnel)

  entities/
    game_session.dart                 ← allégé (Étapes 2.1, 2.2)
    game_session_codec.dart           ← nouveau (Étape 2.1)
    game_session_rules.dart           ← nouveau optionnel (Étape 2.3)
    game_session_migration.dart       ← renommer migration_utils ? (stable)
    type/
      difficulty_enum.dart            ← modifier : ajouter tryParse (Étape 1.2)
      theme_preference_enum.dart      ← stable
      validation_mode_enum.dart       ← stable
      undo_type.dart                  ← stable
      # tile_state_enum.dart          ← SUPPRIMÉ (Étape 6)

  utils/
    board_geometry.dart               ← nouveau (Étape 1.3)
    game_formatters.dart              ← nouveau (Étape 1.1)
    migration_utils.dart              ← modifier : utiliser _readIntList partagé
    sudoku_utils.dart                 ← modifier : utiliser board_geometry

  models/
    game_ui_notifier.dart             ← stable
    game_save_coordinator.dart        ← nouveau optionnel (Étape 3.4)

  controllers/
    game_controller.dart              ← modifier (Étapes 3.1–3.3)
    settings_controller.dart          ← stable
    stats_controller.dart             ← stable

  pages/
    home_page.dart                    ← stable (P3)
    settings_page.dart                ← modifier (Étapes 5.1, 5.2)
    sudoku_page.dart                  ← modifier (Étape 4.1, délègue dialogs)
    sudoku_dialogs.dart               ← nouveau (Étape 4.1)
    sudoku_layout.dart                ← nouveau optionnel (Étape 4.2)

  widgets/
    app_card.dart                     ← nouveau (Étape 5.2)
    difficulty_selector_widget.dart   ← stable
    game_toolbar_widget.dart          ← stable
    number_pad_widget.dart            ← modifier (Étape 3.2)
    resume_game_card.dart             ← modifier (Étapes 1.1, 1.2)
    stats_card_widget.dart            ← modifier (Étape 1.1)
    sudoku_grid_widget.dart           ← stable
    tile_widget.dart                  ← modifier (Étape 1.3) + optionnel (5.4–5.6)
    game/
      win_stat.dart                   ← nouveau (Étape 4.1)
      tile_palette.dart               ← nouveau optionnel (Étape 5.4)
      tile_notes_grid.dart            ← nouveau optionnel (Étape 5.5)
      tile_semantics.dart             ← nouveau optionnel (Étape 5.6)
```

---

## Ordre d'exécution recommandé

| # | Tâche | Risque | Impact |
|---|---|---|---|
| 1 | Créer `game_formatters.dart`, màj 3 fichiers | Nul | -60 lignes dupliquées |
| 2 | Ajouter `DifficultyEnum.tryParse`, màj 2 fichiers | Nul | Parsing centralisé |
| 3 | Créer `board_geometry.dart`, màj 5 fichiers | Faible | -50 lignes dupliquées |
| 4 | Fix `RadioListTile` → `RadioGroup` | Nul | 0 warning flutter analyze |
| 5 | Supprimer code mort (`tile_state_enum`, `isInitialized`, `uiState`, `initNewGame`) | Faible | Dette technique |
| 6 | Extraire `_commitMutation` dans `GameController` | Faible | Lisibilité contrôleur |
| 7 | Exposer `completedNumbersMask` dans `GameController` | Faible | MVVM correct |
| 8 | Extraire codec `GameSession` → `game_session_codec.dart` | Moyen | -120 lignes `game_session` |
| 9 | Simplifier `_snapshotForValue`/`_autoCleanNotes` avec `peerIndexesOf` | Faible | -30 lignes |
| 10 | Extraire dialogs `SudokuPage` → `sudoku_dialogs.dart` | Moyen | -80 lignes `sudoku_page` |
| 11 | Créer `AppCard`, màj 3 fichiers | Faible | UI harmonisée |
| 12 | Optionnel : `AppTheme`, `GameSaveCoordinator`, découpage `TileWidget`, `SudokuLayout` | Variable | — |

---

## Notes importantes pour l'implémentation

**Accès aux champs privés de `GameSession` pour le codec :** Dart n'a pas de visibilité `package` stricte au niveau de la bibliothèque — tout fichier dans `lib/` peut accéder aux membres publics. Le constructeur nommé interne `GameSession._fromDecoded(...)` reste la meilleure approche, exposé via le même fichier ou un part/part of si nécessaire.

**`_readIntList` partagé :** Au moment d'extraire le codec, factoriser en une seule fonction dans `game_session_codec.dart` et supprimer le doublon de `migration_utils.dart`.

**Ordre de la migration dans `fromJson` :** `MigrationUtils.migrateToLatest(json)` DOIT être appelé avant le parsing — cet ordre est critique et doit être préservé dans le codec.

**Aucun changement d'API publique** pour les étapes 1 à 4 : tous les widgets et pages continuent d'utiliser `GameController` exactement comme avant.

**`flutter analyze` après chaque étape** — en particulier après l'étape 2 (codec) et l'étape 3 (suppression code mort).

**`services/` vs `controllers/`** : Il existe deux fichiers dans `lib/services/` (`settings_controller.dart`, `stats_controller.dart`) qui semblent être des doublons ou vestiges de `lib/controllers/`. À vérifier et nettoyer.
