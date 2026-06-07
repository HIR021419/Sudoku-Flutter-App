// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Sudoku';

  @override
  String get homeChooseDifficulty => 'Elige tu dificultad';

  @override
  String get homeResumeTitle => 'Reanudar partida';

  @override
  String get homePlayButton => 'Jugar';

  @override
  String get difficultyEasy => 'Fácil';

  @override
  String get difficultyMedium => 'Medio';

  @override
  String get difficultyHard => 'Difícil';

  @override
  String get difficultyExpert => 'Experto';

  @override
  String difficultyCluesCount(int count) {
    return '$count pistas';
  }

  @override
  String get winTitle => '¡Enhorabuena!';

  @override
  String winSubtitle(String difficulty) {
    return 'Sudoku $difficulty resuelto.';
  }

  @override
  String get winStatTime => 'Tiempo';

  @override
  String get winStatErrors => 'Errores';

  @override
  String get winStatHints => 'Pistas';

  @override
  String winEffectiveTime(String time) {
    return 'Tiempo final: $time (con penalizaciones)';
  }

  @override
  String get winBackHome => 'Volver al inicio';

  @override
  String get dailyTitle => 'Reto del día';

  @override
  String get dailyCardPlay => 'Juega la cuadrícula de hoy';

  @override
  String dailyCardWon(String time) {
    return 'Resuelto en $time';
  }

  @override
  String get dailyCardComeBack => 'Vuelve mañana para una nueva cuadrícula';

  @override
  String get dailyAbandonTitle => '¿Abandonar el reto de hoy?';

  @override
  String get dailyAbandonMessage =>
      'Solo tienes un intento al día: si sales ahora, el reto de hoy se perderá hasta mañana.';

  @override
  String get leaderboardsTitle => 'Clasificaciones';

  @override
  String get achievementsTitle => 'Logros';

  @override
  String achievementsUnlockedSnack(String names) {
    return 'Logro desbloqueado: $names';
  }

  @override
  String get achFirstWinTitle => 'Primera victoria';

  @override
  String get achFirstWinDesc => 'Resuelve tu primera cuadrícula.';

  @override
  String get achNoMistakeTitle => 'Sin errores';

  @override
  String get achNoMistakeDesc => 'Gana una partida sin ningún error.';

  @override
  String get achNoHintTitle => 'Sin pistas';

  @override
  String get achNoHintDesc => 'Gana una partida sin ninguna pista.';

  @override
  String get achGames10Title => '10 partidas';

  @override
  String get achGames10Desc => 'Resuelve 10 cuadrículas.';

  @override
  String get achGames50Title => '50 partidas';

  @override
  String get achGames50Desc => 'Resuelve 50 cuadrículas.';

  @override
  String get achGames100Title => '100 partidas';

  @override
  String get achGames100Desc => 'Resuelve 100 cuadrículas.';

  @override
  String get achAllDifficultiesTitle => 'Todoterreno';

  @override
  String get achAllDifficultiesDesc => 'Gana en las cuatro dificultades.';

  @override
  String get achDailyFirstTitle => 'Reto superado';

  @override
  String get achDailyFirstDesc => 'Resuelve un reto del día.';

  @override
  String get achDailyStreak7Title => 'Semana perfecta';

  @override
  String get achDailyStreak7Desc => 'Resuelve el reto del día 7 días seguidos.';

  @override
  String get achFastEasyTitle => 'Relámpago (fácil)';

  @override
  String get achFastEasyDesc => 'Gana una cuadrícula fácil en menos de 10 min.';

  @override
  String get achFastMediumTitle => 'Relámpago (medio)';

  @override
  String get achFastMediumDesc =>
      'Gana una cuadrícula media en menos de 12 min.';

  @override
  String get achFastHardTitle => 'Relámpago (difícil)';

  @override
  String get achFastHardDesc =>
      'Gana una cuadrícula difícil en menos de 15 min.';

  @override
  String get achFastExpertTitle => 'Relámpago (experto)';

  @override
  String get achFastExpertDesc =>
      'Gana una cuadrícula experto en menos de 20 min.';

  @override
  String get toolbarUndo => 'Deshacer';

  @override
  String get toolbarErase => 'Borrar';

  @override
  String get toolbarNotes => 'Notas';

  @override
  String get toolbarFast => 'Rápido';

  @override
  String get toolbarHint => 'Pista';

  @override
  String get toolbarValidate => 'Comprobar';

  @override
  String toolbarActiveSuffix(String label) {
    return '$label (activo)';
  }

  @override
  String get gridSemanticLabel => 'Cuadrícula de Sudoku 9 por 9';

  @override
  String winStatSemanticLabel(String label, String value) {
    return '$label: $value';
  }

  @override
  String get savedCorruptedSnackbar => 'Guardado dañado, partida eliminada.';

  @override
  String get statsTitle => 'Estadísticas';

  @override
  String get statsBestTime => 'Mejor tiempo';

  @override
  String statsGamesSolved(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count partidas',
      one: '1 partida',
      zero: 'Ninguna partida',
    );
    return '$_temp0';
  }

  @override
  String get statsNoRecord => '—';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get settingsSound => 'Sonido';

  @override
  String get settingsHaptic => 'Respuesta háptica';

  @override
  String get settingsShowHintButton => 'Mostrar botón de pista';

  @override
  String get settingsShowHintButtonDescription =>
      'Si se desactiva, el botón de pista se oculta de la barra.';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get settingsValidationMode => 'Detección de errores';

  @override
  String get validationModeAutoCheck => 'Comprobación automática';

  @override
  String get validationModeAutoCheckDescription =>
      'Modo clásico. Los errores se muestran al introducirlos.';

  @override
  String get validationModeValidate => 'Comprobación manual';

  @override
  String get validationModeValidateDescription =>
      'Usa un botón para comprobar la cuadrícula actual.';

  @override
  String get validationModeNoCheck => 'Sin comprobación';

  @override
  String get validationModeNoCheckDescription =>
      'Los errores se comprueban solo cuando la cuadrícula está completa.';

  @override
  String get leaveGameTitle => '¿Abandonar la partida actual?';

  @override
  String get leaveGameMessage =>
      'La partida actual se perderá y se quitará de la sección de reanudar.';

  @override
  String get leaveGameCancel => 'Seguir jugando';

  @override
  String get leaveGameConfirm => 'Abandonar';

  @override
  String numberPadToggleNote(int number) {
    return 'Añadir o quitar la nota $number';
  }

  @override
  String numberPadDeactivate(int number) {
    return 'Desactivar $number';
  }

  @override
  String numberPadEnter(int number) {
    return 'Introducir $number';
  }

  @override
  String tileSemanticPosition(int row, int col) {
    return 'Celda fila $row columna $col';
  }

  @override
  String get tileSemanticEmpty => 'vacía';

  @override
  String tileSemanticNotes(String notes) {
    return 'notas $notes';
  }

  @override
  String tileSemanticValue(int value) {
    return 'valor $value';
  }

  @override
  String get tileSemanticGiven => 'inicial';

  @override
  String get tileSemanticError => 'error';

  @override
  String get tileSemanticSelected => 'seleccionada';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';
}
