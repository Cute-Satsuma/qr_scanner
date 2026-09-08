// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appName => 'QR-Scanner';

  @override
  String get scanTab => 'Scannen';

  @override
  String get generateTab => 'Erstellen';

  @override
  String get historyTab => 'Verlauf';

  @override
  String get scanHistoryTitle => 'Scan-Verlauf';

  @override
  String get generateHistoryTitle => 'Erstell-Verlauf';

  @override
  String get settingsTab => 'Einstellungen';

  @override
  String get cameraPermissionDenied =>
      'Bitte Kamerazugriff erlauben, um Codes zu scannen';

  @override
  String cameraError(String error) {
    return 'Kamera konnte nicht gestartet werden: $error';
  }

  @override
  String get scanFromImage => 'Aus Bild scannen';

  @override
  String get torchOn => 'Taschenlampe ein';

  @override
  String get torchOff => 'Taschenlampe aus';

  @override
  String get switchCamera => 'Kamera wechseln';

  @override
  String get actionTorch => 'Blitz';

  @override
  String get actionAlbum => 'Album';

  @override
  String get actionFlip => 'Kamera';

  @override
  String get copy => 'Kopieren';

  @override
  String get copied => 'Kopiert';

  @override
  String get share => 'Teilen';

  @override
  String get openLink => 'Link öffnen';

  @override
  String get searchWeb => 'Im Web suchen';

  @override
  String get callNumber => 'Anrufen';

  @override
  String get sendEmail => 'E-Mail senden';

  @override
  String get sendSms => 'SMS senden';

  @override
  String get noHistory => 'Kein Verlauf';

  @override
  String get deleteRecord => 'Eintrag löschen';

  @override
  String get deleteRecordConfirm => 'Diesen Eintrag löschen?';

  @override
  String get deleteAllRecords => 'Alles löschen';

  @override
  String get deleteAllRecordsConfirm =>
      'Gesamten Verlauf löschen? Das kann nicht rückgängig gemacht werden.';

  @override
  String get recordDeleted => 'Eintrag gelöscht';

  @override
  String get allRecordsDeleted => 'Verlauf gelöscht';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get delete => 'Löschen';

  @override
  String get generateQr => 'QR-Code erstellen';

  @override
  String get inputHint => 'Inhalt eingeben';

  @override
  String get typeText => 'Text';

  @override
  String get typeUrl => 'URL';

  @override
  String get typeWifi => 'WLAN';

  @override
  String get typePhone => 'Telefon';

  @override
  String get typeEmail => 'E-Mail';

  @override
  String get wifiSsid => 'Netzwerkname (SSID)';

  @override
  String get wifiPassword => 'Passwort';

  @override
  String get wifiEncryption => 'Sicherheit';

  @override
  String get saveShareQr => 'QR-Bild teilen';

  @override
  String get scanResult => 'Ergebnis';

  @override
  String get generateResult => 'Erstelltes QR';

  @override
  String formatLabel(String format) {
    return 'Format: $format';
  }

  @override
  String get noCodeFound => 'In diesem Bild wurde kein Code gefunden';

  @override
  String get pickImageFailed => 'Bild konnte nicht geöffnet werden';

  @override
  String get enterContent => 'Inhalt eingeben, um einen QR-Code zu erstellen';

  @override
  String versionLabel(String version) {
    return 'Version $version';
  }

  @override
  String get aboutTitle => 'Info';

  @override
  String get aboutContent =>
      'Kostenloser QR- und Barcode-Scanner.\n\n• Keine Werbung, kein Konto\n• Verlauf nur auf diesem Gerät\n• Kamera nur im Scan-Tab\n• Offline nutzbar, außer beim Öffnen eines Links';

  @override
  String get liveScanUnsupported =>
      'Live-Scan ist auf dieser Plattform nicht verfügbar. Wähle ein Bild mit QR-Code.';

  @override
  String get wpa => 'WPA/WPA2';

  @override
  String get wep => 'WEP';

  @override
  String get nopass => 'Keine';

  @override
  String get ok => 'OK';

  @override
  String get scanningHint => 'Code im Rahmen ausrichten';

  @override
  String get imageScanning => 'Bild wird gescannt…';

  @override
  String get scanPickUpPhone =>
      'Hebe das Telefon an, um mit dem Scannen zu beginnen';

  @override
  String get typeSms => 'SMS';

  @override
  String get typeGeo => 'Ort';

  @override
  String get typeProduct => 'Produkt';

  @override
  String get typeContact => 'Kontakt';

  @override
  String get typeIsbn => 'ISBN';

  @override
  String get openWifi => 'WLAN-Daten';

  @override
  String get ssidLabel => 'SSID';

  @override
  String get passwordLabel => 'Passwort';

  @override
  String get themeTitle => 'Design';

  @override
  String get themeAppearance => 'Darstellung';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Hell';

  @override
  String get themeDark => 'Dunkel';

  @override
  String get themeColor => 'Farbe';

  @override
  String get themeOrange => 'Orange';

  @override
  String get themeGreen => 'Grün';

  @override
  String get themeTeal => 'Petrol';

  @override
  String get themeBlue => 'Blau';

  @override
  String get themeSlate => 'Schiefer';

  @override
  String get themePaper => 'Papier';

  @override
  String get themePaperFilter => 'Papiertextur';

  @override
  String get themePaperGrain => 'Rauheit';

  @override
  String get themePaperGrainFine => 'Glatt';

  @override
  String get themePaperGrainCoarse => 'Rau';

  @override
  String get themeFont => 'Schrift';

  @override
  String get themeIconStyle => 'Symbole';

  @override
  String get iconStyleAnime => 'Verspielt';

  @override
  String get iconStyleBusiness => 'Business';

  @override
  String get fontRounded => 'Rund';

  @override
  String get fontMaru => 'Maru';

  @override
  String get fontXiaoWei => 'XiaoWei';

  @override
  String get fontNunito => 'Nunito';

  @override
  String get fontSystem => 'System';
}
