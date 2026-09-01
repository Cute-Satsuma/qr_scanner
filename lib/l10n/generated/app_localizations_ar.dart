// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'مسح QR Caju';

  @override
  String get scanTab => 'مسح';

  @override
  String get generateTab => 'إنشاء';

  @override
  String get historyTab => 'السجل';

  @override
  String get scanHistoryTitle => 'سجل المسح';

  @override
  String get generateHistoryTitle => 'سجل الإنشاء';

  @override
  String get settingsTab => 'الإعدادات';

  @override
  String get cameraPermissionDenied => 'يرجى السماح بالكاميرا لمسح الرموز';

  @override
  String cameraError(String error) {
    return 'تعذر تشغيل الكاميرا: $error';
  }

  @override
  String get scanFromImage => 'مسح من صورة';

  @override
  String get torchOn => 'تشغيل الفلاش';

  @override
  String get torchOff => 'إيقاف الفلاش';

  @override
  String get switchCamera => 'تبديل الكاميرا';

  @override
  String get actionTorch => 'فلاش';

  @override
  String get actionAlbum => 'ألبوم';

  @override
  String get actionFlip => 'كاميرا';

  @override
  String get copy => 'نسخ';

  @override
  String get copied => 'تم النسخ';

  @override
  String get share => 'مشاركة';

  @override
  String get openLink => 'فتح الرابط';

  @override
  String get searchWeb => 'بحث على الويب';

  @override
  String get callNumber => 'اتصال';

  @override
  String get sendEmail => 'إرسال بريد';

  @override
  String get sendSms => 'إرسال رسالة';

  @override
  String get noHistory => 'لا يوجد سجل';

  @override
  String get deleteRecord => 'حذف السجل';

  @override
  String get deleteRecordConfirm => 'حذف هذا السجل؟';

  @override
  String get deleteAllRecords => 'حذف الكل';

  @override
  String get deleteAllRecordsConfirm => 'حذف كل السجل؟ لا يمكن التراجع عن ذلك.';

  @override
  String get recordDeleted => 'تم الحذف';

  @override
  String get allRecordsDeleted => 'تم حذف السجل';

  @override
  String get cancel => 'إلغاء';

  @override
  String get delete => 'حذف';

  @override
  String get generateQr => 'إنشاء رمز QR';

  @override
  String get inputHint => 'أدخل المحتوى';

  @override
  String get typeText => 'نص';

  @override
  String get typeUrl => 'رابط';

  @override
  String get typeWifi => 'Wi-Fi';

  @override
  String get typePhone => 'هاتف';

  @override
  String get typeEmail => 'بريد';

  @override
  String get wifiSsid => 'اسم الشبكة (SSID)';

  @override
  String get wifiPassword => 'كلمة المرور';

  @override
  String get wifiEncryption => 'الحماية';

  @override
  String get saveShareQr => 'مشاركة صورة QR';

  @override
  String get scanResult => 'النتيجة';

  @override
  String get generateResult => 'رمز تم إنشاؤه';

  @override
  String formatLabel(String format) {
    return 'التنسيق: $format';
  }

  @override
  String get noCodeFound => 'لم يتم العثور على رمز في هذه الصورة';

  @override
  String get pickImageFailed => 'تعذر فتح الصورة';

  @override
  String get enterContent => 'أدخل محتوى لإنشاء رمز QR';

  @override
  String versionLabel(String version) {
    return 'الإصدار $version';
  }

  @override
  String get aboutTitle => 'حول';

  @override
  String get aboutContent =>
      'ماسح رموز QR والباركود مجاني.\n\n• بدون إعلانات وبدون حساب\n• السجل يُحفظ على هذا الجهاز فقط\n• تُستخدم الكاميرا في تبويب المسح فقط\n• يعمل دون اتصال باستثناء فتح الروابط';

  @override
  String get liveScanUnsupported =>
      'المسح المباشر غير متاح على هذه المنصة. اختر صورة تحتوي على رمز QR.';

  @override
  String get wpa => 'WPA/WPA2';

  @override
  String get wep => 'WEP';

  @override
  String get nopass => 'بدون';

  @override
  String get ok => 'حسنًا';

  @override
  String get scanningHint => 'ضع الرمز داخل الإطار';

  @override
  String get imageScanning => 'جارٍ مسح الصورة…';

  @override
  String get scanPickUpPhone => 'ارفع هاتفك لبدء المسح';

  @override
  String get typeSms => 'رسالة';

  @override
  String get typeGeo => 'موقع';

  @override
  String get typeProduct => 'منتج';

  @override
  String get typeContact => 'جهة اتصال';

  @override
  String get typeIsbn => 'ISBN';

  @override
  String get openWifi => 'بيانات Wi-Fi';

  @override
  String get ssidLabel => 'SSID';

  @override
  String get passwordLabel => 'كلمة المرور';

  @override
  String get themeTitle => 'السمة';

  @override
  String get themeAppearance => 'المظهر';

  @override
  String get themeSystem => 'النظام';

  @override
  String get themeLight => 'فاتح';

  @override
  String get themeDark => 'داكن';

  @override
  String get themeColor => 'اللون';

  @override
  String get themeOrange => 'برتقالي';

  @override
  String get themeGreen => 'أخضر';

  @override
  String get themeTeal => 'أزرق مخضر';

  @override
  String get themeBlue => 'أزرق';

  @override
  String get themeSlate => 'رمادي';

  @override
  String get themePaper => 'ورق';

  @override
  String get themePaperFilter => 'ملمس الورق';

  @override
  String get themePaperGrain => 'الخشونة';

  @override
  String get themePaperGrainFine => 'أملس';

  @override
  String get themePaperGrainCoarse => 'خشن';

  @override
  String get themeFont => 'الخط';

  @override
  String get themeIconStyle => 'الأيقونات';

  @override
  String get iconStyleAnime => 'كرتوني';

  @override
  String get iconStyleBusiness => 'أعمال';

  @override
  String get fontRounded => 'مستدير';

  @override
  String get fontMaru => 'Maru';

  @override
  String get fontXiaoWei => 'XiaoWei';

  @override
  String get fontNunito => 'Nunito';

  @override
  String get fontSystem => 'النظام';
}
