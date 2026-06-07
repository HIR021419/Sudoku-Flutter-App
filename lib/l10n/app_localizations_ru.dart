// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Судоку';

  @override
  String get homeChooseDifficulty => 'Выберите сложность';

  @override
  String get homeResumeTitle => 'Продолжить игру';

  @override
  String get homePlayButton => 'Играть';

  @override
  String get difficultyEasy => 'Лёгкий';

  @override
  String get difficultyMedium => 'Средний';

  @override
  String get difficultyHard => 'Сложный';

  @override
  String get difficultyExpert => 'Эксперт';

  @override
  String difficultyCluesCount(int count) {
    return 'Подсказок: $count';
  }

  @override
  String get winTitle => 'Поздравляем!';

  @override
  String winSubtitle(String difficulty) {
    return 'Судоку «$difficulty» решено.';
  }

  @override
  String get winStatTime => 'Время';

  @override
  String get winStatErrors => 'Ошибки';

  @override
  String get winStatHints => 'Подсказки';

  @override
  String winEffectiveTime(String time) {
    return 'Итоговое время: $time (со штрафами)';
  }

  @override
  String get winBackHome => 'На главную';

  @override
  String get dailyTitle => 'Ежедневный вызов';

  @override
  String get dailyCardPlay => 'Сыграйте сегодняшнюю головоломку';

  @override
  String dailyCardWon(String time) {
    return 'Решено за $time';
  }

  @override
  String get dailyCardComeBack => 'Возвращайтесь завтра за новой головоломкой';

  @override
  String get dailyAbandonTitle => 'Покинуть сегодняшний вызов?';

  @override
  String get dailyAbandonMessage =>
      'У вас только одна попытка в день: если выйти сейчас, сегодняшний вызов будет потерян до завтра.';

  @override
  String get leaderboardsTitle => 'Таблицы лидеров';

  @override
  String get achievementsTitle => 'Достижения';

  @override
  String achievementsUnlockedSnack(String names) {
    return 'Достижение получено: $names';
  }

  @override
  String get achFirstWinTitle => 'Первая победа';

  @override
  String get achFirstWinDesc => 'Решите свою первую головоломку.';

  @override
  String get achNoMistakeTitle => 'Без ошибок';

  @override
  String get achNoMistakeDesc => 'Выиграйте партию без единой ошибки.';

  @override
  String get achNoHintTitle => 'Без подсказок';

  @override
  String get achNoHintDesc => 'Выиграйте партию без единой подсказки.';

  @override
  String get achGames10Title => '10 партий';

  @override
  String get achGames10Desc => 'Решите 10 головоломок.';

  @override
  String get achGames50Title => '50 партий';

  @override
  String get achGames50Desc => 'Решите 50 головоломок.';

  @override
  String get achGames100Title => '100 партий';

  @override
  String get achGames100Desc => 'Решите 100 головоломок.';

  @override
  String get achAllDifficultiesTitle => 'Мастер на все руки';

  @override
  String get achAllDifficultiesDesc =>
      'Победите на всех четырёх уровнях сложности.';

  @override
  String get achDailyFirstTitle => 'Вызов принят';

  @override
  String get achDailyFirstDesc => 'Решите ежедневный вызов.';

  @override
  String get achDailyStreak7Title => 'Идеальная неделя';

  @override
  String get achDailyStreak7Desc => 'Решайте ежедневный вызов 7 дней подряд.';

  @override
  String get achFastEasyTitle => 'Молния (лёгкий)';

  @override
  String get achFastEasyDesc =>
      'Выиграйте лёгкую головоломку менее чем за 10 мин.';

  @override
  String get achFastMediumTitle => 'Молния (средний)';

  @override
  String get achFastMediumDesc =>
      'Выиграйте среднюю головоломку менее чем за 12 мин.';

  @override
  String get achFastHardTitle => 'Молния (сложный)';

  @override
  String get achFastHardDesc =>
      'Выиграйте сложную головоломку менее чем за 15 мин.';

  @override
  String get achFastExpertTitle => 'Молния (эксперт)';

  @override
  String get achFastExpertDesc =>
      'Выиграйте головоломку уровня «эксперт» менее чем за 20 мин.';

  @override
  String get toolbarUndo => 'Отменить';

  @override
  String get toolbarErase => 'Стереть';

  @override
  String get toolbarNotes => 'Заметки';

  @override
  String get toolbarFast => 'Быстро';

  @override
  String get toolbarHint => 'Подсказка';

  @override
  String get toolbarValidate => 'Проверить';

  @override
  String toolbarActiveSuffix(String label) {
    return '$label (активно)';
  }

  @override
  String get gridSemanticLabel => 'Поле судоку 9 на 9';

  @override
  String winStatSemanticLabel(String label, String value) {
    return '$label: $value';
  }

  @override
  String get savedCorruptedSnackbar => 'Сохранение повреждено, игра удалена.';

  @override
  String get statsTitle => 'Статистика';

  @override
  String get statsBestTime => 'Лучшее время';

  @override
  String statsGamesSolved(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count партий',
      many: '$count партий',
      few: '$count партии',
      one: '$count партия',
      zero: 'Нет партий',
    );
    return '$_temp0';
  }

  @override
  String get statsNoRecord => '—';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get settingsSound => 'Звук';

  @override
  String get settingsHaptic => 'Тактильная отдача';

  @override
  String get settingsShowHintButton => 'Показывать кнопку подсказки';

  @override
  String get settingsShowHintButtonDescription =>
      'Если выключено, кнопка подсказки скрыта на панели.';

  @override
  String get settingsTheme => 'Тема';

  @override
  String get settingsValidationMode => 'Проверка ошибок';

  @override
  String get validationModeAutoCheck => 'Автопроверка';

  @override
  String get validationModeAutoCheckDescription =>
      'Классический режим. Ошибки показываются сразу при вводе.';

  @override
  String get validationModeValidate => 'Ручная проверка';

  @override
  String get validationModeValidateDescription =>
      'Отдельная кнопка для проверки текущего поля.';

  @override
  String get validationModeNoCheck => 'Без проверки';

  @override
  String get validationModeNoCheckDescription =>
      'Ошибки проверяются автоматически только при полностью заполненном поле.';

  @override
  String get leaveGameTitle => 'Покинуть текущую игру?';

  @override
  String get leaveGameMessage =>
      'Текущая игра будет потеряна и удалена из раздела продолжения.';

  @override
  String get leaveGameCancel => 'Продолжить';

  @override
  String get leaveGameConfirm => 'Покинуть';

  @override
  String numberPadToggleNote(int number) {
    return 'Добавить или убрать заметку $number';
  }

  @override
  String numberPadDeactivate(int number) {
    return 'Отключить $number';
  }

  @override
  String numberPadEnter(int number) {
    return 'Ввести $number';
  }

  @override
  String tileSemanticPosition(int row, int col) {
    return 'Ячейка, строка $row, столбец $col';
  }

  @override
  String get tileSemanticEmpty => 'пусто';

  @override
  String tileSemanticNotes(String notes) {
    return 'заметки $notes';
  }

  @override
  String tileSemanticValue(int value) {
    return 'значение $value';
  }

  @override
  String get tileSemanticGiven => 'начальная';

  @override
  String get tileSemanticError => 'ошибка';

  @override
  String get tileSemanticSelected => 'выбрана';

  @override
  String get themeSystem => 'Системная';

  @override
  String get themeLight => 'Светлая';

  @override
  String get themeDark => 'Тёмная';
}
