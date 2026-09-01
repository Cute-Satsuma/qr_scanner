// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'Escáner QR Caju';

  @override
  String get scanTab => 'Escanear';

  @override
  String get generateTab => 'Crear';

  @override
  String get historyTab => 'Historial';

  @override
  String get scanHistoryTitle => 'Historial de escaneo';

  @override
  String get generateHistoryTitle => 'Historial de creación';

  @override
  String get settingsTab => 'Ajustes';

  @override
  String get cameraPermissionDenied =>
      'Permite el acceso a la cámara para escanear códigos';

  @override
  String cameraError(String error) {
    return 'No se pudo iniciar la cámara: $error';
  }

  @override
  String get scanFromImage => 'Escanear desde imagen';

  @override
  String get torchOn => 'Encender linterna';

  @override
  String get torchOff => 'Apagar linterna';

  @override
  String get switchCamera => 'Cambiar cámara';

  @override
  String get actionTorch => 'Flash';

  @override
  String get actionAlbum => 'Álbum';

  @override
  String get actionFlip => 'Cámara';

  @override
  String get copy => 'Copiar';

  @override
  String get copied => 'Copiado';

  @override
  String get share => 'Compartir';

  @override
  String get openLink => 'Abrir enlace';

  @override
  String get searchWeb => 'Buscar en la web';

  @override
  String get callNumber => 'Llamar';

  @override
  String get sendEmail => 'Enviar correo';

  @override
  String get sendSms => 'Enviar SMS';

  @override
  String get noHistory => 'Sin historial';

  @override
  String get deleteRecord => 'Eliminar registro';

  @override
  String get deleteRecordConfirm => '¿Eliminar este registro?';

  @override
  String get deleteAllRecords => 'Eliminar todo';

  @override
  String get deleteAllRecordsConfirm =>
      '¿Eliminar todo el historial? Esta acción no se puede deshacer.';

  @override
  String get recordDeleted => 'Registro eliminado';

  @override
  String get allRecordsDeleted => 'Todo el historial eliminado';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get generateQr => 'Crear código QR';

  @override
  String get inputHint => 'Escribe el contenido';

  @override
  String get typeText => 'Texto';

  @override
  String get typeUrl => 'URL';

  @override
  String get typeWifi => 'Wi-Fi';

  @override
  String get typePhone => 'Teléfono';

  @override
  String get typeEmail => 'Correo';

  @override
  String get wifiSsid => 'Nombre de red (SSID)';

  @override
  String get wifiPassword => 'Contraseña';

  @override
  String get wifiEncryption => 'Seguridad';

  @override
  String get saveShareQr => 'Compartir imagen QR';

  @override
  String get scanResult => 'Resultado';

  @override
  String get generateResult => 'QR creado';

  @override
  String formatLabel(String format) {
    return 'Formato: $format';
  }

  @override
  String get noCodeFound => 'No se encontró un código en esta imagen';

  @override
  String get pickImageFailed => 'No se pudo abrir la imagen';

  @override
  String get enterContent => 'Escribe algo para generar un código QR';

  @override
  String versionLabel(String version) {
    return 'Versión $version';
  }

  @override
  String get aboutTitle => 'Acerca de';

  @override
  String get aboutContent =>
      'Escáner de códigos QR y de barras gratuito.\n\n• Sin anuncios ni cuenta\n• El historial se guarda solo en este dispositivo\n• La cámara se usa solo en la pestaña Escanear\n• Funciona sin conexión, excepto al abrir un enlace';

  @override
  String get liveScanUnsupported =>
      'Este dispositivo no admite el escaneo con cámara. Elige una imagen con un código QR.';

  @override
  String get wpa => 'WPA/WPA2';

  @override
  String get wep => 'WEP';

  @override
  String get nopass => 'Ninguna';

  @override
  String get ok => 'OK';

  @override
  String get scanningHint => 'Alinea el código dentro del recuadro';

  @override
  String get imageScanning => 'Escaneando imagen…';

  @override
  String get scanPickUpPhone => 'Levanta el teléfono para empezar a escanear';

  @override
  String get typeSms => 'SMS';

  @override
  String get typeGeo => 'Ubicación';

  @override
  String get typeProduct => 'Producto';

  @override
  String get typeContact => 'Contacto';

  @override
  String get typeIsbn => 'ISBN';

  @override
  String get openWifi => 'Datos Wi-Fi';

  @override
  String get ssidLabel => 'SSID';

  @override
  String get passwordLabel => 'Contraseña';

  @override
  String get themeTitle => 'Tema';

  @override
  String get themeAppearance => 'Apariencia';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get themeColor => 'Color';

  @override
  String get themeOrange => 'Naranja';

  @override
  String get themeGreen => 'Verde';

  @override
  String get themeTeal => 'Turquesa';

  @override
  String get themeBlue => 'Azul';

  @override
  String get themeSlate => 'Pizarra';

  @override
  String get themePaper => 'Papel';

  @override
  String get themePaperFilter => 'Textura de papel';

  @override
  String get themePaperGrain => 'Rugosidad';

  @override
  String get themePaperGrainFine => 'Suave';

  @override
  String get themePaperGrainCoarse => 'Áspero';

  @override
  String get themeFont => 'Fuente';

  @override
  String get themeIconStyle => 'Iconos';

  @override
  String get iconStyleAnime => 'Ilustrado';

  @override
  String get iconStyleBusiness => 'Ejecutivo';

  @override
  String get fontRounded => 'Redondeada';

  @override
  String get fontMaru => 'Maru';

  @override
  String get fontXiaoWei => 'XiaoWei';

  @override
  String get fontNunito => 'Nunito';

  @override
  String get fontSystem => 'Sistema';
}
