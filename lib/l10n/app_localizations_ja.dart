// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => '数独';

  @override
  String get homeChooseDifficulty => '難易度を選択';

  @override
  String get homeResumeTitle => 'ゲームを再開';

  @override
  String get homePlayButton => 'プレイ';

  @override
  String get difficultyEasy => 'やさしい';

  @override
  String get difficultyMedium => 'ふつう';

  @override
  String get difficultyHard => 'むずかしい';

  @override
  String get difficultyExpert => 'エキスパート';

  @override
  String difficultyCluesCount(int count) {
    return 'ヒント $count 個';
  }

  @override
  String get winTitle => 'おめでとうございます！';

  @override
  String winSubtitle(String difficulty) {
    return '$difficultyの数独をクリアしました。';
  }

  @override
  String get winStatTime => 'タイム';

  @override
  String get winStatErrors => 'ミス';

  @override
  String get winStatHints => 'ヒント';

  @override
  String winEffectiveTime(String time) {
    return '最終タイム：$time（ペナルティ込み）';
  }

  @override
  String get winBackHome => 'ホームに戻る';

  @override
  String get dailyTitle => 'デイリーチャレンジ';

  @override
  String get dailyCardPlay => '今日の問題に挑戦';

  @override
  String dailyCardWon(String time) {
    return '$time でクリア';
  }

  @override
  String get dailyCardComeBack => '明日また新しい問題に挑戦しよう';

  @override
  String get dailyAbandonTitle => '今日のチャレンジをやめますか？';

  @override
  String get dailyAbandonMessage => '挑戦は1日1回だけです。今やめると、今日のチャレンジは明日まで失われます。';

  @override
  String get leaderboardsTitle => 'ランキング';

  @override
  String get achievementsTitle => '実績';

  @override
  String achievementsUnlockedSnack(String names) {
    return '実績を解除：$names';
  }

  @override
  String get achFirstWinTitle => '初勝利';

  @override
  String get achFirstWinDesc => '最初の問題をクリアする。';

  @override
  String get achNoMistakeTitle => 'ノーミス';

  @override
  String get achNoMistakeDesc => 'ミスなしでクリアする。';

  @override
  String get achNoHintTitle => 'ノーヒント';

  @override
  String get achNoHintDesc => 'ヒントなしでクリアする。';

  @override
  String get achGames10Title => '10 ゲーム';

  @override
  String get achGames10Desc => '10 問クリアする。';

  @override
  String get achGames50Title => '50 ゲーム';

  @override
  String get achGames50Desc => '50 問クリアする。';

  @override
  String get achGames100Title => '100 ゲーム';

  @override
  String get achGames100Desc => '100 問クリアする。';

  @override
  String get achAllDifficultiesTitle => 'オールラウンダー';

  @override
  String get achAllDifficultiesDesc => '4つの難易度すべてでクリアする。';

  @override
  String get achDailyFirstTitle => 'チャレンジ達成';

  @override
  String get achDailyFirstDesc => 'デイリーチャレンジをクリアする。';

  @override
  String get achDailyStreak7Title => 'パーフェクトウィーク';

  @override
  String get achDailyStreak7Desc => '7日連続でデイリーチャレンジをクリアする。';

  @override
  String get achFastEasyTitle => '電光石火（やさしい）';

  @override
  String get achFastEasyDesc => 'やさしい問題を10分以内にクリアする。';

  @override
  String get achFastMediumTitle => '電光石火（ふつう）';

  @override
  String get achFastMediumDesc => 'ふつうの問題を12分以内にクリアする。';

  @override
  String get achFastHardTitle => '電光石火（むずかしい）';

  @override
  String get achFastHardDesc => 'むずかしい問題を15分以内にクリアする。';

  @override
  String get achFastExpertTitle => '電光石火（エキスパート）';

  @override
  String get achFastExpertDesc => 'エキスパートの問題を20分以内にクリアする。';

  @override
  String get toolbarUndo => '元に戻す';

  @override
  String get toolbarErase => '消去';

  @override
  String get toolbarNotes => 'メモ';

  @override
  String get toolbarFast => '高速';

  @override
  String get toolbarHint => 'ヒント';

  @override
  String get toolbarValidate => 'チェック';

  @override
  String toolbarActiveSuffix(String label) {
    return '$label（選択中）';
  }

  @override
  String get gridSemanticLabel => '9×9 の数独グリッド';

  @override
  String winStatSemanticLabel(String label, String value) {
    return '$label：$value';
  }

  @override
  String get savedCorruptedSnackbar => 'セーブが破損したため、ゲームを削除しました。';

  @override
  String get statsTitle => '統計';

  @override
  String get statsBestTime => 'ベストタイム';

  @override
  String statsGamesSolved(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ゲーム',
      zero: 'ゲームなし',
    );
    return '$_temp0';
  }

  @override
  String get statsNoRecord => '—';

  @override
  String get settingsTitle => '設定';

  @override
  String get settingsSound => 'サウンド';

  @override
  String get settingsHaptic => '触覚フィードバック';

  @override
  String get settingsShowHintButton => 'ヒントボタンを表示';

  @override
  String get settingsShowHintButtonDescription =>
      'オフにすると、ヒントボタンがツールバーから非表示になります。';

  @override
  String get settingsTheme => 'テーマ';

  @override
  String get settingsValidationMode => 'ミスのチェック';

  @override
  String get validationModeAutoCheck => '自動チェック';

  @override
  String get validationModeAutoCheckDescription => '従来モード。入力するとすぐにミスが表示されます。';

  @override
  String get validationModeValidate => '手動チェック';

  @override
  String get validationModeValidateDescription => '専用ボタンで現在のグリッドをチェックします。';

  @override
  String get validationModeNoCheck => 'チェックなし';

  @override
  String get validationModeNoCheckDescription =>
      'グリッドがすべて埋まったときのみ自動でミスをチェックします。';

  @override
  String get leaveGameTitle => '現在のゲームをやめますか？';

  @override
  String get leaveGameMessage => '現在のゲームは失われ、再開リストから削除されます。';

  @override
  String get leaveGameCancel => '続ける';

  @override
  String get leaveGameConfirm => 'やめる';

  @override
  String numberPadToggleNote(int number) {
    return 'メモ $number を追加または削除';
  }

  @override
  String numberPadDeactivate(int number) {
    return '$number を解除';
  }

  @override
  String numberPadEnter(int number) {
    return '$number を入力';
  }

  @override
  String tileSemanticPosition(int row, int col) {
    return 'セル $row 行 $col 列';
  }

  @override
  String get tileSemanticEmpty => '空';

  @override
  String tileSemanticNotes(String notes) {
    return 'メモ $notes';
  }

  @override
  String tileSemanticValue(int value) {
    return '値 $value';
  }

  @override
  String get tileSemanticGiven => '初期値';

  @override
  String get tileSemanticError => 'ミス';

  @override
  String get tileSemanticSelected => '選択中';

  @override
  String get themeSystem => 'システム';

  @override
  String get themeLight => 'ライト';

  @override
  String get themeDark => 'ダーク';
}
