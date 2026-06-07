// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Sudoku';

  @override
  String get homeChooseDifficulty => 'Scegli la difficoltà';

  @override
  String get homeResumeTitle => 'Riprendi partita';

  @override
  String get homePlayButton => 'Gioca';

  @override
  String get difficultyEasy => 'Facile';

  @override
  String get difficultyMedium => 'Medio';

  @override
  String get difficultyHard => 'Difficile';

  @override
  String get difficultyExpert => 'Esperto';

  @override
  String difficultyCluesCount(int count) {
    return '$count indizi';
  }

  @override
  String get winTitle => 'Congratulazioni!';

  @override
  String winSubtitle(String difficulty) {
    return 'Sudoku $difficulty risolto.';
  }

  @override
  String get winStatTime => 'Tempo';

  @override
  String get winStatErrors => 'Errori';

  @override
  String get winStatHints => 'Aiuti';

  @override
  String winEffectiveTime(String time) {
    return 'Tempo finale: $time (penalità incluse)';
  }

  @override
  String get winBackHome => 'Torna alla home';

  @override
  String get dailyTitle => 'Sfida del giorno';

  @override
  String get dailyCardPlay => 'Gioca la griglia di oggi';

  @override
  String dailyCardWon(String time) {
    return 'Risolto in $time';
  }

  @override
  String get dailyCardComeBack => 'Torna domani per una nuova griglia';

  @override
  String get dailyAbandonTitle => 'Abbandonare la sfida di oggi?';

  @override
  String get dailyAbandonMessage =>
      'Hai un solo tentativo al giorno: se esci ora, la sfida di oggi sarà persa fino a domani.';

  @override
  String get leaderboardsTitle => 'Classifiche';

  @override
  String get achievementsTitle => 'Obiettivi';

  @override
  String achievementsUnlockedSnack(String names) {
    return 'Obiettivo sbloccato: $names';
  }

  @override
  String get achFirstWinTitle => 'Prima vittoria';

  @override
  String get achFirstWinDesc => 'Risolvi la tua prima griglia.';

  @override
  String get achNoMistakeTitle => 'Senza errori';

  @override
  String get achNoMistakeDesc => 'Vinci una partita senza alcun errore.';

  @override
  String get achNoHintTitle => 'Senza aiuti';

  @override
  String get achNoHintDesc => 'Vinci una partita senza alcun aiuto.';

  @override
  String get achGames10Title => '10 partite';

  @override
  String get achGames10Desc => 'Risolvi 10 griglie.';

  @override
  String get achGames50Title => '50 partite';

  @override
  String get achGames50Desc => 'Risolvi 50 griglie.';

  @override
  String get achGames100Title => '100 partite';

  @override
  String get achGames100Desc => 'Risolvi 100 griglie.';

  @override
  String get achAllDifficultiesTitle => 'Tuttofare';

  @override
  String get achAllDifficultiesDesc =>
      'Vinci in tutte e quattro le difficoltà.';

  @override
  String get achDailyFirstTitle => 'Sfida completata';

  @override
  String get achDailyFirstDesc => 'Risolvi una sfida del giorno.';

  @override
  String get achDailyStreak7Title => 'Settimana perfetta';

  @override
  String get achDailyStreak7Desc =>
      'Risolvi la sfida del giorno per 7 giorni di fila.';

  @override
  String get achFastEasyTitle => 'Fulmine (facile)';

  @override
  String get achFastEasyDesc => 'Vinci una griglia facile in meno di 10 min.';

  @override
  String get achFastMediumTitle => 'Fulmine (medio)';

  @override
  String get achFastMediumDesc => 'Vinci una griglia media in meno di 12 min.';

  @override
  String get achFastHardTitle => 'Fulmine (difficile)';

  @override
  String get achFastHardDesc =>
      'Vinci una griglia difficile in meno di 15 min.';

  @override
  String get achFastExpertTitle => 'Fulmine (esperto)';

  @override
  String get achFastExpertDesc =>
      'Vinci una griglia esperto in meno di 20 min.';

  @override
  String get toolbarUndo => 'Annulla';

  @override
  String get toolbarErase => 'Cancella';

  @override
  String get toolbarNotes => 'Note';

  @override
  String get toolbarFast => 'Veloce';

  @override
  String get toolbarHint => 'Aiuto';

  @override
  String get toolbarValidate => 'Verifica';

  @override
  String toolbarActiveSuffix(String label) {
    return '$label (attivo)';
  }

  @override
  String get gridSemanticLabel => 'Griglia Sudoku 9 per 9';

  @override
  String winStatSemanticLabel(String label, String value) {
    return '$label: $value';
  }

  @override
  String get savedCorruptedSnackbar =>
      'Salvataggio corrotto, partita eliminata.';

  @override
  String get statsTitle => 'Statistiche';

  @override
  String get statsBestTime => 'Miglior tempo';

  @override
  String statsGamesSolved(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count partite',
      one: '1 partita',
      zero: 'Nessuna partita',
    );
    return '$_temp0';
  }

  @override
  String get statsNoRecord => '—';

  @override
  String get settingsTitle => 'Impostazioni';

  @override
  String get settingsSound => 'Suono';

  @override
  String get settingsHaptic => 'Feedback aptico';

  @override
  String get settingsShowHintButton => 'Mostra pulsante aiuto';

  @override
  String get settingsShowHintButtonDescription =>
      'Se disattivato, il pulsante aiuto è nascosto dalla barra.';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get settingsValidationMode => 'Controllo errori';

  @override
  String get validationModeAutoCheck => 'Verifica automatica';

  @override
  String get validationModeAutoCheckDescription =>
      'Modalità classica. Gli errori sono mostrati appena inseriti.';

  @override
  String get validationModeValidate => 'Verifica manuale';

  @override
  String get validationModeValidateDescription =>
      'Usa un pulsante dedicato per controllare la griglia.';

  @override
  String get validationModeNoCheck => 'Senza verifica';

  @override
  String get validationModeNoCheckDescription =>
      'Gli errori sono controllati automaticamente solo a griglia completa.';

  @override
  String get leaveGameTitle => 'Abbandonare la partita?';

  @override
  String get leaveGameMessage =>
      'La partita attuale andrà persa e rimossa dalla ripresa.';

  @override
  String get leaveGameCancel => 'Continua';

  @override
  String get leaveGameConfirm => 'Abbandona';

  @override
  String numberPadToggleNote(int number) {
    return 'Aggiungi o rimuovi la nota $number';
  }

  @override
  String numberPadDeactivate(int number) {
    return 'Disattiva $number';
  }

  @override
  String numberPadEnter(int number) {
    return 'Inserisci $number';
  }

  @override
  String tileSemanticPosition(int row, int col) {
    return 'Cella riga $row colonna $col';
  }

  @override
  String get tileSemanticEmpty => 'vuota';

  @override
  String tileSemanticNotes(String notes) {
    return 'note $notes';
  }

  @override
  String tileSemanticValue(int value) {
    return 'valore $value';
  }

  @override
  String get tileSemanticGiven => 'iniziale';

  @override
  String get tileSemanticError => 'errore';

  @override
  String get tileSemanticSelected => 'selezionata';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Chiaro';

  @override
  String get themeDark => 'Scuro';
}
