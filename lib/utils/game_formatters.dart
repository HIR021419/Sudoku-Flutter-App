/// Utilitaires de formatage pour l'affichage des données de jeu.
library;

/// Formate une [Duration] en HH:MM:SS si la durée dépasse une heure,
/// sinon en MM:SS.
String formatDuration(Duration d) {
  final h = d.inHours;
  final m = d.inMinutes % 60;
  final s = d.inSeconds % 60;
  final mm = m.toString().padLeft(2, '0');
  final ss = s.toString().padLeft(2, '0');
  if (h > 0) return '${h.toString().padLeft(2, '0')}:$mm:$ss';
  return '$mm:$ss';
}
