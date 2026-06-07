// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'सुडोकू';

  @override
  String get homeChooseDifficulty => 'अपनी कठिनाई चुनें';

  @override
  String get homeResumeTitle => 'खेल जारी रखें';

  @override
  String get homePlayButton => 'खेलें';

  @override
  String get difficultyEasy => 'आसान';

  @override
  String get difficultyMedium => 'मध्यम';

  @override
  String get difficultyHard => 'कठिन';

  @override
  String get difficultyExpert => 'विशेषज्ञ';

  @override
  String difficultyCluesCount(int count) {
    return '$count संकेत';
  }

  @override
  String get winTitle => 'बधाई हो!';

  @override
  String winSubtitle(String difficulty) {
    return '$difficulty सुडोकू हल हो गया।';
  }

  @override
  String get winStatTime => 'समय';

  @override
  String get winStatErrors => 'गलतियाँ';

  @override
  String get winStatHints => 'संकेत';

  @override
  String winEffectiveTime(String time) {
    return 'अंतिम समय: $time (दंड सहित)';
  }

  @override
  String get winBackHome => 'होम पर वापस';

  @override
  String get dailyTitle => 'दैनिक चुनौती';

  @override
  String get dailyCardPlay => 'आज की पहेली खेलें';

  @override
  String dailyCardWon(String time) {
    return '$time में हल किया';
  }

  @override
  String get dailyCardComeBack => 'नई पहेली के लिए कल वापस आएं';

  @override
  String get dailyAbandonTitle => 'आज की चुनौती छोड़ें?';

  @override
  String get dailyAbandonMessage =>
      'आपको प्रतिदिन केवल एक मौका मिलता है: अभी छोड़ने पर आज की चुनौती कल तक खो जाएगी।';

  @override
  String get leaderboardsTitle => 'लीडरबोर्ड';

  @override
  String get achievementsTitle => 'उपलब्धियाँ';

  @override
  String achievementsUnlockedSnack(String names) {
    return 'उपलब्धि अनलॉक: $names';
  }

  @override
  String get achFirstWinTitle => 'पहली जीत';

  @override
  String get achFirstWinDesc => 'अपनी पहली पहेली हल करें।';

  @override
  String get achNoMistakeTitle => 'बिना गलती';

  @override
  String get achNoMistakeDesc => 'बिना किसी गलती के एक खेल जीतें।';

  @override
  String get achNoHintTitle => 'बिना संकेत';

  @override
  String get achNoHintDesc => 'बिना किसी संकेत के एक खेल जीतें।';

  @override
  String get achGames10Title => '10 खेल';

  @override
  String get achGames10Desc => '10 पहेलियाँ हल करें।';

  @override
  String get achGames50Title => '50 खेल';

  @override
  String get achGames50Desc => '50 पहेलियाँ हल करें।';

  @override
  String get achGames100Title => '100 खेल';

  @override
  String get achGames100Desc => '100 पहेलियाँ हल करें।';

  @override
  String get achAllDifficultiesTitle => 'हरफनमौला';

  @override
  String get achAllDifficultiesDesc => 'चारों कठिनाइयों में जीतें।';

  @override
  String get achDailyFirstTitle => 'चुनौती पूरी';

  @override
  String get achDailyFirstDesc => 'एक दैनिक चुनौती हल करें।';

  @override
  String get achDailyStreak7Title => 'उत्तम सप्ताह';

  @override
  String get achDailyStreak7Desc => 'लगातार 7 दिन दैनिक चुनौती हल करें।';

  @override
  String get achFastEasyTitle => 'बिजली (आसान)';

  @override
  String get achFastEasyDesc => 'आसान पहेली 10 मिनट से कम में जीतें।';

  @override
  String get achFastMediumTitle => 'बिजली (मध्यम)';

  @override
  String get achFastMediumDesc => 'मध्यम पहेली 12 मिनट से कम में जीतें।';

  @override
  String get achFastHardTitle => 'बिजली (कठिन)';

  @override
  String get achFastHardDesc => 'कठिन पहेली 15 मिनट से कम में जीतें।';

  @override
  String get achFastExpertTitle => 'बिजली (विशेषज्ञ)';

  @override
  String get achFastExpertDesc => 'विशेषज्ञ पहेली 20 मिनट से कम में जीतें।';

  @override
  String get toolbarUndo => 'पूर्ववत';

  @override
  String get toolbarErase => 'मिटाएँ';

  @override
  String get toolbarNotes => 'नोट्स';

  @override
  String get toolbarFast => 'तेज़';

  @override
  String get toolbarHint => 'संकेत';

  @override
  String get toolbarValidate => 'जाँचें';

  @override
  String toolbarActiveSuffix(String label) {
    return '$label (सक्रिय)';
  }

  @override
  String get gridSemanticLabel => '9 गुणा 9 सुडोकू ग्रिड';

  @override
  String winStatSemanticLabel(String label, String value) {
    return '$label: $value';
  }

  @override
  String get savedCorruptedSnackbar => 'सेव खराब हो गया, खेल हटा दिया गया।';

  @override
  String get statsTitle => 'आँकड़े';

  @override
  String get statsBestTime => 'सर्वश्रेष्ठ समय';

  @override
  String statsGamesSolved(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count खेल',
      one: '$count खेल',
      zero: 'कोई खेल नहीं',
    );
    return '$_temp0';
  }

  @override
  String get statsNoRecord => '—';

  @override
  String get settingsTitle => 'सेटिंग्स';

  @override
  String get settingsSound => 'ध्वनि';

  @override
  String get settingsHaptic => 'हैप्टिक फ़ीडबैक';

  @override
  String get settingsShowHintButton => 'संकेत बटन दिखाएँ';

  @override
  String get settingsShowHintButtonDescription =>
      'बंद होने पर, संकेत बटन टूलबार से छिपा रहता है।';

  @override
  String get settingsTheme => 'थीम';

  @override
  String get settingsValidationMode => 'गलती जाँच';

  @override
  String get validationModeAutoCheck => 'स्वतः जाँच';

  @override
  String get validationModeAutoCheckDescription =>
      'पुराना मोड। दर्ज करते ही गलतियाँ दिखती हैं।';

  @override
  String get validationModeValidate => 'मैनुअल जाँच';

  @override
  String get validationModeValidateDescription =>
      'मौजूदा ग्रिड जाँचने के लिए एक अलग बटन का उपयोग करें।';

  @override
  String get validationModeNoCheck => 'बिना जाँच';

  @override
  String get validationModeNoCheckDescription =>
      'ग्रिड पूरी भरने पर ही गलतियाँ स्वतः जाँची जाती हैं।';

  @override
  String get leaveGameTitle => 'मौजूदा खेल छोड़ें?';

  @override
  String get leaveGameMessage =>
      'मौजूदा खेल खो जाएगा और जारी रखें अनुभाग से हट जाएगा।';

  @override
  String get leaveGameCancel => 'खेलते रहें';

  @override
  String get leaveGameConfirm => 'छोड़ें';

  @override
  String numberPadToggleNote(int number) {
    return 'नोट $number जोड़ें या हटाएँ';
  }

  @override
  String numberPadDeactivate(int number) {
    return '$number निष्क्रिय करें';
  }

  @override
  String numberPadEnter(int number) {
    return '$number दर्ज करें';
  }

  @override
  String tileSemanticPosition(int row, int col) {
    return 'सेल पंक्ति $row स्तंभ $col';
  }

  @override
  String get tileSemanticEmpty => 'खाली';

  @override
  String tileSemanticNotes(String notes) {
    return 'नोट्स $notes';
  }

  @override
  String tileSemanticValue(int value) {
    return 'मान $value';
  }

  @override
  String get tileSemanticGiven => 'दिया गया';

  @override
  String get tileSemanticError => 'गलती';

  @override
  String get tileSemanticSelected => 'चयनित';

  @override
  String get themeSystem => 'सिस्टम';

  @override
  String get themeLight => 'लाइट';

  @override
  String get themeDark => 'डार्क';
}
