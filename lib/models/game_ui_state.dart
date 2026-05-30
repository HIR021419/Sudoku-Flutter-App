// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_ui_state.freezed.dart';
part 'game_ui_state.g.dart';

/// État UI éphémère d'une partie : cellule sélectionnée + modes actifs.
///
/// `selectedIndex` est volontairement non persisté (vraiment éphémère).
/// `notesMode`, `fillMode`, `activeNumber` sont persistés pour préserver le
/// contexte de jeu à la reprise.
@freezed
abstract class GameUiState with _$GameUiState {
  const factory GameUiState({
    @JsonKey(includeFromJson: false, includeToJson: false) int? selectedIndex,
    @Default(false) bool notesMode,
    @Default(false) bool fillMode,
    int? activeNumber,
  }) = _GameUiState;

  factory GameUiState.fromJson(Map<String, dynamic> json) =>
      _$GameUiStateFromJson(json);

  /// Restaure les modes persistés depuis un JSON tolérant (valeurs manquantes
  /// ou mauvais types → défauts). `selectedIndex` est toujours null.
  factory GameUiState.fromJsonLenient(Map<String, dynamic> json) {
    final activeNumber = json['activeNumber'];
    final int? validNumber =
        (activeNumber is num && activeNumber >= 1 && activeNumber <= 9)
        ? activeNumber.toInt()
        : null;
    return GameUiState(
      notesMode: json['notesMode'] is bool ? json['notesMode'] as bool : false,
      fillMode: json['fillMode'] is bool ? json['fillMode'] as bool : false,
      activeNumber: validNumber,
    );
  }
}
