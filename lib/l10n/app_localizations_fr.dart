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
  String winEffectiveTime(String time) {
    return 'Temps retenu : $time (pénalités incluses)';
  }

  @override
  String get winBackHome => 'Retour à l\'accueil';

  @override
  String get dailyTitle => 'Défi du jour';

  @override
  String get dailyCardPlay => 'Jouez la grille du jour';

  @override
  String dailyCardWon(String time) {
    return 'Résolu en $time';
  }

  @override
  String get dailyCardComeBack => 'Revenez demain pour une nouvelle grille';

  @override
  String get dailyAbandonTitle => 'Abandonner le défi du jour ?';

  @override
  String get dailyAbandonMessage =>
      'Vous n\'avez qu\'une tentative par jour : si vous quittez maintenant, le défi du jour sera perdu jusqu\'à demain.';

  @override
  String get leaderboardsTitle => 'Classements';

  @override
  String get achievementsTitle => 'Succès';

  @override
  String achievementsUnlockedSnack(String names) {
    return 'Succès débloqué : $names';
  }

  @override
  String get achFirstWinTitle => 'Première victoire';

  @override
  String get achFirstWinDesc => 'Résoudre votre première grille.';

  @override
  String get achNoMistakeTitle => 'Sans faute';

  @override
  String get achNoMistakeDesc => 'Gagner une partie sans aucune erreur.';

  @override
  String get achNoHintTitle => 'Sans indice';

  @override
  String get achNoHintDesc => 'Gagner une partie sans aucun indice.';

  @override
  String get achGames10Title => '10 parties';

  @override
  String get achGames10Desc => 'Résoudre 10 grilles.';

  @override
  String get achGames50Title => '50 parties';

  @override
  String get achGames50Desc => 'Résoudre 50 grilles.';

  @override
  String get achGames100Title => '100 parties';

  @override
  String get achGames100Desc => 'Résoudre 100 grilles.';

  @override
  String get achAllDifficultiesTitle => 'Touche-à-tout';

  @override
  String get achAllDifficultiesDesc => 'Gagner dans les quatre difficultés.';

  @override
  String get achDailyFirstTitle => 'Défi relevé';

  @override
  String get achDailyFirstDesc => 'Résoudre un défi du jour.';

  @override
  String get achDailyStreak7Title => 'Semaine parfaite';

  @override
  String get achDailyStreak7Desc =>
      'Résoudre le défi du jour 7 jours d\'affilée.';

  @override
  String get achFastEasyTitle => 'Éclair (facile)';

  @override
  String get achFastEasyDesc => 'Gagner une grille facile en moins de 10 min.';

  @override
  String get achFastMediumTitle => 'Éclair (moyen)';

  @override
  String get achFastMediumDesc =>
      'Gagner une grille moyenne en moins de 12 min.';

  @override
  String get achFastHardTitle => 'Éclair (difficile)';

  @override
  String get achFastHardDesc =>
      'Gagner une grille difficile en moins de 15 min.';

  @override
  String get achFastExpertTitle => 'Éclair (expert)';

  @override
  String get achFastExpertDesc =>
      'Gagner une grille expert en moins de 20 min.';

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
  String get toolbarValidate => 'Vérifier';

  @override
  String toolbarActiveSuffix(String label) {
    return '$label (actif)';
  }

  @override
  String get gridSemanticLabel => 'Grille Sudoku 9 par 9';

  @override
  String winStatSemanticLabel(String label, String value) {
    return '$label : $value';
  }

  @override
  String get savedCorruptedSnackbar => 'Sauvegarde corrompue, partie effacée.';

  @override
  String get statsTitle => 'Statistiques';

  @override
  String get statsBestTime => 'Meilleur temps';

  @override
  String statsGamesSolved(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count parties',
      one: '1 partie',
      zero: 'Aucune partie',
    );
    return '$_temp0';
  }

  @override
  String get statsNoRecord => '—';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get settingsSound => 'Son';

  @override
  String get settingsHaptic => 'Retour haptique';

  @override
  String get settingsShowHintButton => 'Afficher le bouton indice';

  @override
  String get settingsShowHintButtonDescription =>
      'Si désactivé, le bouton indice n\'est pas affiché dans la barre d\'outils.';

  @override
  String get settingsTheme => 'Thème';

  @override
  String get settingsValidationMode => 'Contrôle des erreurs';

  @override
  String get validationModeAutoCheck => 'Vérification auto';

  @override
  String get validationModeAutoCheckDescription =>
      'Mode actuel. Les erreurs s\'affichent dès la saisie.';

  @override
  String get validationModeValidate => 'Validation manuelle';

  @override
  String get validationModeValidateDescription =>
      'Ajoute un bouton pour vérifier manuellement la grille en cours.';

  @override
  String get validationModeNoCheck => 'Sans vérification';

  @override
  String get validationModeNoCheckDescription =>
      'Les erreurs sont vérifiées automatiquement uniquement quand la grille est complète.';

  @override
  String get leaveGameTitle => 'Abandonner la partie en cours ?';

  @override
  String get leaveGameMessage =>
      'La partie actuelle sera perdue et retirée de la reprise de partie.';

  @override
  String get leaveGameCancel => 'Continuer';

  @override
  String get leaveGameConfirm => 'Abandonner';

  @override
  String numberPadToggleNote(int number) {
    return 'Ajouter ou retirer la note $number';
  }

  @override
  String numberPadDeactivate(int number) {
    return 'Désactiver $number';
  }

  @override
  String numberPadEnter(int number) {
    return 'Saisir $number';
  }

  @override
  String tileSemanticPosition(int row, int col) {
    return 'Cellule ligne $row colonne $col';
  }

  @override
  String get tileSemanticEmpty => 'vide';

  @override
  String tileSemanticNotes(String notes) {
    return 'notes $notes';
  }

  @override
  String tileSemanticValue(int value) {
    return 'valeur $value';
  }

  @override
  String get tileSemanticGiven => 'initiale';

  @override
  String get tileSemanticError => 'erreur';

  @override
  String get tileSemanticSelected => 'sélectionnée';

  @override
  String get themeSystem => 'Système';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeDark => 'Sombre';
}
