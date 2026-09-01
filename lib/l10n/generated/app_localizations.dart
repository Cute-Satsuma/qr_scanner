import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_bn.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_hi.dart';
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
    Locale('bn'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('hi'),
    Locale('ja'),
    Locale('pt'),
    Locale('ru'),
    Locale('zh'),
    Locale('zh', 'CN'),
  ];

  /// Application name
  ///
  /// In en, this message translates to:
  /// **'QR Scan Caju'**
  String get appName;

  /// No description provided for @scanTab.
  ///
  /// In en, this message translates to:
  /// **'Scan'**
  String get scanTab;

  /// No description provided for @generateTab.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get generateTab;

  /// No description provided for @historyTab.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get historyTab;

  /// No description provided for @scanHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Scan history'**
  String get scanHistoryTitle;

  /// No description provided for @generateHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Created history'**
  String get generateHistoryTitle;

  /// No description provided for @settingsTab.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTab;

  /// No description provided for @cameraPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Please allow camera access to scan codes'**
  String get cameraPermissionDenied;

  /// No description provided for @cameraError.
  ///
  /// In en, this message translates to:
  /// **'Unable to start camera: {error}'**
  String cameraError(String error);

  /// No description provided for @scanFromImage.
  ///
  /// In en, this message translates to:
  /// **'Scan from image'**
  String get scanFromImage;

  /// No description provided for @torchOn.
  ///
  /// In en, this message translates to:
  /// **'Turn on flashlight'**
  String get torchOn;

  /// No description provided for @torchOff.
  ///
  /// In en, this message translates to:
  /// **'Turn off flashlight'**
  String get torchOff;

  /// No description provided for @switchCamera.
  ///
  /// In en, this message translates to:
  /// **'Switch camera'**
  String get switchCamera;

  /// No description provided for @actionTorch.
  ///
  /// In en, this message translates to:
  /// **'Flash'**
  String get actionTorch;

  /// No description provided for @actionAlbum.
  ///
  /// In en, this message translates to:
  /// **'Album'**
  String get actionAlbum;

  /// No description provided for @actionFlip.
  ///
  /// In en, this message translates to:
  /// **'Flip'**
  String get actionFlip;

  /// No description provided for @copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// No description provided for @copied.
  ///
  /// In en, this message translates to:
  /// **'Copied'**
  String get copied;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @openLink.
  ///
  /// In en, this message translates to:
  /// **'Open link'**
  String get openLink;

  /// No description provided for @searchWeb.
  ///
  /// In en, this message translates to:
  /// **'Search web'**
  String get searchWeb;

  /// No description provided for @callNumber.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get callNumber;

  /// No description provided for @sendEmail.
  ///
  /// In en, this message translates to:
  /// **'Send email'**
  String get sendEmail;

  /// No description provided for @sendSms.
  ///
  /// In en, this message translates to:
  /// **'Send SMS'**
  String get sendSms;

  /// No description provided for @noHistory.
  ///
  /// In en, this message translates to:
  /// **'No history'**
  String get noHistory;

  /// No description provided for @deleteRecord.
  ///
  /// In en, this message translates to:
  /// **'Delete record'**
  String get deleteRecord;

  /// No description provided for @deleteRecordConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete this record?'**
  String get deleteRecordConfirm;

  /// No description provided for @deleteAllRecords.
  ///
  /// In en, this message translates to:
  /// **'Delete all records'**
  String get deleteAllRecords;

  /// No description provided for @deleteAllRecordsConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete all history? This cannot be undone.'**
  String get deleteAllRecordsConfirm;

  /// No description provided for @recordDeleted.
  ///
  /// In en, this message translates to:
  /// **'Record deleted'**
  String get recordDeleted;

  /// No description provided for @allRecordsDeleted.
  ///
  /// In en, this message translates to:
  /// **'All records deleted'**
  String get allRecordsDeleted;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @generateQr.
  ///
  /// In en, this message translates to:
  /// **'Create QR code'**
  String get generateQr;

  /// No description provided for @inputHint.
  ///
  /// In en, this message translates to:
  /// **'Enter content'**
  String get inputHint;

  /// No description provided for @typeText.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get typeText;

  /// No description provided for @typeUrl.
  ///
  /// In en, this message translates to:
  /// **'URL'**
  String get typeUrl;

  /// No description provided for @typeWifi.
  ///
  /// In en, this message translates to:
  /// **'Wi-Fi'**
  String get typeWifi;

  /// No description provided for @typePhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get typePhone;

  /// No description provided for @typeEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get typeEmail;

  /// No description provided for @wifiSsid.
  ///
  /// In en, this message translates to:
  /// **'Network name (SSID)'**
  String get wifiSsid;

  /// No description provided for @wifiPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get wifiPassword;

  /// No description provided for @wifiEncryption.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get wifiEncryption;

  /// No description provided for @saveShareQr.
  ///
  /// In en, this message translates to:
  /// **'Share QR image'**
  String get saveShareQr;

  /// No description provided for @scanResult.
  ///
  /// In en, this message translates to:
  /// **'Scan result'**
  String get scanResult;

  /// No description provided for @generateResult.
  ///
  /// In en, this message translates to:
  /// **'Created QR'**
  String get generateResult;

  /// No description provided for @formatLabel.
  ///
  /// In en, this message translates to:
  /// **'Format: {format}'**
  String formatLabel(String format);

  /// No description provided for @noCodeFound.
  ///
  /// In en, this message translates to:
  /// **'No QR or barcode found in this image'**
  String get noCodeFound;

  /// No description provided for @pickImageFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not open the image'**
  String get pickImageFailed;

  /// No description provided for @enterContent.
  ///
  /// In en, this message translates to:
  /// **'Enter something to generate a QR code'**
  String get enterContent;

  /// No description provided for @versionLabel.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String versionLabel(String version);

  /// No description provided for @aboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get aboutTitle;

  /// No description provided for @aboutContent.
  ///
  /// In en, this message translates to:
  /// **'Free QR and barcode scanner.\n\n• No ads and no account\n• History is stored only on this device\n• Camera is used only while the Scan tab is open\n• Works offline except when you open a link'**
  String get aboutContent;

  /// No description provided for @liveScanUnsupported.
  ///
  /// In en, this message translates to:
  /// **'Live camera scanning is not available on this platform. Pick an image that contains a QR code.'**
  String get liveScanUnsupported;

  /// No description provided for @wpa.
  ///
  /// In en, this message translates to:
  /// **'WPA/WPA2'**
  String get wpa;

  /// No description provided for @wep.
  ///
  /// In en, this message translates to:
  /// **'WEP'**
  String get wep;

  /// No description provided for @nopass.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get nopass;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @scanningHint.
  ///
  /// In en, this message translates to:
  /// **'Align the code inside the frame'**
  String get scanningHint;

  /// No description provided for @imageScanning.
  ///
  /// In en, this message translates to:
  /// **'Scanning image…'**
  String get imageScanning;

  /// No description provided for @scanPickUpPhone.
  ///
  /// In en, this message translates to:
  /// **'Pick up your phone to start scanning'**
  String get scanPickUpPhone;

  /// No description provided for @typeSms.
  ///
  /// In en, this message translates to:
  /// **'SMS'**
  String get typeSms;

  /// No description provided for @typeGeo.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get typeGeo;

  /// No description provided for @typeProduct.
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get typeProduct;

  /// No description provided for @typeContact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get typeContact;

  /// No description provided for @typeIsbn.
  ///
  /// In en, this message translates to:
  /// **'ISBN'**
  String get typeIsbn;

  /// No description provided for @openWifi.
  ///
  /// In en, this message translates to:
  /// **'Wi-Fi details'**
  String get openWifi;

  /// No description provided for @ssidLabel.
  ///
  /// In en, this message translates to:
  /// **'SSID'**
  String get ssidLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @themeTitle.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get themeTitle;

  /// No description provided for @themeAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get themeAppearance;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @themeColor.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get themeColor;

  /// No description provided for @themeOrange.
  ///
  /// In en, this message translates to:
  /// **'Orange'**
  String get themeOrange;

  /// No description provided for @themeGreen.
  ///
  /// In en, this message translates to:
  /// **'Green'**
  String get themeGreen;

  /// No description provided for @themeTeal.
  ///
  /// In en, this message translates to:
  /// **'Teal'**
  String get themeTeal;

  /// No description provided for @themeBlue.
  ///
  /// In en, this message translates to:
  /// **'Blue'**
  String get themeBlue;

  /// No description provided for @themeSlate.
  ///
  /// In en, this message translates to:
  /// **'Slate'**
  String get themeSlate;

  /// No description provided for @themePaper.
  ///
  /// In en, this message translates to:
  /// **'Paper'**
  String get themePaper;

  /// No description provided for @themePaperFilter.
  ///
  /// In en, this message translates to:
  /// **'Paper texture'**
  String get themePaperFilter;

  /// No description provided for @themePaperGrain.
  ///
  /// In en, this message translates to:
  /// **'Roughness'**
  String get themePaperGrain;

  /// No description provided for @themePaperGrainFine.
  ///
  /// In en, this message translates to:
  /// **'Smooth'**
  String get themePaperGrainFine;

  /// No description provided for @themePaperGrainCoarse.
  ///
  /// In en, this message translates to:
  /// **'Rough'**
  String get themePaperGrainCoarse;

  /// No description provided for @themeFont.
  ///
  /// In en, this message translates to:
  /// **'Font'**
  String get themeFont;

  /// No description provided for @themeIconStyle.
  ///
  /// In en, this message translates to:
  /// **'Icons'**
  String get themeIconStyle;

  /// No description provided for @iconStyleAnime.
  ///
  /// In en, this message translates to:
  /// **'Playful'**
  String get iconStyleAnime;

  /// No description provided for @iconStyleBusiness.
  ///
  /// In en, this message translates to:
  /// **'Business'**
  String get iconStyleBusiness;

  /// No description provided for @fontRounded.
  ///
  /// In en, this message translates to:
  /// **'Rounded'**
  String get fontRounded;

  /// No description provided for @fontMaru.
  ///
  /// In en, this message translates to:
  /// **'Maru'**
  String get fontMaru;

  /// No description provided for @fontXiaoWei.
  ///
  /// In en, this message translates to:
  /// **'XiaoWei'**
  String get fontXiaoWei;

  /// No description provided for @fontNunito.
  ///
  /// In en, this message translates to:
  /// **'Nunito'**
  String get fontNunito;

  /// No description provided for @fontSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get fontSystem;
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
    'ar',
    'bn',
    'de',
    'en',
    'es',
    'hi',
    'ja',
    'pt',
    'ru',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'zh':
      {
        switch (locale.countryCode) {
          case 'CN':
            return AppLocalizationsZhCn();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'bn':
      return AppLocalizationsBn();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'hi':
      return AppLocalizationsHi();
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
