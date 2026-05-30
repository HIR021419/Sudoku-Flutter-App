// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sudoku/entities/game_session.dart';
import 'package:sudoku/models/game_ui_state.dart';

part 'game_state.freezed.dart';

/// État complet d'une partie tel que présenté au View.
///
/// Composé de l'entité domaine ([session]), de l'UI éphémère ([ui]) et de la
/// durée capturée à la victoire ([completedDuration], non nulle après la
/// transition vers `isComplete`).
///
/// Non sérialisé directement : la persistance se fait via `session.toJson()`
/// + `ui.toJson()` mergés dans le repository (cf. `GameNotifier._flushSave`).
@freezed
abstract class GameState with _$GameState {
  const GameState._();

  const factory GameState({
    required GameSession session,
    @Default(GameUiState()) GameUiState ui,
    Duration? completedDuration,
  }) = _GameState;

  bool get isComplete => session.isComplete;
}
