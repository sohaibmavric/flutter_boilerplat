import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
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

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
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
    Locale('ar'),
    Locale('en'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Sikila'**
  String get appTitle;

  /// Welcome message
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// A greeting message
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// Settings page title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Language selection option
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Theme selection option
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// Light theme option
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// Dark theme option
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// System theme option
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// Save button text
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// OK button text
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// Error message title
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// Success message title
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// Loading indicator text
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// Dashboard navigation tab
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// English language option
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// Arabic language option
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get arabic;

  /// Theme settings section title
  ///
  /// In en, this message translates to:
  /// **'Theme Settings'**
  String get themeSettings;

  /// Language settings section title
  ///
  /// In en, this message translates to:
  /// **'Language Settings'**
  String get languageSettings;

  /// Theme selection prompt
  ///
  /// In en, this message translates to:
  /// **'Select Theme'**
  String get selectTheme;

  /// Language selection prompt
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// Dashboard welcome description
  ///
  /// In en, this message translates to:
  /// **'Welcome to your dashboard! Here you can view all your important information.'**
  String get welcomeToDashboard;

  /// Quick stats section title
  ///
  /// In en, this message translates to:
  /// **'Quick Stats'**
  String get quickStats;

  /// Total items stat label
  ///
  /// In en, this message translates to:
  /// **'Total Items'**
  String get totalItems;

  /// Active tasks stat label
  ///
  /// In en, this message translates to:
  /// **'Active Tasks'**
  String get activeTasks;

  /// Completed stat label
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// Pending stat label
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// Recent activity section title
  ///
  /// In en, this message translates to:
  /// **'Recent Activity'**
  String get recentActivity;

  /// Activity item label
  ///
  /// In en, this message translates to:
  /// **'Activity'**
  String get activity;

  /// Activity item description
  ///
  /// In en, this message translates to:
  /// **'Description of activity'**
  String get activityDescription;

  /// Hours ago time indicator
  ///
  /// In en, this message translates to:
  /// **'h ago'**
  String get hoursAgo;

  /// App information section title
  ///
  /// In en, this message translates to:
  /// **'App Information'**
  String get appInformation;

  /// App version label
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// App build label
  ///
  /// In en, this message translates to:
  /// **'Build'**
  String get build;

  /// Development build type
  ///
  /// In en, this message translates to:
  /// **'Development'**
  String get development;

  /// Test action button text
  ///
  /// In en, this message translates to:
  /// **'Test Action'**
  String get testAction;

  /// App version number
  ///
  /// In en, this message translates to:
  /// **'1.0.0'**
  String get versionNumber;

  /// Statistics section title
  ///
  /// In en, this message translates to:
  /// **'Statistics Overview'**
  String get statisticsOverview;

  /// Total users metric label
  ///
  /// In en, this message translates to:
  /// **'Total Users'**
  String get totalUsers;

  /// Revenue metric label
  ///
  /// In en, this message translates to:
  /// **'Revenue'**
  String get revenue;

  /// Tasks metric label
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get tasks;

  /// Growth metric label
  ///
  /// In en, this message translates to:
  /// **'Growth'**
  String get growth;

  /// Quick actions section title
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get quickActions;

  /// Create post action title
  ///
  /// In en, this message translates to:
  /// **'Create Post'**
  String get createPost;

  /// Create post action description
  ///
  /// In en, this message translates to:
  /// **'Add new content'**
  String get addNewContent;

  /// Manage users action title
  ///
  /// In en, this message translates to:
  /// **'Manage Users'**
  String get manageUsers;

  /// Manage users action description
  ///
  /// In en, this message translates to:
  /// **'User administration'**
  String get userAdministration;

  /// View reports action title
  ///
  /// In en, this message translates to:
  /// **'View Reports'**
  String get viewReports;

  /// View reports action description
  ///
  /// In en, this message translates to:
  /// **'Analytics & insights'**
  String get analyticsInsights;

  /// Settings action description
  ///
  /// In en, this message translates to:
  /// **'App configuration'**
  String get appConfiguration;

  /// Action tapped message
  ///
  /// In en, this message translates to:
  /// **'{action} tapped'**
  String actionTapped(String action);

  /// Sample users count
  ///
  /// In en, this message translates to:
  /// **'12,345'**
  String get usersCount;

  /// Sample revenue amount
  ///
  /// In en, this message translates to:
  /// **'\$45.2K'**
  String get revenueAmount;

  /// Sample tasks count
  ///
  /// In en, this message translates to:
  /// **'89'**
  String get tasksCount;

  /// Sample growth percentage
  ///
  /// In en, this message translates to:
  /// **'23.1%'**
  String get growthPercentage;

  /// Sample positive change 12%
  ///
  /// In en, this message translates to:
  /// **'+12%'**
  String get changePositive12;

  /// Sample positive change 8%
  ///
  /// In en, this message translates to:
  /// **'+8%'**
  String get changePositive8;

  /// Sample negative change 3%
  ///
  /// In en, this message translates to:
  /// **'-3%'**
  String get changeNegative3;

  /// Sample positive change 15%
  ///
  /// In en, this message translates to:
  /// **'+15%'**
  String get changePositive15;
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
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
