// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Sudoku';

  @override
  String get homeChooseDifficulty => 'Choose your difficulty';

  @override
  String get homeResumeTitle => 'Resume game';

  @override
  String get homePlayButton => 'Play';

  @override
  String get difficultyEasy => 'Easy';

  @override
  String get difficultyMedium => 'Medium';

  @override
  String get difficultyHard => 'Hard';

  @override
  String get difficultyExpert => 'Expert';

  @override
  String difficultyCluesCount(int count) {
    return '$count clues';
  }

  @override
  String get winTitle => 'Congratulations!';

  @override
  String winSubtitle(String difficulty) {
    return '$difficulty Sudoku solved.';
  }

  @override
  String get winStatTime => 'Time';

  @override
  String get winStatErrors => 'Errors';

  @override
  String get winStatHints => 'Hints';

  @override
  String winEffectiveTime(String time) {
    return 'Final time: $time (penalties included)';
  }

  @override
  String get winBackHome => 'Back to home';

  @override
  String get dailyTitle => 'Daily challenge';

  @override
  String get dailyCardPlay => 'Play today\'s grid';

  @override
  String dailyCardWon(String time) {
    return 'Solved in $time';
  }

  @override
  String get dailyCardComeBack => 'Come back tomorrow for a new grid';

  @override
  String get dailyAbandonTitle => 'Abandon today\'s challenge?';

  @override
  String get dailyAbandonMessage =>
      'You only get one attempt per day: if you leave now, today\'s challenge is lost until tomorrow.';

  @override
  String get leaderboardsTitle => 'Leaderboards';

  @override
  String get achievementsTitle => 'Achievements';

  @override
  String achievementsUnlockedSnack(String names) {
    return 'Achievement unlocked: $names';
  }

  @override
  String get achFirstWinTitle => 'First win';

  @override
  String get achFirstWinDesc => 'Solve your first grid.';

  @override
  String get achNoMistakeTitle => 'Flawless';

  @override
  String get achNoMistakeDesc => 'Win a game without any mistake.';

  @override
  String get achNoHintTitle => 'No hints';

  @override
  String get achNoHintDesc => 'Win a game without any hint.';

  @override
  String get achGames10Title => '10 games';

  @override
  String get achGames10Desc => 'Solve 10 grids.';

  @override
  String get achGames50Title => '50 games';

  @override
  String get achGames50Desc => 'Solve 50 grids.';

  @override
  String get achGames100Title => '100 games';

  @override
  String get achGames100Desc => 'Solve 100 grids.';

  @override
  String get achAllDifficultiesTitle => 'Jack of all';

  @override
  String get achAllDifficultiesDesc => 'Win on all four difficulties.';

  @override
  String get achDailyFirstTitle => 'Daily done';

  @override
  String get achDailyFirstDesc => 'Solve a daily challenge.';

  @override
  String get achDailyStreak7Title => 'Perfect week';

  @override
  String get achDailyStreak7Desc =>
      'Solve the daily challenge 7 days in a row.';

  @override
  String get achFastEasyTitle => 'Lightning (easy)';

  @override
  String get achFastEasyDesc => 'Win an easy grid in under 10 min.';

  @override
  String get achFastMediumTitle => 'Lightning (medium)';

  @override
  String get achFastMediumDesc => 'Win a medium grid in under 12 min.';

  @override
  String get achFastHardTitle => 'Lightning (hard)';

  @override
  String get achFastHardDesc => 'Win a hard grid in under 15 min.';

  @override
  String get achFastExpertTitle => 'Lightning (expert)';

  @override
  String get achFastExpertDesc => 'Win an expert grid in under 20 min.';

  @override
  String get toolbarUndo => 'Undo';

  @override
  String get toolbarErase => 'Erase';

  @override
  String get toolbarNotes => 'Notes';

  @override
  String get toolbarFast => 'Fast';

  @override
  String get toolbarHint => 'Hint';

  @override
  String get toolbarValidate => 'Validate';

  @override
  String toolbarActiveSuffix(String label) {
    return '$label (active)';
  }

  @override
  String get gridSemanticLabel => 'Sudoku grid 9 by 9';

  @override
  String winStatSemanticLabel(String label, String value) {
    return '$label: $value';
  }

  @override
  String get savedCorruptedSnackbar => 'Save corrupted, game cleared.';

  @override
  String get statsTitle => 'Statistics';

  @override
  String get statsBestTime => 'Best time';

  @override
  String statsGamesSolved(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count games',
      one: '1 game',
      zero: 'No games',
    );
    return '$_temp0';
  }

  @override
  String get statsNoRecord => '—';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsSound => 'Sound';

  @override
  String get settingsHaptic => 'Haptic feedback';

  @override
  String get settingsShowHintButton => 'Show hint button';

  @override
  String get settingsShowHintButtonDescription =>
      'When disabled, the hint button is hidden from the toolbar.';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get settingsValidationMode => 'Error checking';

  @override
  String get validationModeAutoCheck => 'Auto-check';

  @override
  String get validationModeAutoCheckDescription =>
      'Legacy mode. Errors are shown as soon as you enter them.';

  @override
  String get validationModeValidate => 'Validate';

  @override
  String get validationModeValidateDescription =>
      'Use a dedicated button to check the current grid.';

  @override
  String get validationModeNoCheck => 'No-check';

  @override
  String get validationModeNoCheckDescription =>
      'Errors are checked automatically only when the grid is fully filled.';

  @override
  String get leaveGameTitle => 'Abandon current game?';

  @override
  String get leaveGameMessage =>
      'Your current game will be lost and removed from the resume section.';

  @override
  String get leaveGameCancel => 'Keep playing';

  @override
  String get leaveGameConfirm => 'Abandon';

  @override
  String numberPadToggleNote(int number) {
    return 'Add or remove note $number';
  }

  @override
  String numberPadDeactivate(int number) {
    return 'Deactivate $number';
  }

  @override
  String numberPadEnter(int number) {
    return 'Enter $number';
  }

  @override
  String tileSemanticPosition(int row, int col) {
    return 'Cell row $row column $col';
  }

  @override
  String get tileSemanticEmpty => 'empty';

  @override
  String tileSemanticNotes(String notes) {
    return 'notes $notes';
  }

  @override
  String tileSemanticValue(int value) {
    return 'value $value';
  }

  @override
  String get tileSemanticGiven => 'given';

  @override
  String get tileSemanticError => 'error';

  @override
  String get tileSemanticSelected => 'selected';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';
}
