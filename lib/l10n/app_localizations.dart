import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

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
    Locale('en'),
    Locale('fr'),
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

  /// No description provided for @winBackHome.
  ///
  /// In fr, this message translates to:
  /// **'Retour à l\'accueil'**
  String get winBackHome;

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

  /// No description provided for @savedCorruptedSnackbar.
  ///
  /// In fr, this message translates to:
  /// **'Sauvegarde corrompue, partie effacée.'**
  String get savedCorruptedSnackbar;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
