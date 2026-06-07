// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Sudoku';

  @override
  String get homeChooseDifficulty => 'Escolha a dificuldade';

  @override
  String get homeResumeTitle => 'Retomar partida';

  @override
  String get homePlayButton => 'Jogar';

  @override
  String get difficultyEasy => 'Fácil';

  @override
  String get difficultyMedium => 'Médio';

  @override
  String get difficultyHard => 'Difícil';

  @override
  String get difficultyExpert => 'Especialista';

  @override
  String difficultyCluesCount(int count) {
    return '$count pistas';
  }

  @override
  String get winTitle => 'Parabéns!';

  @override
  String winSubtitle(String difficulty) {
    return 'Sudoku $difficulty resolvido.';
  }

  @override
  String get winStatTime => 'Tempo';

  @override
  String get winStatErrors => 'Erros';

  @override
  String get winStatHints => 'Dicas';

  @override
  String winEffectiveTime(String time) {
    return 'Tempo final: $time (com penalidades)';
  }

  @override
  String get winBackHome => 'Voltar ao início';

  @override
  String get dailyTitle => 'Desafio do dia';

  @override
  String get dailyCardPlay => 'Jogue a grade de hoje';

  @override
  String dailyCardWon(String time) {
    return 'Resolvido em $time';
  }

  @override
  String get dailyCardComeBack => 'Volte amanhã para uma nova grade';

  @override
  String get dailyAbandonTitle => 'Abandonar o desafio de hoje?';

  @override
  String get dailyAbandonMessage =>
      'Você tem apenas uma tentativa por dia: se sair agora, o desafio de hoje será perdido até amanhã.';

  @override
  String get leaderboardsTitle => 'Classificações';

  @override
  String get achievementsTitle => 'Conquistas';

  @override
  String achievementsUnlockedSnack(String names) {
    return 'Conquista desbloqueada: $names';
  }

  @override
  String get achFirstWinTitle => 'Primeira vitória';

  @override
  String get achFirstWinDesc => 'Resolva sua primeira grade.';

  @override
  String get achNoMistakeTitle => 'Sem erros';

  @override
  String get achNoMistakeDesc => 'Vença uma partida sem nenhum erro.';

  @override
  String get achNoHintTitle => 'Sem dicas';

  @override
  String get achNoHintDesc => 'Vença uma partida sem nenhuma dica.';

  @override
  String get achGames10Title => '10 partidas';

  @override
  String get achGames10Desc => 'Resolva 10 grades.';

  @override
  String get achGames50Title => '50 partidas';

  @override
  String get achGames50Desc => 'Resolva 50 grades.';

  @override
  String get achGames100Title => '100 partidas';

  @override
  String get achGames100Desc => 'Resolva 100 grades.';

  @override
  String get achAllDifficultiesTitle => 'Faz-tudo';

  @override
  String get achAllDifficultiesDesc => 'Vença nas quatro dificuldades.';

  @override
  String get achDailyFirstTitle => 'Desafio cumprido';

  @override
  String get achDailyFirstDesc => 'Resolva um desafio do dia.';

  @override
  String get achDailyStreak7Title => 'Semana perfeita';

  @override
  String get achDailyStreak7Desc =>
      'Resolva o desafio do dia por 7 dias seguidos.';

  @override
  String get achFastEasyTitle => 'Relâmpago (fácil)';

  @override
  String get achFastEasyDesc => 'Vença uma grade fácil em menos de 10 min.';

  @override
  String get achFastMediumTitle => 'Relâmpago (médio)';

  @override
  String get achFastMediumDesc => 'Vença uma grade média em menos de 12 min.';

  @override
  String get achFastHardTitle => 'Relâmpago (difícil)';

  @override
  String get achFastHardDesc => 'Vença uma grade difícil em menos de 15 min.';

  @override
  String get achFastExpertTitle => 'Relâmpago (especialista)';

  @override
  String get achFastExpertDesc =>
      'Vença uma grade especialista em menos de 20 min.';

  @override
  String get toolbarUndo => 'Desfazer';

  @override
  String get toolbarErase => 'Apagar';

  @override
  String get toolbarNotes => 'Notas';

  @override
  String get toolbarFast => 'Rápido';

  @override
  String get toolbarHint => 'Dica';

  @override
  String get toolbarValidate => 'Verificar';

  @override
  String toolbarActiveSuffix(String label) {
    return '$label (ativo)';
  }

  @override
  String get gridSemanticLabel => 'Grade de Sudoku 9 por 9';

  @override
  String winStatSemanticLabel(String label, String value) {
    return '$label: $value';
  }

  @override
  String get savedCorruptedSnackbar =>
      'Salvamento corrompido, partida apagada.';

  @override
  String get statsTitle => 'Estatísticas';

  @override
  String get statsBestTime => 'Melhor tempo';

  @override
  String statsGamesSolved(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count partidas',
      one: '1 partida',
      zero: 'Nenhuma partida',
    );
    return '$_temp0';
  }

  @override
  String get statsNoRecord => '—';

  @override
  String get settingsTitle => 'Configurações';

  @override
  String get settingsSound => 'Som';

  @override
  String get settingsHaptic => 'Resposta tátil';

  @override
  String get settingsShowHintButton => 'Mostrar botão de dica';

  @override
  String get settingsShowHintButtonDescription =>
      'Quando desativado, o botão de dica fica oculto na barra.';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get settingsValidationMode => 'Verificação de erros';

  @override
  String get validationModeAutoCheck => 'Verificação automática';

  @override
  String get validationModeAutoCheckDescription =>
      'Modo clássico. Os erros aparecem assim que você os insere.';

  @override
  String get validationModeValidate => 'Verificação manual';

  @override
  String get validationModeValidateDescription =>
      'Use um botão para verificar a grade atual.';

  @override
  String get validationModeNoCheck => 'Sem verificação';

  @override
  String get validationModeNoCheckDescription =>
      'Os erros são verificados apenas quando a grade está completa.';

  @override
  String get leaveGameTitle => 'Abandonar a partida atual?';

  @override
  String get leaveGameMessage =>
      'A partida atual será perdida e removida da seção de retomar.';

  @override
  String get leaveGameCancel => 'Continuar jogando';

  @override
  String get leaveGameConfirm => 'Abandonar';

  @override
  String numberPadToggleNote(int number) {
    return 'Adicionar ou remover a nota $number';
  }

  @override
  String numberPadDeactivate(int number) {
    return 'Desativar $number';
  }

  @override
  String numberPadEnter(int number) {
    return 'Inserir $number';
  }

  @override
  String tileSemanticPosition(int row, int col) {
    return 'Célula linha $row coluna $col';
  }

  @override
  String get tileSemanticEmpty => 'vazia';

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
  String get tileSemanticError => 'erro';

  @override
  String get tileSemanticSelected => 'selecionada';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Escuro';
}
