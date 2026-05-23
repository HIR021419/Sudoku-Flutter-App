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
}
