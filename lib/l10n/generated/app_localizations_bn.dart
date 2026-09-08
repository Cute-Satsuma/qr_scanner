// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get appName => 'QR স্ক্যানার';

  @override
  String get scanTab => 'স্ক্যান';

  @override
  String get generateTab => 'তৈরি';

  @override
  String get historyTab => 'ইতিহাস';

  @override
  String get scanHistoryTitle => 'স্ক্যান ইতিহাস';

  @override
  String get generateHistoryTitle => 'তৈরি ইতিহাস';

  @override
  String get settingsTab => 'সেটিংস';

  @override
  String get cameraPermissionDenied => 'কোড স্ক্যান করতে ক্যামেরার অনুমতি দিন';

  @override
  String cameraError(String error) {
    return 'ক্যামেরা চালু করা যায়নি: $error';
  }

  @override
  String get scanFromImage => 'ছবি থেকে স্ক্যান';

  @override
  String get torchOn => 'ফ্ল্যাশ চালু';

  @override
  String get torchOff => 'ফ্ল্যাশ বন্ধ';

  @override
  String get switchCamera => 'ক্যামেরা বদলান';

  @override
  String get actionTorch => 'ফ্ল্যাশ';

  @override
  String get actionAlbum => 'অ্যালবাম';

  @override
  String get actionFlip => 'ক্যামেরা';

  @override
  String get copy => 'কপি';

  @override
  String get copied => 'কপি হয়েছে';

  @override
  String get share => 'শেয়ার';

  @override
  String get openLink => 'লিংক খুলুন';

  @override
  String get searchWeb => 'ওয়েবে খুঁজুন';

  @override
  String get callNumber => 'কল করুন';

  @override
  String get sendEmail => 'ইমেইল পাঠান';

  @override
  String get sendSms => 'SMS পাঠান';

  @override
  String get noHistory => 'কোনো ইতিহাস নেই';

  @override
  String get deleteRecord => 'রেকর্ড মুছুন';

  @override
  String get deleteRecordConfirm => 'এই রেকর্ড মুছবেন?';

  @override
  String get deleteAllRecords => 'সব মুছুন';

  @override
  String get deleteAllRecordsConfirm => 'সব ইতিহাস মুছবেন? এটি ফেরানো যাবে না।';

  @override
  String get recordDeleted => 'রেকর্ড মুছেছে';

  @override
  String get allRecordsDeleted => 'সব ইতিহাস মুছেছে';

  @override
  String get cancel => 'বাতিল';

  @override
  String get delete => 'মুছুন';

  @override
  String get generateQr => 'QR কোড তৈরি';

  @override
  String get inputHint => 'কনটেন্ট লিখুন';

  @override
  String get typeText => 'টেক্সট';

  @override
  String get typeUrl => 'URL';

  @override
  String get typeWifi => 'Wi-Fi';

  @override
  String get typePhone => 'ফোন';

  @override
  String get typeEmail => 'ইমেইল';

  @override
  String get wifiSsid => 'নেটওয়ার্কের নাম (SSID)';

  @override
  String get wifiPassword => 'পাসওয়ার্ড';

  @override
  String get wifiEncryption => 'নিরাপত্তা';

  @override
  String get saveShareQr => 'QR ছবি শেয়ার';

  @override
  String get scanResult => 'ফলাফল';

  @override
  String get generateResult => 'তৈরি করা QR';

  @override
  String formatLabel(String format) {
    return 'ফরম্যাট: $format';
  }

  @override
  String get noCodeFound => 'এই ছবিতে কোনো কোড পাওয়া যায়নি';

  @override
  String get pickImageFailed => 'ছবি খোলা যায়নি';

  @override
  String get enterContent => 'QR তৈরি করতে কিছু লিখুন';

  @override
  String versionLabel(String version) {
    return 'সংস্করণ $version';
  }

  @override
  String get aboutTitle => 'সম্পর্কে';

  @override
  String get aboutContent =>
      'ফ্রি QR ও বারকোড স্ক্যানার।\n\n• বিজ্ঞাপন নেই, অ্যাকাউন্ট নেই\n• ইতিহাস শুধু এই ডিভাইসে\n• ক্যামেরা শুধু স্ক্যান ট্যাবে\n• লিংক খোলা ছাড়া অফলাইনে চলে';

  @override
  String get liveScanUnsupported =>
      'এই প্ল্যাটফর্মে লাইভ ক্যামেরা স্ক্যান নেই। QR কোডের ছবি বেছে নিন।';

  @override
  String get wpa => 'WPA/WPA2';

  @override
  String get wep => 'WEP';

  @override
  String get nopass => 'নেই';

  @override
  String get ok => 'ঠিক আছে';

  @override
  String get scanningHint => 'কোডটি ফ্রেমের ভিতরে রাখুন';

  @override
  String get imageScanning => 'ছবি স্ক্যান হচ্ছে…';

  @override
  String get scanPickUpPhone => 'স্ক্যান শুরু করতে ফোন তুলুন';

  @override
  String get typeSms => 'SMS';

  @override
  String get typeGeo => 'অবস্থান';

  @override
  String get typeProduct => 'পণ্য';

  @override
  String get typeContact => 'কন্টাক্ট';

  @override
  String get typeIsbn => 'ISBN';

  @override
  String get openWifi => 'Wi-Fi তথ্য';

  @override
  String get ssidLabel => 'SSID';

  @override
  String get passwordLabel => 'পাসওয়ার্ড';

  @override
  String get themeTitle => 'থিম';

  @override
  String get themeAppearance => 'চেহারা';

  @override
  String get themeSystem => 'সিস্টেম';

  @override
  String get themeLight => 'হালকা';

  @override
  String get themeDark => 'গাঢ়';

  @override
  String get themeColor => 'রঙ';

  @override
  String get themeOrange => 'কমলা';

  @override
  String get themeGreen => 'সবুজ';

  @override
  String get themeTeal => 'টিল';

  @override
  String get themeBlue => 'নীল';

  @override
  String get themeSlate => 'স্লেট';

  @override
  String get themePaper => 'কাগজ';

  @override
  String get themePaperFilter => 'কাগজের টেক্সচার';

  @override
  String get themePaperGrain => 'খসখসে ভাব';

  @override
  String get themePaperGrainFine => 'মসৃণ';

  @override
  String get themePaperGrainCoarse => 'খসখসে';

  @override
  String get themeFont => 'ফন্ট';

  @override
  String get themeIconStyle => 'আইকন';

  @override
  String get iconStyleAnime => 'অ্যানিমে';

  @override
  String get iconStyleBusiness => 'ব্যবসায়িক';

  @override
  String get fontRounded => 'গোলাকার';

  @override
  String get fontMaru => 'Maru';

  @override
  String get fontXiaoWei => 'XiaoWei';

  @override
  String get fontNunito => 'Nunito';

  @override
  String get fontSystem => 'সিস্টেম';
}
