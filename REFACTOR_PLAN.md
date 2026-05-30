# Plan d'implémentation — Refactor Sudoku App
_Dernière mise à jour : 2026-05-30 — UI tweak HomePage (settings sticky)_

---

## 🎨 Tweak UI 2026-05-30 — Bouton settings HomePage

### Contexte
Sur mobile, l'`AppBar` de `HomePage` masquait le haut de l'écran et
n'apportait aucune valeur (un seul bouton settings). Remplacée par une
icône flottante en `Positioned(top: 8, right: 8)` au-dessus du contenu.

### Changements
- `lib/pages/home_page.dart` :
  - Suppression de `Scaffold.appBar` (`AppBar` + `IconButton` settings).
  - `body` enveloppé dans `Stack` à l'intérieur du `SafeArea`.
  - Ajout d'un `Positioned` top-right avec `IconButton` settings
    (`iconSize: 30`, `padding: 10`) — légèrement plus grand que le default
    Material (24).
  - Extraction de la navigation vers `SettingsPage` dans une closure locale
    `openSettings()` pour éviter la duplication.

- `ScrollConfiguration` + `_NoScrollbarBehavior` (privé en fin de fichier)
  pour masquer la scrollbar du `SingleChildScrollView` principal.

### Reste à faire
- (rien) — valider visuellement sur device après `flutter run`.

---

## 🆕 Phase v3 — Migration provider → Riverpod 2 (en cours)

### Contexte
La phase v2 a posé une fondation immuable freezed. La phase v3 remplace le
package `provider` par `flutter_riverpod` 2.x avec **codegen**
(`riverpod_generator`). Les `ChangeNotifier` deviennent des `Notifier` /
`AsyncNotifier` Riverpod.

### Direction validée
- **Codegen** : `@riverpod` annotation partout (provider auto-généré).
- **Scope `GameNotifier`** : `autoDispose` + lifecycle Riverpod (créé quand
  `SudokuPage` s'abonne, disposé à la sortie). Plus d'instanciation manuelle
  dans `HomePage`.
- **Une seule passe** : tout migrer d'un coup, validation finale via
  `build_runner` + `flutter analyze`.

### Architecture cible
```
lib/
  controllers/
    settings_notifier.dart     🔁 AsyncNotifier<Settings>
    stats_notifier.dart        🔁 AsyncNotifier<Stats>
    game_notifier.dart         🔁 Notifier<GameState> autoDispose
  models/
    game_state.dart            🆕 freezed (session + ui + completedDuration)
    game_ui_state.dart         🆕 freezed (selection + modes)
    game_session_runtime.dart  ✅ inchangé
    game_ui_notifier.dart      ❌ supprimé (état repris par GameState)
  providers/
    repositories.dart          🆕 @riverpod pour repos (keepAlive)
  entities/                    ✅ inchangé
```

### Suivi

| # | Étape | Statut |
|---|---|---|
| v3.1 | pubspec + ProviderScope | ✅ |
| v3.2 | Providers de repositories | ✅ |
| v3.3 | SettingsNotifier | ✅ |
| v3.4 | StatsNotifier | ✅ |
| v3.5 | GameUiState freezed | ✅ |
| v3.6 | GameNotifier autoDispose | ✅ |
| v3.7 | Migration pages + widgets | ✅ |
| v3.8 | build_runner + analyze | ⏳ à lancer côté dev |
| v3.9 | Migration SudokuPage + HomePage vers HookConsumerWidget | ✅ |

### Fichiers ajoutés / supprimés

🆕 Ajoutés :
- `lib/providers/repositories.dart`
- `lib/controllers/settings_notifier.dart`
- `lib/controllers/stats_notifier.dart`
- `lib/controllers/game_notifier.dart`
- `lib/models/game_ui_state.dart`
- `lib/models/game_state.dart`
- `lib/pages/sudoku_page_init.dart` (sealed NewGameInit / RestoreGameInit)

❌ Supprimés :
- `lib/controllers/settings_controller.dart`
- `lib/controllers/stats_controller.dart`
- `lib/controllers/game_controller.dart`
- `lib/models/game_ui_notifier.dart`

### Points clés du design

- **Hooks Riverpod (v3.9)** : `SudokuPage` et `HomePage` sont des
  `HookConsumerWidget`. State local via `useState`, `useRef`,
  `useAnimationController`, `useMemoized` + `useEffect`. Plus de
  `ConsumerStatefulWidget` / `TickerProviderStateMixin`. Tous les autres
  widgets restent `ConsumerWidget` (pas de hook utilisé donc pas de bénéfice).
  Import unifié sur `package:hooks_riverpod/hooks_riverpod.dart` (qui
  re-exporte `flutter_riverpod`).
- **Provider lifecycle** : `gameNotifierProvider` est en autoDispose. `SudokuPage`
  reçoit un `SudokuPageInit` (sealed `NewGameInit` ou `RestoreGameInit`) et
  init le notifier dans un `useEffect` au premier frame via
  `WidgetsBinding.instance.addPostFrameCallback`. Frame initiale : state = null
  → loader → bootstrap → rebuild avec state.
- **Settings / Stats** : `AsyncNotifier<T>` avec `keepAlive: true` (singletons
  applicatifs). `valueOrNull` + fallback `Settings()` / `Stats.empty()` partout
  pour éviter le flicker pendant le load initial.
- **GameState immuable** : freezed combinant `session` + `ui` + `completedDuration`.
  Pas de `toJson` côté GameState — la persistance reste éclatée
  (`session.toJson()` + `ui.toJson()` mergés dans `_flushSave`).
- **Granularité watch** : `ref.watch(provider.select(...))` partout pour ne
  reconstruire que les widgets dépendant des sous-champs modifiés. Le
  `_TileVm` dans `tile_widget.dart` est un record (equality structurelle).

### À faire côté dev

```bash
del pubspec.lock
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter analyze
flutter test
```

Cible : 0 erreur, 0 warning. Adapter `test/game_session_test.dart` si nécessaire
(la signature de l'entité n'a pas changé en v3, donc en principe rien à toucher).

### Note dépendances — versions épinglées (chaîne analyzer 7-8)

Le pubspec navigue dans un goulot d'étranglement provoqué par la bascule
analyzer 7 → 9+ dans l'écosystème Dart en 2025 :
- `riverpod_generator` (toutes versions) est plafonné à analyzer 7-8.
- `freezed >=3.2.5` exige analyzer 9+ → incompatible.
- `freezed 3.0.x / 3.1.x` sont restés sur analyzer 7-8 → c'est la fenêtre
  utilisable, on s'y range avec une borne explicite `<3.2.0`.
- `riverpod_generator 2.6.5` exige `freezed_annotation ^3.0.0` via une dép
  transitive (`riverpod_analyzer_utils 0.5.10`) → impossible de rester en
  freezed_annotation 2.x.
- `json_serializable >=6.13.1` est passé sur analyzer 10+ → on contraint
  `<6.13.1`.

Pubspec retenu :
- `json_annotation: ^4.9.0`
- `freezed_annotation: ^3.0.0` / `freezed: '>=3.0.0 <3.2.0'`
- `json_serializable: '>=6.9.0 <6.10.0'`
- `build_runner: ^2.4.13`
- `flutter_riverpod` / `riverpod_annotation` / `hooks_riverpod`: `^2.6.1`
- `riverpod_generator: ^2.6.5`
- `flutter_hooks: ^0.21.2`

Le code reste sur la **syntaxe freezed 3.x** (`abstract class Foo with _$Foo`).
Pour bumper plus tard à freezed >=3.2.5, il faudra attendre que Riverpod 3.0
stable sorte et bumpe son analyzer.

---

## Phase v2 — Entités immuables + freezed — TERMINÉE
_v2.0 — session 2026-05-28_

### Contexte
Après la phase v1 (split, dédup, json_serializable partiel), trois conventions
de sérialisation coexistent :
- `UndoCell` : `@JsonSerializable` complet (clean)
- `GameSession` : `@JsonSerializable(createToJson: false, constructor: '_')` + `toJson` manuel + `.g.dart` **écrit à la main** (fragile)
- `Settings`, `Stats`, `DifficultyStats` : 100% manuel

**Décision :** uniformiser sur **freezed + json_serializable** pour toutes les
entités, et préparer le terrain Riverpod 2 (immuabilité, `Notifier<T>`,
`state = state.copyWith(...)`).

### Direction validée
- `GameSession` devient **immuable freezed**. Toutes les méthodes métier
  (`applyValue`, `eraseCell`, `toggleNote`, `undo`, `applyHint`, `validateBoard`)
  retournent une **nouvelle** `GameSession`.
- `isComplete` et `completedDuration` deviennent des **getters calculés**
  (plus de champs mutables, plus de `@JsonKey(includeFromJson: false)`).
- Le `Stopwatch` sort de l'entité vers `models/game_session_runtime.dart`,
  détenu par le `GameController`. `elapsedAtRestore` reste dans l'entité.
- `schemaVersion` n'est plus un champ ni une constante encodée dans `toJson` :
  c'est le **repository** qui l'injecte au save et la migration qui le lit au load.
- `UndoCell`, `Settings`, `Stats`, `DifficultyStats` migrent en freezed avec
  `toJson`/`fromJson` générés.
- **Migrations strictes** par entité : sur version inconnue ou JSON corrompu →
  on jette et on repart sur défauts (pas de best-effort silencieux).

### Architecture cible
```
lib/
  entities/
    _converters.dart           🆕 DurationMs, IntSet, NotesMap (partagés)
    _schema_versions.dart      🆕 kGameSession/Settings/Stats SchemaVersion
    game_session.dart          🔁 freezed immuable + méthodes pures
    settings.dart              🔁 freezed
    stats.dart                 🔁 freezed (Stats + DifficultyStats)
    undo_cell.dart             🔁 freezed
    migrations/
      game_session_migration.dart   🆕
      settings_migration.dart       🆕
      stats_migration.dart          🆕
    type/                      stable
  models/
    game_session_runtime.dart  🆕 Stopwatch + elapsed calculé
    game_ui_notifier.dart      stable
  controllers/
    game_controller.dart       🔁 pilote immuable + runtime
    settings_controller.dart   ✅ déjà compatible
    stats_controller.dart      ✅ déjà compatible
  utils/
    migration_utils.dart       ❌ SUPPRIMÉ (remplacé par entities/migrations/)
```

### Suivi — ✅ tout terminé

| # | Étape | Statut |
|---|---|---|
| 0 | `_converters.dart` + `_schema_versions.dart` | ✅ |
| 1 | `UndoCell` freezed | ✅ |
| 2 | `Settings` + `Stats` freezed | ✅ |
| 3 | `GameSession` freezed immuable | ✅ |
| 4 | `GameSessionRuntime` + GameController réécrit | ✅ |
| 5 | Migrations par entité, `migration_utils.dart` supprimé | ✅ |
| 6 | `build_runner` + `flutter analyze` + smoke tests | ✅ |

### Validation (session 2026-05-28)

```
dart run build_runner build
> freezed   : 4 outputs (game_session, settings, stats, undo_cell)
> json_serializable : 4 outputs
> source_gen:combining : 4 outputs
Built 12 outputs in 5s — zéro erreur.

flutter analyze
> 3 issues (toutes mineures, traitées) :
  - 2 dangling library doc comments (board_geometry.dart, game_formatters.dart)
    → ajout d'une directive `library;`
  - 1 unnecessary_non_null_assertion dans game_session_test.dart
    → test réécrit pour aligner avec l'API immuable (mutations chaînées
      via `session = session.applyValue(...)` + migration explicite).
```

### Bénéfices observés

- **Sérialisation** : 100% `freezed + json_serializable`, plus aucun `.g.dart`
  écrit à la main. `dart run build_runner build` est rejouable à l'identique.
- **Immuabilité** : `GameSession`, `Settings`, `Stats`, `DifficultyStats`,
  `UndoCell` sont tous immuables. Plus de fuite d'état mutable hors du
  contrôleur.
- **Séparation domaine / runtime** : le `Stopwatch` a quitté `GameSession`
  pour rejoindre `models/game_session_runtime.dart`. L'entité est désormais
  pure et testable sans Stubs temporels.
- **Migrations** : 3 fichiers dédiés dans `entities/migrations/`. Stratégie
  **stricte** assumée : sur version inconnue → reset propre.
- **Prêt Riverpod 2** : `GameController` pilote déjà une entité immuable via
  un pattern `_apply(newSession)`. Le passage à `Notifier<GameSessionState>`
  consistera à remplacer `_session` + `notifyListeners()` par `state = ...`.

---

## Phase v1 — TERMINÉE (référence)

_v1.3 — session 2026-05-27_

---

## Métriques avant / après

| Fichier | Avant | Après | Δ |
|---|---|---|---|
| `pages/sudoku_page.dart` | 383 | 170 | −213 |
| `entities/game_session.dart` | 551 | 492 | −59 |
| `controllers/game_controller.dart` | 284 | 277 | −7 |
| `pages/settings_page.dart` | 180 | 163 | −17 |
| `widgets/stats_card_widget.dart` | 164 | 155 | −9 |
| `widgets/resume_game_card.dart` | 133 | 112 | −21 |
| `widgets/number_pad_widget.dart` | 158 | −∼15 | via extract |

**Fichiers créés :** `game_formatters.dart`, `board_geometry.dart`, `undo_cell.dart`, `undo_cell.g.dart`, `sudoku_dialogs.dart`, `sudoku_layout.dart`, `app_card.dart`

**Fichiers supprimés :** `tile_state_enum.dart`, `undo_type.dart`, `undo_type.g.dart`, `services/settings_controller.dart`, `services/stats_controller.dart`

---

## Suivi d'avancement — ✅ Tout terminé

### ✅ Étape 1 — Refactors sans risque métier

| # | Tâche | Résultat |
|---|---|---|
| 1.1 | `utils/game_formatters.dart` — `formatDuration` partagé | 3 fichiers dédupliqués |
| 1.2 | `DifficultyEnum.tryParse` | Parsing centralisé |
| 1.3 | `utils/board_geometry.dart` — `rowOf/colOf/boxOf/peerIndexesOf` | 5 fichiers dédupliqués |

### ✅ Étape 2 — Sérialisation `UndoCell` + `GameSession`

| # | Tâche | Résultat |
|---|---|---|
| 2.0 | `UndoCell` record → classe `@JsonSerializable` dans `entities/undo_cell.dart` | `.g.dart` généré |
| 2.1 | Tous les champs privés de `GameSession` passés en public | `notes`, `undoStack`, `revealedErrors`, `validatedCorrect`, `errorCount`, `hintsUsed`, `elapsedAtRestore`, `isComplete`, `completedDuration` |
| 2.2 | `@JsonSerializable(createToJson: false, constructor: '_')` sur `GameSession` | `game_session.g.dart` écrit à la main (build_runner à relancer) |
| 2.3 | 4 converters : `_DifficultyConverter`, `_IntSetConverter`, `_NotesConverter`, `_UndoStackConverter` | Types custom sérialisés proprement |
| 2.4 | `_snapshotForValue` / `_autoCleanNotes` simplifiés avec `peerIndexesOf` | −30 lignes |

> **Architecture :** `createToJson: false` — `toJson` reste manuel car il encode
> `schemaVersion` (constante) et `elapsedMs = elapsed.inMilliseconds` (valeur calculée
> Stopwatch + restore, pas seulement `elapsedAtRestore`).
> `_stopwatch` reste privé (état runtime non sérialisable).
> `isComplete` et `completedDuration` : `@JsonKey(includeFromJson: false)` — non présents
> dans le JSON, initialisés à `false`/`null` à la restauration.

### ✅ Étape 3 — Refactor de `GameController`

| # | Tâche | Résultat |
|---|---|---|
| 3.1 | `_commitMutation` extrait | Pipeline mutation factorisé |
| 3.2 | `completedNumbersMask` exposé | Logique métier hors widget |
| 3.3 | Code mort supprimé | `isInitialized`, `uiState`, `initNewGame`, `TileStateEnum`, `lib/services/` |
| 3.4 | `GameSaveCoordinator` | **Abandonné** — couplage trop fort avec `_session`/`_ui`, gain marginal |

### ✅ Étape 4 — Allègement de `SudokuPage`

| # | Tâche | Résultat |
|---|---|---|
| 4.1 | `pages/sudoku_dialogs.dart` | `showWinDialog`, `showAbandonDialog`, `WinStat` |
| 4.2 | `pages/sudoku_layout.dart` | `SudokuGameLayout`, `_ShakingGrid` |

`sudoku_page.dart` : 383 → 170 lignes (lifecycle + callbacks + Scaffold uniquement).

### ✅ Étape 5 — Refactor UI

| # | Tâche | Résultat |
|---|---|---|
| 5.1 | Fix `RadioListTile` → `RadioGroup` dans `settings_page.dart` | 0 warning dépréciation |
| 5.2 | `widgets/app_card.dart` + màj `settings_page`, `stats_card_widget`, `resume_game_card` | Pattern `Material + borderRadius(14)` mutualisé |
| 5.3 | `app/app_theme.dart` | **Reporté v2** — fichier trop compact pour justifier l'extraction |
| 5.4–5.6 | Découpage `TileWidget` | **Reporté v2** — widget stable, pas de bug, P3 |

### ✅ Étape 6 — Nettoyage final

- [x] Zéro import relatif dans `lib/`
- [x] Zéro référence à `_SectionCard`, `undo_type`, `tile_state_enum`, `lib/services/`
- [x] Structure de dossiers conforme à la cible
- [ ] **À faire par le développeur :** `flutter pub run build_runner build --delete-conflicting-outputs` puis `flutter analyze` → objectif 0 warning

---

## Structure finale

```
lib/
  controllers/
    game_controller.dart          ✅ _commitMutation, completedNumbersMask, code mort supprimé
    settings_controller.dart      stable
    stats_controller.dart         stable

  entities/
    game_session.dart             ✅ champs publics + @JsonSerializable(createToJson: false)
    game_session.g.dart           ✅ écrit à la main — relancer build_runner
    settings.dart                 stable
    stats.dart                    stable
    undo_cell.dart                ✅ @JsonSerializable (déplacé depuis entities/type/)
    undo_cell.g.dart              ✅ généré
    type/
      difficulty_enum.dart        ✅ tryParse ajouté
      theme_preference_enum.dart  stable
      validation_mode_enum.dart   stable
      # tile_state_enum.dart      ✅ SUPPRIMÉ

  models/
    game_ui_notifier.dart         stable

  pages/
    home_page.dart                stable
    settings_page.dart            ✅ RadioGroup + AppCard
    sudoku_dialogs.dart           ✅ nouveau
    sudoku_layout.dart            ✅ nouveau
    sudoku_page.dart              ✅ 383 → 170 lignes

  repositories/
    game_repository.dart          stable
    settings_repository.dart      stable
    stats_repository.dart         stable

  utils/
    board_geometry.dart           ✅ nouveau
    game_formatters.dart          ✅ nouveau
    migration_utils.dart          stable
    sudoku_utils.dart             ✅ màj (peerIndexesOf)

  widgets/
    app_card.dart                 ✅ nouveau
    difficulty_selector_widget.dart  stable
    game_toolbar_widget.dart      stable
    number_pad_widget.dart        ✅ completedNumbersMask depuis contrôleur
    resume_game_card.dart         ✅ formatDuration + tryParse + AppCard
    stats_card_widget.dart        ✅ formatDuration + AppCard
    sudoku_grid_widget.dart       stable
    tile_widget.dart              ✅ rowOf/colOf/boxOf
```

---

## Ce qui reste pour v2

| Item | Raison du report |
|---|---|
| `app/app_theme.dart` | 20 lignes — extraction prématurée sans thèmes multiples |
| Découpage `TileWidget` | Stable, fonctionnel, P3 |
| `GameSaveCoordinator` | Couplage fort avec `_session`/`_ui`, gain marginal |
| `@JsonSerializable` sur `toJson` de `GameSession` | `schemaVersion` et `elapsed.inMilliseconds` ne sont pas des champs — toJson reste manuel |
| Riverpod 2.x | Évaluation séparée |
| Isolate persistence | v2 feature |

## ⚠️ Action requise par le développeur

```bash
flutter pub run build_runner build --delete-conflicting-outputs
flutter analyze
```

Le fichier `game_session.g.dart` a été écrit à la main. `build_runner` le regénérera
proprement et pourra le modifier légèrement (formatage, ordre des paramètres).
`undo_cell.g.dart` est déjà généré et stable.
