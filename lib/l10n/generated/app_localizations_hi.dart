// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appName => 'QR स्कैन Caju';

  @override
  String get scanTab => 'स्कैन';

  @override
  String get generateTab => 'बनाएँ';

  @override
  String get historyTab => 'इतिहास';

  @override
  String get scanHistoryTitle => 'स्कैन इतिहास';

  @override
  String get generateHistoryTitle => 'बनाया गया इतिहास';

  @override
  String get settingsTab => 'सेटिंग';

  @override
  String get cameraPermissionDenied => 'कोड स्कैन करने के लिए कैमरा अनुमति दें';

  @override
  String cameraError(String error) {
    return 'कैमरा शुरू नहीं हो सका: $error';
  }

  @override
  String get scanFromImage => 'फ़ोटो से स्कैन करें';

  @override
  String get torchOn => 'फ़्लैश चालू करें';

  @override
  String get torchOff => 'फ़्लैश बंद करें';

  @override
  String get switchCamera => 'कैमरा बदलें';

  @override
  String get actionTorch => 'फ़्लैश';

  @override
  String get actionAlbum => 'एल्बम';

  @override
  String get actionFlip => 'कैमरा';

  @override
  String get copy => 'कॉपी';

  @override
  String get copied => 'कॉपी हो गया';

  @override
  String get share => 'शेयर';

  @override
  String get openLink => 'लिंक खोलें';

  @override
  String get searchWeb => 'वेब पर खोजें';

  @override
  String get callNumber => 'कॉल करें';

  @override
  String get sendEmail => 'ईमेल भेजें';

  @override
  String get sendSms => 'SMS भेजें';

  @override
  String get noHistory => 'कोई इतिहास नहीं';

  @override
  String get deleteRecord => 'रिकॉर्ड हटाएँ';

  @override
  String get deleteRecordConfirm => 'यह रिकॉर्ड हटाएँ?';

  @override
  String get deleteAllRecords => 'सब हटाएँ';

  @override
  String get deleteAllRecordsConfirm => 'पूरा इतिहास हटाएँ? यह वापस नहीं होगा।';

  @override
  String get recordDeleted => 'रिकॉर्ड हटाया गया';

  @override
  String get allRecordsDeleted => 'सारा इतिहास हटाया गया';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get delete => 'हटाएँ';

  @override
  String get generateQr => 'QR कोड बनाएँ';

  @override
  String get inputHint => 'सामग्री लिखें';

  @override
  String get typeText => 'टेक्स्ट';

  @override
  String get typeUrl => 'URL';

  @override
  String get typeWifi => 'Wi-Fi';

  @override
  String get typePhone => 'फ़ोन';

  @override
  String get typeEmail => 'ईमेल';

  @override
  String get wifiSsid => 'नेटवर्क नाम (SSID)';

  @override
  String get wifiPassword => 'पासवर्ड';

  @override
  String get wifiEncryption => 'सुरक्षा';

  @override
  String get saveShareQr => 'QR इमेज शेयर करें';

  @override
  String get scanResult => 'परिणाम';

  @override
  String get generateResult => 'बनाया गया QR';

  @override
  String formatLabel(String format) {
    return 'फ़ॉर्मेट: $format';
  }

  @override
  String get noCodeFound => 'इस इमेज में कोई कोड नहीं मिला';

  @override
  String get pickImageFailed => 'इमेज नहीं खुल सकी';

  @override
  String get enterContent => 'QR कोड बनाने के लिए कुछ लिखें';

  @override
  String versionLabel(String version) {
    return 'संस्करण $version';
  }

  @override
  String get aboutTitle => 'जानकारी';

  @override
  String get aboutContent =>
      'मुफ़्त QR और बारकोड स्कैनर।\n\n• कोई विज्ञापन नहीं, खाता नहीं\n• इतिहास केवल इसी डिवाइस पर\n• कैमरा केवल स्कैन टैब में\n• लिंक खोलने के अलावा ऑफ़लाइन चलता है';

  @override
  String get liveScanUnsupported =>
      'इस प्लेटफ़ॉर्म पर लाइव कैमरा स्कैन उपलब्ध नहीं है। QR वाली इमेज चुनें।';

  @override
  String get wpa => 'WPA/WPA2';

  @override
  String get wep => 'WEP';

  @override
  String get nopass => 'कोई नहीं';

  @override
  String get ok => 'OK';

  @override
  String get scanningHint => 'कोड को फ़्रेम के अंदर रखें';

  @override
  String get imageScanning => 'इमेज स्कैन हो रही है…';

  @override
  String get scanPickUpPhone => 'स्कैन शुरू करने के लिए फ़ोन उठाएँ';

  @override
  String get typeSms => 'SMS';

  @override
  String get typeGeo => 'स्थान';

  @override
  String get typeProduct => 'प्रॉडक्ट';

  @override
  String get typeContact => 'संपर्क';

  @override
  String get typeIsbn => 'ISBN';

  @override
  String get openWifi => 'Wi-Fi जानकारी';

  @override
  String get ssidLabel => 'SSID';

  @override
  String get passwordLabel => 'पासवर्ड';

  @override
  String get themeTitle => 'थीम';

  @override
  String get themeAppearance => 'दिखावट';

  @override
  String get themeSystem => 'सिस्टम';

  @override
  String get themeLight => 'हल्की';

  @override
  String get themeDark => 'गहरी';

  @override
  String get themeColor => 'रंग';

  @override
  String get themeOrange => 'नारंगी';

  @override
  String get themeGreen => 'हरा';

  @override
  String get themeTeal => 'टील';

  @override
  String get themeBlue => 'नीला';

  @override
  String get themeSlate => 'स्लेट';

  @override
  String get themePaper => 'कागज़';

  @override
  String get themePaperFilter => 'कागज़ की बनावट';

  @override
  String get themePaperGrain => 'खुरदरापन';

  @override
  String get themePaperGrainFine => 'चिकना';

  @override
  String get themePaperGrainCoarse => 'खुरदरा';

  @override
  String get themeFont => 'फ़ॉन्ट';

  @override
  String get themeIconStyle => 'आइकन';

  @override
  String get iconStyleAnime => 'एनिमे';

  @override
  String get iconStyleBusiness => 'व्यावसायिक';

  @override
  String get fontRounded => 'गोलाकार';

  @override
  String get fontMaru => 'Maru';

  @override
  String get fontXiaoWei => 'XiaoWei';

  @override
  String get fontNunito => 'Nunito';

  @override
  String get fontSystem => 'सिस्टम';
}
