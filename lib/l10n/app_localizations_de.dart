// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Sudoku';

  @override
  String get homeChooseDifficulty => 'Wähle deinen Schwierigkeitsgrad';

  @override
  String get homeResumeTitle => 'Spiel fortsetzen';

  @override
  String get homePlayButton => 'Spielen';

  @override
  String get difficultyEasy => 'Leicht';

  @override
  String get difficultyMedium => 'Mittel';

  @override
  String get difficultyHard => 'Schwer';

  @override
  String get difficultyExpert => 'Experte';

  @override
  String difficultyCluesCount(int count) {
    return '$count Hinweise';
  }

  @override
  String get winTitle => 'Glückwunsch!';

  @override
  String winSubtitle(String difficulty) {
    return 'Sudoku $difficulty gelöst.';
  }

  @override
  String get winStatTime => 'Zeit';

  @override
  String get winStatErrors => 'Fehler';

  @override
  String get winStatHints => 'Hinweise';

  @override
  String winEffectiveTime(String time) {
    return 'Endzeit: $time (inkl. Strafen)';
  }

  @override
  String get winBackHome => 'Zurück zum Start';

  @override
  String get dailyTitle => 'Tägliche Herausforderung';

  @override
  String get dailyCardPlay => 'Spiele das heutige Rätsel';

  @override
  String dailyCardWon(String time) {
    return 'Gelöst in $time';
  }

  @override
  String get dailyCardComeBack => 'Komm morgen für ein neues Rätsel wieder';

  @override
  String get dailyAbandonTitle => 'Heutige Herausforderung abbrechen?';

  @override
  String get dailyAbandonMessage =>
      'Du hast nur einen Versuch pro Tag: Wenn du jetzt gehst, ist die heutige Herausforderung bis morgen verloren.';

  @override
  String get leaderboardsTitle => 'Bestenlisten';

  @override
  String get achievementsTitle => 'Erfolge';

  @override
  String achievementsUnlockedSnack(String names) {
    return 'Erfolg freigeschaltet: $names';
  }

  @override
  String get achFirstWinTitle => 'Erster Sieg';

  @override
  String get achFirstWinDesc => 'Löse dein erstes Rätsel.';

  @override
  String get achNoMistakeTitle => 'Fehlerfrei';

  @override
  String get achNoMistakeDesc => 'Gewinne ein Spiel ohne Fehler.';

  @override
  String get achNoHintTitle => 'Ohne Hinweise';

  @override
  String get achNoHintDesc => 'Gewinne ein Spiel ohne Hinweise.';

  @override
  String get achGames10Title => '10 Spiele';

  @override
  String get achGames10Desc => 'Löse 10 Rätsel.';

  @override
  String get achGames50Title => '50 Spiele';

  @override
  String get achGames50Desc => 'Löse 50 Rätsel.';

  @override
  String get achGames100Title => '100 Spiele';

  @override
  String get achGames100Desc => 'Löse 100 Rätsel.';

  @override
  String get achAllDifficultiesTitle => 'Alleskönner';

  @override
  String get achAllDifficultiesDesc =>
      'Gewinne in allen vier Schwierigkeitsgraden.';

  @override
  String get achDailyFirstTitle => 'Herausforderung gemeistert';

  @override
  String get achDailyFirstDesc => 'Löse eine tägliche Herausforderung.';

  @override
  String get achDailyStreak7Title => 'Perfekte Woche';

  @override
  String get achDailyStreak7Desc =>
      'Löse die tägliche Herausforderung an 7 Tagen in Folge.';

  @override
  String get achFastEasyTitle => 'Blitz (leicht)';

  @override
  String get achFastEasyDesc => 'Gewinne ein leichtes Rätsel in unter 10 Min.';

  @override
  String get achFastMediumTitle => 'Blitz (mittel)';

  @override
  String get achFastMediumDesc =>
      'Gewinne ein mittleres Rätsel in unter 12 Min.';

  @override
  String get achFastHardTitle => 'Blitz (schwer)';

  @override
  String get achFastHardDesc => 'Gewinne ein schweres Rätsel in unter 15 Min.';

  @override
  String get achFastExpertTitle => 'Blitz (Experte)';

  @override
  String get achFastExpertDesc =>
      'Gewinne ein Experten-Rätsel in unter 20 Min.';

  @override
  String get toolbarUndo => 'Rückgängig';

  @override
  String get toolbarErase => 'Löschen';

  @override
  String get toolbarNotes => 'Notizen';

  @override
  String get toolbarFast => 'Schnell';

  @override
  String get toolbarHint => 'Hinweis';

  @override
  String get toolbarValidate => 'Prüfen';

  @override
  String toolbarActiveSuffix(String label) {
    return '$label (aktiv)';
  }

  @override
  String get gridSemanticLabel => 'Sudoku-Gitter 9 mal 9';

  @override
  String winStatSemanticLabel(String label, String value) {
    return '$label: $value';
  }

  @override
  String get savedCorruptedSnackbar =>
      'Speicherung beschädigt, Spiel gelöscht.';

  @override
  String get statsTitle => 'Statistiken';

  @override
  String get statsBestTime => 'Bestzeit';

  @override
  String statsGamesSolved(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Spiele',
      one: '1 Spiel',
      zero: 'Keine Spiele',
    );
    return '$_temp0';
  }

  @override
  String get statsNoRecord => '—';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get settingsSound => 'Ton';

  @override
  String get settingsHaptic => 'Haptisches Feedback';

  @override
  String get settingsShowHintButton => 'Hinweis-Schaltfläche anzeigen';

  @override
  String get settingsShowHintButtonDescription =>
      'Wenn deaktiviert, wird die Hinweis-Schaltfläche ausgeblendet.';

  @override
  String get settingsTheme => 'Design';

  @override
  String get settingsValidationMode => 'Fehlerprüfung';

  @override
  String get validationModeAutoCheck => 'Automatische Prüfung';

  @override
  String get validationModeAutoCheckDescription =>
      'Klassischer Modus. Fehler werden sofort bei der Eingabe angezeigt.';

  @override
  String get validationModeValidate => 'Manuelle Prüfung';

  @override
  String get validationModeValidateDescription =>
      'Eine eigene Schaltfläche prüft das aktuelle Gitter.';

  @override
  String get validationModeNoCheck => 'Ohne Prüfung';

  @override
  String get validationModeNoCheckDescription =>
      'Fehler werden erst geprüft, wenn das Gitter komplett ausgefüllt ist.';

  @override
  String get leaveGameTitle => 'Aktuelles Spiel abbrechen?';

  @override
  String get leaveGameMessage =>
      'Das aktuelle Spiel geht verloren und wird aus dem Fortsetzen-Bereich entfernt.';

  @override
  String get leaveGameCancel => 'Weiterspielen';

  @override
  String get leaveGameConfirm => 'Abbrechen';

  @override
  String numberPadToggleNote(int number) {
    return 'Notiz $number hinzufügen oder entfernen';
  }

  @override
  String numberPadDeactivate(int number) {
    return '$number deaktivieren';
  }

  @override
  String numberPadEnter(int number) {
    return '$number eingeben';
  }

  @override
  String tileSemanticPosition(int row, int col) {
    return 'Zelle Zeile $row Spalte $col';
  }

  @override
  String get tileSemanticEmpty => 'leer';

  @override
  String tileSemanticNotes(String notes) {
    return 'Notizen $notes';
  }

  @override
  String tileSemanticValue(int value) {
    return 'Wert $value';
  }

  @override
  String get tileSemanticGiven => 'vorgegeben';

  @override
  String get tileSemanticError => 'Fehler';

  @override
  String get tileSemanticSelected => 'ausgewählt';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Hell';

  @override
  String get themeDark => 'Dunkel';
}
