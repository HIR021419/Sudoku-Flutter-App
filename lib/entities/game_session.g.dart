// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GameSession _$GameSessionFromJson(Map<String, dynamic> json) => _GameSession(
  difficulty: $enumDecode(_$DifficultyEnumEnumMap, json['difficulty']),
  solution: (json['solution'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  userGrid: (json['userGrid'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  givens: const IntSetConverter().fromJson(json['givens'] as List),
  notes: json['notes'] == null
      ? const <int, Set<int>>{}
      : const NotesMapConverter().fromJson(
          json['notes'] as Map<String, dynamic>,
        ),
  undoStack: json['undoStack'] == null
      ? const <UndoEntry>[]
      : const _UndoStackConverter().fromJson(json['undoStack'] as List),
  revealedErrors: json['revealedErrors'] == null
      ? const <int>{}
      : const IntSetConverter().fromJson(json['revealedErrors'] as List),
  validatedCorrect: json['validatedCorrect'] == null
      ? const <int>{}
      : const IntSetConverter().fromJson(json['validatedCorrect'] as List),
  errorCount: (json['errorCount'] as num?)?.toInt() ?? 0,
  hintsUsed: (json['hintsUsed'] as num?)?.toInt() ?? 0,
  elapsedAtRestore: json['elapsedMs'] == null
      ? Duration.zero
      : const DurationMsConverter().fromJson(
          (json['elapsedMs'] as num).toInt(),
        ),
);

Map<String, dynamic> _$GameSessionToJson(
  _GameSession instance,
) => <String, dynamic>{
  'difficulty': _$DifficultyEnumEnumMap[instance.difficulty]!,
  'solution': instance.solution,
  'userGrid': instance.userGrid,
  'givens': const IntSetConverter().toJson(instance.givens),
  'notes': const NotesMapConverter().toJson(instance.notes),
  'undoStack': const _UndoStackConverter().toJson(instance.undoStack),
  'revealedErrors': const IntSetConverter().toJson(instance.revealedErrors),
  'validatedCorrect': const IntSetConverter().toJson(instance.validatedCorrect),
  'errorCount': instance.errorCount,
  'hintsUsed': instance.hintsUsed,
  'elapsedMs': const DurationMsConverter().toJson(instance.elapsedAtRestore),
};

const _$DifficultyEnumEnumMap = {
  DifficultyEnum.easy: 'easy',
  DifficultyEnum.medium: 'medium',
  DifficultyEnum.hard: 'hard',
  DifficultyEnum.expert: 'expert',
};
