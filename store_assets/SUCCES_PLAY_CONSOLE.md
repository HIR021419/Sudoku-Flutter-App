# Succès — fiches Play Console (Play Games Services)

Icônes : `achievements/<id>.png` (512 × 512, PNG 32 bits).
Nom : 100 caractères max · Description : 500 caractères max · Points : multiples de 5, total du jeu ≤ 1 000.

L'**ID Play Console** est généré par Google à la création ; garde la correspondance avec l'`AchievementId` du code (colonne « ID app ») pour le mapping de la phase 5.

| # | ID app | Type | Points |
|---|---|---|---|
| 1 | firstWin | Standard | 25 |
| 2 | noMistake | Standard | 50 |
| 3 | noHint | Standard | 50 |
| 4 | games10 | Incrémental — 10 étapes | 50 |
| 5 | games50 | Incrémental — 50 étapes | 100 |
| 6 | games100 | Incrémental — 100 étapes | 150 |
| 7 | allDifficulties | Standard | 75 |
| 8 | dailyFirst | Standard | 25 |
| 9 | dailyStreak7 | Standard (voir note) | 100 |
| 10 | fastEasy | Standard | 25 |
| 11 | fastMedium | Standard | 50 |
| 12 | fastHard | Standard | 75 |
| 13 | fastExpert | Standard | 100 |
|   | **Total** |   | **875** |

Note sur `dailyStreak7` : un succès incrémental Play Games ne peut pas redescendre. Comme la série retombe à 0 quand on rate un jour, mieux vaut un succès **standard**, débloqué quand la série atteint 7 (c'est déjà la logique de `achievements_notifier.dart`).

Aucun succès n'a besoin d'être « masqué initialement ».

---

## Français (langue par défaut)

**1. Première victoire** — `firstWin.png`
Résolvez votre toute première grille de sudoku, quelle que soit la difficulté.

**2. Sans faute** — `noMistake.png`
Terminez une grille sans commettre la moindre erreur.

**3. Sans indice** — `noHint.png`
Terminez une grille sans utiliser un seul indice.

**4. 10 parties** — `games10.png`
Résolvez 10 grilles, toutes difficultés confondues.

**5. 50 parties** — `games50.png`
Résolvez 50 grilles, toutes difficultés confondues.

**6. 100 parties** — `games100.png`
Résolvez 100 grilles, toutes difficultés confondues. Un vrai maître du sudoku !

**7. Touche-à-tout** — `allDifficulties.png`
Gagnez au moins une partie dans chacune des quatre difficultés : Facile, Moyen, Difficile et Expert.

**8. Défi relevé** — `dailyFirst.png`
Résolvez votre premier défi du jour.

**9. Semaine parfaite** — `dailyStreak7.png`
Résolvez le défi du jour 7 jours d'affilée.

**10. Éclair (facile)** — `fastEasy.png`
Gagnez une grille Facile en moins de 10 minutes (pénalités comprises).

**11. Éclair (moyen)** — `fastMedium.png`
Gagnez une grille Moyenne en moins de 12 minutes (pénalités comprises).

**12. Éclair (difficile)** — `fastHard.png`
Gagnez une grille Difficile en moins de 15 minutes (pénalités comprises).

**13. Éclair (expert)** — `fastExpert.png`
Gagnez une grille Expert en moins de 20 minutes (pénalités comprises).

---

## English (traduction)

**1. First win** — Solve your very first sudoku grid, on any difficulty.

**2. Flawless** — Complete a grid without making a single mistake.

**3. No hints** — Complete a grid without using a single hint.

**4. 10 games** — Solve 10 grids, on any difficulty.

**5. 50 games** — Solve 50 grids, on any difficulty.

**6. 100 games** — Solve 100 grids, on any difficulty. A true sudoku master!

**7. Jack of all trades** — Win at least one game on each of the four difficulties: Easy, Medium, Hard and Expert.

**8. Daily done** — Solve your first daily challenge.

**9. Perfect week** — Solve the daily challenge 7 days in a row.

**10. Lightning (easy)** — Win an Easy grid in under 10 minutes (penalties included).

**11. Lightning (medium)** — Win a Medium grid in under 12 minutes (penalties included).

**12. Lightning (hard)** — Win a Hard grid in under 15 minutes (penalties included).

**13. Lightning (expert)** — Win an Expert grid in under 20 minutes (penalties included).
