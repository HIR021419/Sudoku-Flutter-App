enum DifficultyEnum {
  easy,
  medium,
  hard,
  expert;

  String get label => switch (this) {
        DifficultyEnum.easy => 'Facile',
        DifficultyEnum.medium => 'Moyen',
        DifficultyEnum.hard => 'Difficile',
        DifficultyEnum.expert => 'Expert',
      };

  int get clues => switch (this) {
        DifficultyEnum.easy => 40,
        DifficultyEnum.medium => 32,
        DifficultyEnum.hard => 26,
        DifficultyEnum.expert => 22,
      };

  /// Retourne la valeur correspondant à [raw] (comparaison sur `.name`),
  /// ou null si [raw] est null ou ne correspond à aucune valeur connue.
  static DifficultyEnum? tryParse(String? raw) {
    if (raw == null) return null;
    for (final d in DifficultyEnum.values) {
      if (d.name == raw) return d;
    }
    return null;
  }
}
