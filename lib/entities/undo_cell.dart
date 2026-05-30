// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sudoku/entities/_converters.dart';

part 'undo_cell.freezed.dart';
part 'undo_cell.g.dart';

/// Snapshot d'une cellule pour l'historique d'undo.
///
/// Immuable — regénérer après modification :
///   flutter pub run build_runner build --delete-conflicting-outputs
@freezed
abstract class UndoCell with _$UndoCell {
  const factory UndoCell({
    @JsonKey(name: 'i') required int index,
    @JsonKey(name: 'v') required int value,
    @JsonKey(name: 'n') @IntSetConverter() required Set<int> notes,
    @JsonKey(name: 'e') required bool hasVisibleError,
    @JsonKey(name: 'ok') required bool isValidatedCorrect,
  }) = _UndoCell;

  factory UndoCell.fromJson(Map<String, dynamic> json) =>
      _$UndoCellFromJson(json);
}

/// Une entrée d'undo regroupe toutes les cellules affectées par UNE action.
/// Pour un coup qui place une valeur, on snapshot la case cible + toutes les cases
/// de la ligne/colonne/bloc dont les notes ont été nettoyées automatiquement.
typedef UndoEntry = List<UndoCell>;
