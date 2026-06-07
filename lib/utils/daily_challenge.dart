/// Paramètres et helpers du défi du jour (#1).
///
/// Décisions produit : difficulté **fixe (moyenne)**, **une seule tentative
/// scorée par jour**. La grille est générée de façon **déterministe** à partir
/// d'une seed dérivée de la date **UTC** → même grille pour tous les joueurs,
/// sans backend.
library;

import 'package:sudoku/entities/type/difficulty_enum.dart';

/// Difficulté du défi du jour (fixe).
const DifficultyEnum dailyDifficulty = DifficultyEnum.medium;

/// Clé de jour normalisée `yyyy-MM-dd` en **UTC** (cohérence inter-fuseaux).
String dailyDateKey(DateTime now) {
  final utc = now.toUtc();
  final m = utc.month.toString().padLeft(2, '0');
  final d = utc.day.toString().padLeft(2, '0');
  return '${utc.year}-$m-$d';
}

/// Seed déterministe dérivée de la date UTC (ex. 2026-06-01 → 20260601).
int dailySeed(DateTime now) {
  final utc = now.toUtc();
  return utc.year * 10000 + utc.month * 100 + utc.day;
}

/// Vrai si [current] (clé `yyyy-MM-dd`) est le lendemain immédiat de
/// [previous]. Utilisé pour la série de défis du jour (#3).
bool isNextDay(String previous, String current) {
  final p = DateTime.tryParse(previous);
  final c = DateTime.tryParse(current);
  if (p == null || c == null) return false;
  return c.difference(p).inDays == 1;
}
