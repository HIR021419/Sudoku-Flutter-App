const int kSessionSchemaVersion = 2;

class MigrationUtils {
  static Map<String, dynamic>? migrateToLatest(Map<String, dynamic> json) {
    final version = (json['schemaVersion'] as num?)?.toInt();
    return switch (version) {
      1 => _migrateV1ToV2(json),
      kSessionSchemaVersion => Map<String, dynamic>.from(json),
      _ => null,
    };
  }

  static Map<String, dynamic>? _migrateV1ToV2(Map<String, dynamic> json) {
    final solution = _readIntList(json['solution']);
    final userGrid = _readIntList(json['userGrid']);
    final givensList = _readIntList(json['givens']);
    if (solution == null || solution.length != 81) return null;
    if (userGrid == null || userGrid.length != 81) return null;
    if (givensList == null) return null;

    final givens = givensList.toSet();
    final revealedErrors = <int>[];
    final validatedCorrect = <int>[];

    for (int i = 0; i < 81; i++) {
      if (givens.contains(i)) continue;
      final value = userGrid[i];
      if (value == 0) continue;
      if (value == solution[i]) {
        validatedCorrect.add(i);
      } else {
        revealedErrors.add(i);
      }
    }

    return {
      ...json,
      'schemaVersion': kSessionSchemaVersion,
      'revealedErrors': revealedErrors,
      'validatedCorrect': validatedCorrect,
    };
  }

  static List<int>? _readIntList(dynamic raw) {
    if (raw is! List) return null;
    final result = <int>[];
    for (final value in raw) {
      if (value is! num) return null;
      result.add(value.toInt());
    }
    return result;
  }
}
