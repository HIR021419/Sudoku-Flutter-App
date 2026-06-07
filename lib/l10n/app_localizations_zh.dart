// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => '数独';

  @override
  String get homeChooseDifficulty => '选择难度';

  @override
  String get homeResumeTitle => '继续游戏';

  @override
  String get homePlayButton => '开始';

  @override
  String get difficultyEasy => '简单';

  @override
  String get difficultyMedium => '中等';

  @override
  String get difficultyHard => '困难';

  @override
  String get difficultyExpert => '专家';

  @override
  String difficultyCluesCount(int count) {
    return '$count 个提示数字';
  }

  @override
  String get winTitle => '恭喜！';

  @override
  String winSubtitle(String difficulty) {
    return '$difficulty数独已完成。';
  }

  @override
  String get winStatTime => '时间';

  @override
  String get winStatErrors => '错误';

  @override
  String get winStatHints => '提示';

  @override
  String winEffectiveTime(String time) {
    return '最终用时：$time（含罚时）';
  }

  @override
  String get winBackHome => '返回主页';

  @override
  String get dailyTitle => '每日挑战';

  @override
  String get dailyCardPlay => '来玩今天的题目';

  @override
  String dailyCardWon(String time) {
    return '用时 $time 完成';
  }

  @override
  String get dailyCardComeBack => '明天再来挑战新题目';

  @override
  String get dailyAbandonTitle => '放弃今天的挑战？';

  @override
  String get dailyAbandonMessage => '每天只有一次机会：如果现在退出，今天的挑战将丢失，直到明天。';

  @override
  String get leaderboardsTitle => '排行榜';

  @override
  String get achievementsTitle => '成就';

  @override
  String achievementsUnlockedSnack(String names) {
    return '解锁成就：$names';
  }

  @override
  String get achFirstWinTitle => '首胜';

  @override
  String get achFirstWinDesc => '完成你的第一道题。';

  @override
  String get achNoMistakeTitle => '零失误';

  @override
  String get achNoMistakeDesc => '在没有任何错误的情况下获胜。';

  @override
  String get achNoHintTitle => '无提示';

  @override
  String get achNoHintDesc => '在没有任何提示的情况下获胜。';

  @override
  String get achGames10Title => '10 局';

  @override
  String get achGames10Desc => '完成 10 道题。';

  @override
  String get achGames50Title => '50 局';

  @override
  String get achGames50Desc => '完成 50 道题。';

  @override
  String get achGames100Title => '100 局';

  @override
  String get achGames100Desc => '完成 100 道题。';

  @override
  String get achAllDifficultiesTitle => '全能玩家';

  @override
  String get achAllDifficultiesDesc => '在全部四个难度中获胜。';

  @override
  String get achDailyFirstTitle => '完成挑战';

  @override
  String get achDailyFirstDesc => '完成一次每日挑战。';

  @override
  String get achDailyStreak7Title => '完美一周';

  @override
  String get achDailyStreak7Desc => '连续 7 天完成每日挑战。';

  @override
  String get achFastEasyTitle => '闪电（简单）';

  @override
  String get achFastEasyDesc => '在 10 分钟内完成简单题目。';

  @override
  String get achFastMediumTitle => '闪电（中等）';

  @override
  String get achFastMediumDesc => '在 12 分钟内完成中等题目。';

  @override
  String get achFastHardTitle => '闪电（困难）';

  @override
  String get achFastHardDesc => '在 15 分钟内完成困难题目。';

  @override
  String get achFastExpertTitle => '闪电（专家）';

  @override
  String get achFastExpertDesc => '在 20 分钟内完成专家题目。';

  @override
  String get toolbarUndo => '撤销';

  @override
  String get toolbarErase => '擦除';

  @override
  String get toolbarNotes => '笔记';

  @override
  String get toolbarFast => '快速';

  @override
  String get toolbarHint => '提示';

  @override
  String get toolbarValidate => '检查';

  @override
  String toolbarActiveSuffix(String label) {
    return '$label（已选中）';
  }

  @override
  String get gridSemanticLabel => '9 乘 9 数独网格';

  @override
  String winStatSemanticLabel(String label, String value) {
    return '$label：$value';
  }

  @override
  String get savedCorruptedSnackbar => '存档损坏，游戏已清除。';

  @override
  String get statsTitle => '统计';

  @override
  String get statsBestTime => '最佳时间';

  @override
  String statsGamesSolved(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 局',
      zero: '暂无对局',
    );
    return '$_temp0';
  }

  @override
  String get statsNoRecord => '—';

  @override
  String get settingsTitle => '设置';

  @override
  String get settingsSound => '声音';

  @override
  String get settingsHaptic => '触觉反馈';

  @override
  String get settingsShowHintButton => '显示提示按钮';

  @override
  String get settingsShowHintButtonDescription => '关闭后，提示按钮将从工具栏隐藏。';

  @override
  String get settingsTheme => '主题';

  @override
  String get settingsValidationMode => '错误检查';

  @override
  String get validationModeAutoCheck => '自动检查';

  @override
  String get validationModeAutoCheckDescription => '经典模式。输入即时显示错误。';

  @override
  String get validationModeValidate => '手动检查';

  @override
  String get validationModeValidateDescription => '使用专用按钮检查当前网格。';

  @override
  String get validationModeNoCheck => '不检查';

  @override
  String get validationModeNoCheckDescription => '仅在网格完全填满时自动检查错误。';

  @override
  String get leaveGameTitle => '放弃当前游戏？';

  @override
  String get leaveGameMessage => '当前游戏将丢失，并从继续游戏中移除。';

  @override
  String get leaveGameCancel => '继续游戏';

  @override
  String get leaveGameConfirm => '放弃';

  @override
  String numberPadToggleNote(int number) {
    return '添加或移除笔记 $number';
  }

  @override
  String numberPadDeactivate(int number) {
    return '取消 $number';
  }

  @override
  String numberPadEnter(int number) {
    return '输入 $number';
  }

  @override
  String tileSemanticPosition(int row, int col) {
    return '单元格 第 $row 行 第 $col 列';
  }

  @override
  String get tileSemanticEmpty => '空';

  @override
  String tileSemanticNotes(String notes) {
    return '笔记 $notes';
  }

  @override
  String tileSemanticValue(int value) {
    return '值 $value';
  }

  @override
  String get tileSemanticGiven => '初始';

  @override
  String get tileSemanticError => '错误';

  @override
  String get tileSemanticSelected => '已选中';

  @override
  String get themeSystem => '跟随系统';

  @override
  String get themeLight => '浅色';

  @override
  String get themeDark => '深色';
}
