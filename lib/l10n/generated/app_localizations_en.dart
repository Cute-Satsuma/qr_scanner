// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'QR Scan Caju';

  @override
  String get scanTab => 'Scan';

  @override
  String get generateTab => 'Create';

  @override
  String get historyTab => 'History';

  @override
  String get scanHistoryTitle => 'Scan history';

  @override
  String get generateHistoryTitle => 'Created history';

  @override
  String get settingsTab => 'Settings';

  @override
  String get cameraPermissionDenied =>
      'Please allow camera access to scan codes';

  @override
  String cameraError(String error) {
    return 'Unable to start camera: $error';
  }

  @override
  String get scanFromImage => 'Scan from image';

  @override
  String get torchOn => 'Turn on flashlight';

  @override
  String get torchOff => 'Turn off flashlight';

  @override
  String get switchCamera => 'Switch camera';

  @override
  String get actionTorch => 'Flash';

  @override
  String get actionAlbum => 'Album';

  @override
  String get actionFlip => 'Flip';

  @override
  String get copy => 'Copy';

  @override
  String get copied => 'Copied';

  @override
  String get share => 'Share';

  @override
  String get openLink => 'Open link';

  @override
  String get searchWeb => 'Search web';

  @override
  String get callNumber => 'Call';

  @override
  String get sendEmail => 'Send email';

  @override
  String get sendSms => 'Send SMS';

  @override
  String get noHistory => 'No history';

  @override
  String get deleteRecord => 'Delete record';

  @override
  String get deleteRecordConfirm => 'Delete this record?';

  @override
  String get deleteAllRecords => 'Delete all records';

  @override
  String get deleteAllRecordsConfirm =>
      'Delete all history? This cannot be undone.';

  @override
  String get recordDeleted => 'Record deleted';

  @override
  String get allRecordsDeleted => 'All records deleted';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get generateQr => 'Create QR code';

  @override
  String get inputHint => 'Enter content';

  @override
  String get typeText => 'Text';

  @override
  String get typeUrl => 'URL';

  @override
  String get typeWifi => 'Wi-Fi';

  @override
  String get typePhone => 'Phone';

  @override
  String get typeEmail => 'Email';

  @override
  String get wifiSsid => 'Network name (SSID)';

  @override
  String get wifiPassword => 'Password';

  @override
  String get wifiEncryption => 'Security';

  @override
  String get saveShareQr => 'Share QR image';

  @override
  String get scanResult => 'Scan result';

  @override
  String get generateResult => 'Created QR';

  @override
  String formatLabel(String format) {
    return 'Format: $format';
  }

  @override
  String get noCodeFound => 'No QR or barcode found in this image';

  @override
  String get pickImageFailed => 'Could not open the image';

  @override
  String get enterContent => 'Enter something to generate a QR code';

  @override
  String versionLabel(String version) {
    return 'Version $version';
  }

  @override
  String get aboutTitle => 'About';

  @override
  String get aboutContent =>
      'Free QR and barcode scanner.\n\n• No ads and no account\n• History is stored only on this device\n• Camera is used only while the Scan tab is open\n• Works offline except when you open a link';

  @override
  String get liveScanUnsupported =>
      'Live camera scanning is not available on this platform. Pick an image that contains a QR code.';

  @override
  String get wpa => 'WPA/WPA2';

  @override
  String get wep => 'WEP';

  @override
  String get nopass => 'None';

  @override
  String get ok => 'OK';

  @override
  String get scanningHint => 'Align the code inside the frame';

  @override
  String get imageScanning => 'Scanning image…';

  @override
  String get scanPickUpPhone => 'Pick up your phone to start scanning';

  @override
  String get typeSms => 'SMS';

  @override
  String get typeGeo => 'Location';

  @override
  String get typeProduct => 'Product';

  @override
  String get typeContact => 'Contact';

  @override
  String get typeIsbn => 'ISBN';

  @override
  String get openWifi => 'Wi-Fi details';

  @override
  String get ssidLabel => 'SSID';

  @override
  String get passwordLabel => 'Password';

  @override
  String get themeTitle => 'Theme';

  @override
  String get themeAppearance => 'Appearance';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeColor => 'Color';

  @override
  String get themeOrange => 'Orange';

  @override
  String get themeGreen => 'Green';

  @override
  String get themeTeal => 'Teal';

  @override
  String get themeBlue => 'Blue';

  @override
  String get themeSlate => 'Slate';

  @override
  String get themePaper => 'Paper';

  @override
  String get themePaperFilter => 'Paper texture';

  @override
  String get themePaperGrain => 'Roughness';

  @override
  String get themePaperGrainFine => 'Smooth';

  @override
  String get themePaperGrainCoarse => 'Rough';

  @override
  String get themeFont => 'Font';

  @override
  String get themeIconStyle => 'Icons';

  @override
  String get iconStyleAnime => 'Playful';

  @override
  String get iconStyleBusiness => 'Business';

  @override
  String get fontRounded => 'Rounded';

  @override
  String get fontMaru => 'Maru';

  @override
  String get fontXiaoWei => 'XiaoWei';

  @override
  String get fontNunito => 'Nunito';

  @override
  String get fontSystem => 'System';
}
