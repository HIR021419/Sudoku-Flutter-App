import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('hi'),
    Locale('it'),
    Locale('ja'),
    Locale('pt'),
    Locale('ru'),
    Locale('zh'),
  ];

  /// Application title
  ///
  /// In fr, this message translates to:
  /// **'Sudoku'**
  String get appTitle;

  /// No description provided for @homeChooseDifficulty.
  ///
  /// In fr, this message translates to:
  /// **'Choisis ta difficulté'**
  String get homeChooseDifficulty;

  /// No description provided for @homeResumeTitle.
  ///
  /// In fr, this message translates to:
  /// **'Reprendre la partie'**
  String get homeResumeTitle;

  /// No description provided for @homePlayButton.
  ///
  /// In fr, this message translates to:
  /// **'Jouer'**
  String get homePlayButton;

  /// No description provided for @difficultyEasy.
  ///
  /// In fr, this message translates to:
  /// **'Facile'**
  String get difficultyEasy;

  /// No description provided for @difficultyMedium.
  ///
  /// In fr, this message translates to:
  /// **'Moyen'**
  String get difficultyMedium;

  /// No description provided for @difficultyHard.
  ///
  /// In fr, this message translates to:
  /// **'Difficile'**
  String get difficultyHard;

  /// No description provided for @difficultyExpert.
  ///
  /// In fr, this message translates to:
  /// **'Expert'**
  String get difficultyExpert;

  /// No description provided for @difficultyCluesCount.
  ///
  /// In fr, this message translates to:
  /// **'{count} indices'**
  String difficultyCluesCount(int count);

  /// No description provided for @winTitle.
  ///
  /// In fr, this message translates to:
  /// **'Félicitations !'**
  String get winTitle;

  /// No description provided for @winSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Sudoku {difficulty} résolu.'**
  String winSubtitle(String difficulty);

  /// No description provided for @winStatTime.
  ///
  /// In fr, this message translates to:
  /// **'Temps'**
  String get winStatTime;

  /// No description provided for @winStatErrors.
  ///
  /// In fr, this message translates to:
  /// **'Erreurs'**
  String get winStatErrors;

  /// No description provided for @winStatHints.
  ///
  /// In fr, this message translates to:
  /// **'Indices'**
  String get winStatHints;

  /// Effective time including penalties shown on the win dialog
  ///
  /// In fr, this message translates to:
  /// **'Temps retenu : {time} (pénalités incluses)'**
  String winEffectiveTime(String time);

  /// No description provided for @winBackHome.
  ///
  /// In fr, this message translates to:
  /// **'Retour à l\'accueil'**
  String get winBackHome;

  /// No description provided for @dailyTitle.
  ///
  /// In fr, this message translates to:
  /// **'Défi du jour'**
  String get dailyTitle;

  /// No description provided for @dailyCardPlay.
  ///
  /// In fr, this message translates to:
  /// **'Jouez la grille du jour'**
  String get dailyCardPlay;

  /// Daily challenge solved, with effective time
  ///
  /// In fr, this message translates to:
  /// **'Résolu en {time}'**
  String dailyCardWon(String time);

  /// No description provided for @dailyCardComeBack.
  ///
  /// In fr, this message translates to:
  /// **'Revenez demain pour une nouvelle grille'**
  String get dailyCardComeBack;

  /// No description provided for @dailyAbandonTitle.
  ///
  /// In fr, this message translates to:
  /// **'Abandonner le défi du jour ?'**
  String get dailyAbandonTitle;

  /// No description provided for @dailyAbandonMessage.
  ///
  /// In fr, this message translates to:
  /// **'Vous n\'avez qu\'une tentative par jour : si vous quittez maintenant, le défi du jour sera perdu jusqu\'à demain.'**
  String get dailyAbandonMessage;

  /// No description provided for @leaderboardsTitle.
  ///
  /// In fr, this message translates to:
  /// **'Classements'**
  String get leaderboardsTitle;

  /// No description provided for @achievementsTitle.
  ///
  /// In fr, this message translates to:
  /// **'Succès'**
  String get achievementsTitle;

  /// Snackbar shown when achievements are unlocked
  ///
  /// In fr, this message translates to:
  /// **'Succès débloqué : {names}'**
  String achievementsUnlockedSnack(String names);

  /// No description provided for @achFirstWinTitle.
  ///
  /// In fr, this message translates to:
  /// **'Première victoire'**
  String get achFirstWinTitle;

  /// No description provided for @achFirstWinDesc.
  ///
  /// In fr, this message translates to:
  /// **'Résoudre votre première grille.'**
  String get achFirstWinDesc;

  /// No description provided for @achNoMistakeTitle.
  ///
  /// In fr, this message translates to:
  /// **'Sans faute'**
  String get achNoMistakeTitle;

  /// No description provided for @achNoMistakeDesc.
  ///
  /// In fr, this message translates to:
  /// **'Gagner une partie sans aucune erreur.'**
  String get achNoMistakeDesc;

  /// No description provided for @achNoHintTitle.
  ///
  /// In fr, this message translates to:
  /// **'Sans indice'**
  String get achNoHintTitle;

  /// No description provided for @achNoHintDesc.
  ///
  /// In fr, this message translates to:
  /// **'Gagner une partie sans aucun indice.'**
  String get achNoHintDesc;

  /// No description provided for @achGames10Title.
  ///
  /// In fr, this message translates to:
  /// **'10 parties'**
  String get achGames10Title;

  /// No description provided for @achGames10Desc.
  ///
  /// In fr, this message translates to:
  /// **'Résoudre 10 grilles.'**
  String get achGames10Desc;

  /// No description provided for @achGames50Title.
  ///
  /// In fr, this message translates to:
  /// **'50 parties'**
  String get achGames50Title;

  /// No description provided for @achGames50Desc.
  ///
  /// In fr, this message translates to:
  /// **'Résoudre 50 grilles.'**
  String get achGames50Desc;

  /// No description provided for @achGames100Title.
  ///
  /// In fr, this message translates to:
  /// **'100 parties'**
  String get achGames100Title;

  /// No description provided for @achGames100Desc.
  ///
  /// In fr, this message translates to:
  /// **'Résoudre 100 grilles.'**
  String get achGames100Desc;

  /// No description provided for @achAllDifficultiesTitle.
  ///
  /// In fr, this message translates to:
  /// **'Touche-à-tout'**
  String get achAllDifficultiesTitle;

  /// No description provided for @achAllDifficultiesDesc.
  ///
  /// In fr, this message translates to:
  /// **'Gagner dans les quatre difficultés.'**
  String get achAllDifficultiesDesc;

  /// No description provided for @achDailyFirstTitle.
  ///
  /// In fr, this message translates to:
  /// **'Défi relevé'**
  String get achDailyFirstTitle;

  /// No description provided for @achDailyFirstDesc.
  ///
  /// In fr, this message translates to:
  /// **'Résoudre un défi du jour.'**
  String get achDailyFirstDesc;

  /// No description provided for @achDailyStreak7Title.
  ///
  /// In fr, this message translates to:
  /// **'Semaine parfaite'**
  String get achDailyStreak7Title;

  /// No description provided for @achDailyStreak7Desc.
  ///
  /// In fr, this message translates to:
  /// **'Résoudre le défi du jour 7 jours d\'affilée.'**
  String get achDailyStreak7Desc;

  /// No description provided for @achFastEasyTitle.
  ///
  /// In fr, this message translates to:
  /// **'Éclair (facile)'**
  String get achFastEasyTitle;

  /// No description provided for @achFastEasyDesc.
  ///
  /// In fr, this message translates to:
  /// **'Gagner une grille facile en moins de 10 min.'**
  String get achFastEasyDesc;

  /// No description provided for @achFastMediumTitle.
  ///
  /// In fr, this message translates to:
  /// **'Éclair (moyen)'**
  String get achFastMediumTitle;

  /// No description provided for @achFastMediumDesc.
  ///
  /// In fr, this message translates to:
  /// **'Gagner une grille moyenne en moins de 12 min.'**
  String get achFastMediumDesc;

  /// No description provided for @achFastHardTitle.
  ///
  /// In fr, this message translates to:
  /// **'Éclair (difficile)'**
  String get achFastHardTitle;

  /// No description provided for @achFastHardDesc.
  ///
  /// In fr, this message translates to:
  /// **'Gagner une grille difficile en moins de 15 min.'**
  String get achFastHardDesc;

  /// No description provided for @achFastExpertTitle.
  ///
  /// In fr, this message translates to:
  /// **'Éclair (expert)'**
  String get achFastExpertTitle;

  /// No description provided for @achFastExpertDesc.
  ///
  /// In fr, this message translates to:
  /// **'Gagner une grille expert en moins de 20 min.'**
  String get achFastExpertDesc;

  /// No description provided for @toolbarUndo.
  ///
  /// In fr, this message translates to:
  /// **'Annuler'**
  String get toolbarUndo;

  /// No description provided for @toolbarErase.
  ///
  /// In fr, this message translates to:
  /// **'Effacer'**
  String get toolbarErase;

  /// No description provided for @toolbarNotes.
  ///
  /// In fr, this message translates to:
  /// **'Notes'**
  String get toolbarNotes;

  /// No description provided for @toolbarFast.
  ///
  /// In fr, this message translates to:
  /// **'Rapide'**
  String get toolbarFast;

  /// No description provided for @toolbarHint.
  ///
  /// In fr, this message translates to:
  /// **'Indice'**
  String get toolbarHint;

  /// No description provided for @toolbarValidate.
  ///
  /// In fr, this message translates to:
  /// **'Vérifier'**
  String get toolbarValidate;

  /// Semantic label for a toolbar button when active
  ///
  /// In fr, this message translates to:
  /// **'{label} (actif)'**
  String toolbarActiveSuffix(String label);

  /// Semantic label announcing the Sudoku grid
  ///
  /// In fr, this message translates to:
  /// **'Grille Sudoku 9 par 9'**
  String get gridSemanticLabel;

  /// Semantic label combining a stat label and its value
  ///
  /// In fr, this message translates to:
  /// **'{label} : {value}'**
  String winStatSemanticLabel(String label, String value);

  /// No description provided for @savedCorruptedSnackbar.
  ///
  /// In fr, this message translates to:
  /// **'Sauvegarde corrompue, partie effacée.'**
  String get savedCorruptedSnackbar;

  /// No description provided for @statsTitle.
  ///
  /// In fr, this message translates to:
  /// **'Statistiques'**
  String get statsTitle;

  /// No description provided for @statsBestTime.
  ///
  /// In fr, this message translates to:
  /// **'Meilleur temps'**
  String get statsBestTime;

  /// No description provided for @statsGamesSolved.
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, =0{Aucune partie} =1{1 partie} other{{count} parties}}'**
  String statsGamesSolved(int count);

  /// No description provided for @statsNoRecord.
  ///
  /// In fr, this message translates to:
  /// **'—'**
  String get statsNoRecord;

  /// No description provided for @settingsTitle.
  ///
  /// In fr, this message translates to:
  /// **'Paramètres'**
  String get settingsTitle;

  /// No description provided for @settingsSound.
  ///
  /// In fr, this message translates to:
  /// **'Son'**
  String get settingsSound;

  /// No description provided for @settingsHaptic.
  ///
  /// In fr, this message translates to:
  /// **'Retour haptique'**
  String get settingsHaptic;

  /// No description provided for @settingsShowHintButton.
  ///
  /// In fr, this message translates to:
  /// **'Afficher le bouton indice'**
  String get settingsShowHintButton;

  /// No description provided for @settingsShowHintButtonDescription.
  ///
  /// In fr, this message translates to:
  /// **'Si désactivé, le bouton indice n\'est pas affiché dans la barre d\'outils.'**
  String get settingsShowHintButtonDescription;

  /// No description provided for @settingsTheme.
  ///
  /// In fr, this message translates to:
  /// **'Thème'**
  String get settingsTheme;

  /// No description provided for @settingsValidationMode.
  ///
  /// In fr, this message translates to:
  /// **'Contrôle des erreurs'**
  String get settingsValidationMode;

  /// No description provided for @validationModeAutoCheck.
  ///
  /// In fr, this message translates to:
  /// **'Vérification auto'**
  String get validationModeAutoCheck;

  /// No description provided for @validationModeAutoCheckDescription.
  ///
  /// In fr, this message translates to:
  /// **'Mode actuel. Les erreurs s\'affichent dès la saisie.'**
  String get validationModeAutoCheckDescription;

  /// No description provided for @validationModeValidate.
  ///
  /// In fr, this message translates to:
  /// **'Validation manuelle'**
  String get validationModeValidate;

  /// No description provided for @validationModeValidateDescription.
  ///
  /// In fr, this message translates to:
  /// **'Ajoute un bouton pour vérifier manuellement la grille en cours.'**
  String get validationModeValidateDescription;

  /// No description provided for @validationModeNoCheck.
  ///
  /// In fr, this message translates to:
  /// **'Sans vérification'**
  String get validationModeNoCheck;

  /// No description provided for @validationModeNoCheckDescription.
  ///
  /// In fr, this message translates to:
  /// **'Les erreurs sont vérifiées automatiquement uniquement quand la grille est complète.'**
  String get validationModeNoCheckDescription;

  /// No description provided for @leaveGameTitle.
  ///
  /// In fr, this message translates to:
  /// **'Abandonner la partie en cours ?'**
  String get leaveGameTitle;

  /// No description provided for @leaveGameMessage.
  ///
  /// In fr, this message translates to:
  /// **'La partie actuelle sera perdue et retirée de la reprise de partie.'**
  String get leaveGameMessage;

  /// No description provided for @leaveGameCancel.
  ///
  /// In fr, this message translates to:
  /// **'Continuer'**
  String get leaveGameCancel;

  /// No description provided for @leaveGameConfirm.
  ///
  /// In fr, this message translates to:
  /// **'Abandonner'**
  String get leaveGameConfirm;

  /// No description provided for @numberPadToggleNote.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter ou retirer la note {number}'**
  String numberPadToggleNote(int number);

  /// No description provided for @numberPadDeactivate.
  ///
  /// In fr, this message translates to:
  /// **'Désactiver {number}'**
  String numberPadDeactivate(int number);

  /// No description provided for @numberPadEnter.
  ///
  /// In fr, this message translates to:
  /// **'Saisir {number}'**
  String numberPadEnter(int number);

  /// No description provided for @tileSemanticPosition.
  ///
  /// In fr, this message translates to:
  /// **'Cellule ligne {row} colonne {col}'**
  String tileSemanticPosition(int row, int col);

  /// No description provided for @tileSemanticEmpty.
  ///
  /// In fr, this message translates to:
  /// **'vide'**
  String get tileSemanticEmpty;

  /// No description provided for @tileSemanticNotes.
  ///
  /// In fr, this message translates to:
  /// **'notes {notes}'**
  String tileSemanticNotes(String notes);

  /// No description provided for @tileSemanticValue.
  ///
  /// In fr, this message translates to:
  /// **'valeur {value}'**
  String tileSemanticValue(int value);

  /// No description provided for @tileSemanticGiven.
  ///
  /// In fr, this message translates to:
  /// **'initiale'**
  String get tileSemanticGiven;

  /// No description provided for @tileSemanticError.
  ///
  /// In fr, this message translates to:
  /// **'erreur'**
  String get tileSemanticError;

  /// No description provided for @tileSemanticSelected.
  ///
  /// In fr, this message translates to:
  /// **'sélectionnée'**
  String get tileSemanticSelected;

  /// No description provided for @themeSystem.
  ///
  /// In fr, this message translates to:
  /// **'Système'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In fr, this message translates to:
  /// **'Clair'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In fr, this message translates to:
  /// **'Sombre'**
  String get themeDark;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'hi',
    'it',
    'ja',
    'pt',
    'ru',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
