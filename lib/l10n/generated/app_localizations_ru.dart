// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appName => 'QR-сканер';

  @override
  String get scanTab => 'Сканер';

  @override
  String get generateTab => 'Создать';

  @override
  String get historyTab => 'История';

  @override
  String get scanHistoryTitle => 'История сканирования';

  @override
  String get generateHistoryTitle => 'История создания';

  @override
  String get settingsTab => 'Настройки';

  @override
  String get cameraPermissionDenied =>
      'Разрешите доступ к камере, чтобы сканировать коды';

  @override
  String cameraError(String error) {
    return 'Не удалось запустить камеру: $error';
  }

  @override
  String get scanFromImage => 'Сканировать из изображения';

  @override
  String get torchOn => 'Включить фонарик';

  @override
  String get torchOff => 'Выключить фонарик';

  @override
  String get switchCamera => 'Сменить камеру';

  @override
  String get actionTorch => 'Вспышка';

  @override
  String get actionAlbum => 'Альбом';

  @override
  String get actionFlip => 'Камера';

  @override
  String get copy => 'Копировать';

  @override
  String get copied => 'Скопировано';

  @override
  String get share => 'Поделиться';

  @override
  String get openLink => 'Открыть ссылку';

  @override
  String get searchWeb => 'Искать в интернете';

  @override
  String get callNumber => 'Позвонить';

  @override
  String get sendEmail => 'Отправить письмо';

  @override
  String get sendSms => 'Отправить SMS';

  @override
  String get noHistory => 'История пуста';

  @override
  String get deleteRecord => 'Удалить запись';

  @override
  String get deleteRecordConfirm => 'Удалить эту запись?';

  @override
  String get deleteAllRecords => 'Удалить всё';

  @override
  String get deleteAllRecordsConfirm =>
      'Удалить всю историю? Это действие нельзя отменить.';

  @override
  String get recordDeleted => 'Запись удалена';

  @override
  String get allRecordsDeleted => 'История удалена';

  @override
  String get cancel => 'Отмена';

  @override
  String get delete => 'Удалить';

  @override
  String get generateQr => 'Создать QR-код';

  @override
  String get inputHint => 'Введите содержимое';

  @override
  String get typeText => 'Текст';

  @override
  String get typeUrl => 'URL';

  @override
  String get typeWifi => 'Wi-Fi';

  @override
  String get typePhone => 'Телефон';

  @override
  String get typeEmail => 'Эл. почта';

  @override
  String get wifiSsid => 'Имя сети (SSID)';

  @override
  String get wifiPassword => 'Пароль';

  @override
  String get wifiEncryption => 'Защита';

  @override
  String get saveShareQr => 'Поделиться изображением QR';

  @override
  String get scanResult => 'Результат';

  @override
  String get generateResult => 'Созданный QR';

  @override
  String formatLabel(String format) {
    return 'Формат: $format';
  }

  @override
  String get noCodeFound => 'В этом изображении код не найден';

  @override
  String get pickImageFailed => 'Не удалось открыть изображение';

  @override
  String get enterContent => 'Введите текст, чтобы создать QR-код';

  @override
  String versionLabel(String version) {
    return 'Версия $version';
  }

  @override
  String get aboutTitle => 'О приложении';

  @override
  String get aboutContent =>
      'Бесплатный сканер QR и штрихкодов.\n\n• Без рекламы и аккаунта\n• История хранится только на этом устройстве\n• Камера используется только на вкладке сканера\n• Работает офлайн, кроме открытия ссылок';

  @override
  String get liveScanUnsupported =>
      'Живое сканирование камерой недоступно. Выберите изображение с QR-кодом.';

  @override
  String get wpa => 'WPA/WPA2';

  @override
  String get wep => 'WEP';

  @override
  String get nopass => 'Нет';

  @override
  String get ok => 'OK';

  @override
  String get scanningHint => 'Поместите код в рамку';

  @override
  String get imageScanning => 'Сканирование изображения…';

  @override
  String get scanPickUpPhone => 'Поднимите телефон, чтобы начать сканирование';

  @override
  String get typeSms => 'SMS';

  @override
  String get typeGeo => 'Геопозиция';

  @override
  String get typeProduct => 'Товар';

  @override
  String get typeContact => 'Контакт';

  @override
  String get typeIsbn => 'ISBN';

  @override
  String get openWifi => 'Данные Wi-Fi';

  @override
  String get ssidLabel => 'SSID';

  @override
  String get passwordLabel => 'Пароль';

  @override
  String get themeTitle => 'Тема';

  @override
  String get themeAppearance => 'Оформление';

  @override
  String get themeSystem => 'Система';

  @override
  String get themeLight => 'Светлая';

  @override
  String get themeDark => 'Тёмная';

  @override
  String get themeColor => 'Цвет';

  @override
  String get themeOrange => 'Оранжевый';

  @override
  String get themeGreen => 'Зелёный';

  @override
  String get themeTeal => 'Бирюза';

  @override
  String get themeBlue => 'Синий';

  @override
  String get themeSlate => 'Графит';

  @override
  String get themePaper => 'Бумага';

  @override
  String get themePaperFilter => 'Бумажная текстура';

  @override
  String get themePaperGrain => 'Шероховатость';

  @override
  String get themePaperGrainFine => 'Гладкая';

  @override
  String get themePaperGrainCoarse => 'Шершавая';

  @override
  String get themeFont => 'Шрифт';

  @override
  String get themeIconStyle => 'Значки';

  @override
  String get iconStyleAnime => 'Мульт';

  @override
  String get iconStyleBusiness => 'Деловой';

  @override
  String get fontRounded => 'Скруглённый';

  @override
  String get fontMaru => 'Maru';

  @override
  String get fontXiaoWei => 'XiaoWei';

  @override
  String get fontNunito => 'Nunito';

  @override
  String get fontSystem => 'Система';
}
