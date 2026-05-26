// ignore_for_file: invalid_annotation_target
import 'package:json_annotation/json_annotation.dart';

part 'undo_cell.g.dart';

/// Snapshot d'une cellule pour l'historique d'undo.
///
/// Sérialisé via json_serializable — regénérer avec :
///   flutter pub run build_runner build --delete-conflicting-outputs
@JsonSerializable()
class UndoCell {
  const UndoCell({
    required this.index,
    required this.value,
    required this.notes,
    required this.hasVisibleError,
    required this.isValidatedCorrect,
  });

  @JsonKey(name: 'i')
  final int index;

  @JsonKey(name: 'v')
  final int value;

  @JsonKey(name: 'n', fromJson: _notesFromJson, toJson: _notesToJson)
  final Set<int> notes;

  @JsonKey(name: 'e')
  final bool hasVisibleError;

  @JsonKey(name: 'ok')
  final bool isValidatedCorrect;

  factory UndoCell.fromJson(Map<String, dynamic> json) =>
      _$UndoCellFromJson(json);

  Map<String, dynamic> toJson() => _$UndoCellToJson(this);

  static Set<int> _notesFromJson(List<dynamic> list) =>
      list.map((e) => (e as num).toInt()).toSet();

  static List<int> _notesToJson(Set<int> notes) => notes.toList();
}

/// Une entrée d'undo regroupe toutes les cellules affectées par UNE action.
/// Pour un coup qui place une valeur, on snapshot la case cible + toutes les cases
/// de la ligne/colonne/bloc dont les notes ont été nettoyées automatiquement.
typedef UndoEntry = List<UndoCell>;
