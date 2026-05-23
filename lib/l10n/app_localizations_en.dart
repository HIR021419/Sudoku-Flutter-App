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
  String get winBackHome => 'Back to home';

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
  String get savedCorruptedSnackbar => 'Save corrupted, game cleared.';
}
