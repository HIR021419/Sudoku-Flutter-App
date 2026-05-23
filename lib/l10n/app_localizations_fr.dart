// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Sudoku';

  @override
  String get homeChooseDifficulty => 'Choisis ta difficulté';

  @override
  String get homeResumeTitle => 'Reprendre la partie';

  @override
  String get homePlayButton => 'Jouer';

  @override
  String get difficultyEasy => 'Facile';

  @override
  String get difficultyMedium => 'Moyen';

  @override
  String get difficultyHard => 'Difficile';

  @override
  String get difficultyExpert => 'Expert';

  @override
  String difficultyCluesCount(int count) {
    return '$count indices';
  }

  @override
  String get winTitle => 'Félicitations !';

  @override
  String winSubtitle(String difficulty) {
    return 'Sudoku $difficulty résolu.';
  }

  @override
  String get winStatTime => 'Temps';

  @override
  String get winStatErrors => 'Erreurs';

  @override
  String get winStatHints => 'Indices';

  @override
  String get winBackHome => 'Retour à l\'accueil';

  @override
  String get toolbarUndo => 'Annuler';

  @override
  String get toolbarErase => 'Effacer';

  @override
  String get toolbarNotes => 'Notes';

  @override
  String get toolbarFast => 'Rapide';

  @override
  String get toolbarHint => 'Indice';

  @override
  String get savedCorruptedSnackbar => 'Sauvegarde corrompue, partie effacée.';
}
