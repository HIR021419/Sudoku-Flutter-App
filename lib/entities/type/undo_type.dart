/// Snapshot d'une cellule pour l'historique d'undo.
typedef UndoCell = ({
  int index,
  int value,
  Set<int> notes,
  bool hasVisibleError,
  bool isValidatedCorrect,
});

/// Une entrée d'undo regroupe toutes les cellules affectées par UNE action.
/// Pour un coup qui place une valeur, on snapshot la case cible + toutes les cases
/// de la ligne/colonne/bloc dont les notes ont été nettoyées automatiquement.
typedef UndoEntry = List<UndoCell>;
