// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appName => 'Leitor QR Caju';

  @override
  String get scanTab => 'Ler';

  @override
  String get generateTab => 'Criar';

  @override
  String get historyTab => 'Histórico';

  @override
  String get scanHistoryTitle => 'Histórico de leitura';

  @override
  String get generateHistoryTitle => 'Histórico de criação';

  @override
  String get settingsTab => 'Definições';

  @override
  String get cameraPermissionDenied =>
      'Permita o acesso à câmara para ler códigos';

  @override
  String cameraError(String error) {
    return 'Não foi possível iniciar a câmara: $error';
  }

  @override
  String get scanFromImage => 'Ler a partir de imagem';

  @override
  String get torchOn => 'Ligar lanterna';

  @override
  String get torchOff => 'Desligar lanterna';

  @override
  String get switchCamera => 'Mudar câmara';

  @override
  String get actionTorch => 'Flash';

  @override
  String get actionAlbum => 'Álbum';

  @override
  String get actionFlip => 'Câmara';

  @override
  String get copy => 'Copiar';

  @override
  String get copied => 'Copiado';

  @override
  String get share => 'Partilhar';

  @override
  String get openLink => 'Abrir ligação';

  @override
  String get searchWeb => 'Pesquisar na web';

  @override
  String get callNumber => 'Ligar';

  @override
  String get sendEmail => 'Enviar e-mail';

  @override
  String get sendSms => 'Enviar SMS';

  @override
  String get noHistory => 'Sem histórico';

  @override
  String get deleteRecord => 'Eliminar registo';

  @override
  String get deleteRecordConfirm => 'Eliminar este registo?';

  @override
  String get deleteAllRecords => 'Eliminar tudo';

  @override
  String get deleteAllRecordsConfirm =>
      'Eliminar todo o histórico? Esta ação não pode ser anulada.';

  @override
  String get recordDeleted => 'Registo eliminado';

  @override
  String get allRecordsDeleted => 'Histórico eliminado';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get generateQr => 'Criar código QR';

  @override
  String get inputHint => 'Introduzir conteúdo';

  @override
  String get typeText => 'Texto';

  @override
  String get typeUrl => 'URL';

  @override
  String get typeWifi => 'Wi-Fi';

  @override
  String get typePhone => 'Telefone';

  @override
  String get typeEmail => 'E-mail';

  @override
  String get wifiSsid => 'Nome da rede (SSID)';

  @override
  String get wifiPassword => 'Palavra-passe';

  @override
  String get wifiEncryption => 'Segurança';

  @override
  String get saveShareQr => 'Partilhar imagem QR';

  @override
  String get scanResult => 'Resultado';

  @override
  String get generateResult => 'QR criado';

  @override
  String formatLabel(String format) {
    return 'Formato: $format';
  }

  @override
  String get noCodeFound => 'Não foi encontrado nenhum código nesta imagem';

  @override
  String get pickImageFailed => 'Não foi possível abrir a imagem';

  @override
  String get enterContent => 'Introduza o conteúdo para gerar um QR';

  @override
  String versionLabel(String version) {
    return 'Versão $version';
  }

  @override
  String get aboutTitle => 'Sobre';

  @override
  String get aboutContent =>
      'Leitor gratuito de QR e códigos de barras.\n\n• Sem anúncios e sem conta\n• O histórico fica só neste dispositivo\n• A câmara é usada apenas no separador Ler\n• Funciona offline, exceto ao abrir uma ligação';

  @override
  String get liveScanUnsupported =>
      'A leitura com câmara não está disponível nesta plataforma. Escolha uma imagem com um código QR.';

  @override
  String get wpa => 'WPA/WPA2';

  @override
  String get wep => 'WEP';

  @override
  String get nopass => 'Nenhuma';

  @override
  String get ok => 'OK';

  @override
  String get scanningHint => 'Alinhe o código dentro da moldura';

  @override
  String get imageScanning => 'A ler imagem…';

  @override
  String get scanPickUpPhone => 'Levante o telefone para começar a digitalizar';

  @override
  String get typeSms => 'SMS';

  @override
  String get typeGeo => 'Localização';

  @override
  String get typeProduct => 'Produto';

  @override
  String get typeContact => 'Contacto';

  @override
  String get typeIsbn => 'ISBN';

  @override
  String get openWifi => 'Dados Wi-Fi';

  @override
  String get ssidLabel => 'SSID';

  @override
  String get passwordLabel => 'Palavra-passe';

  @override
  String get themeTitle => 'Tema';

  @override
  String get themeAppearance => 'Aparência';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Escuro';

  @override
  String get themeColor => 'Cor';

  @override
  String get themeOrange => 'Laranja';

  @override
  String get themeGreen => 'Verde';

  @override
  String get themeTeal => 'Teal';

  @override
  String get themeBlue => 'Azul';

  @override
  String get themeSlate => 'Ardósia';

  @override
  String get themePaper => 'Papel';

  @override
  String get themePaperFilter => 'Textura de papel';

  @override
  String get themePaperGrain => 'Rugosidade';

  @override
  String get themePaperGrainFine => 'Liso';

  @override
  String get themePaperGrainCoarse => 'Áspero';

  @override
  String get themeFont => 'Fonte';

  @override
  String get themeIconStyle => 'Ícones';

  @override
  String get iconStyleAnime => 'Ilustrado';

  @override
  String get iconStyleBusiness => 'Executivo';

  @override
  String get fontRounded => 'Arredondada';

  @override
  String get fontMaru => 'Maru';

  @override
  String get fontXiaoWei => 'XiaoWei';

  @override
  String get fontNunito => 'Nunito';

  @override
  String get fontSystem => 'Sistema';
}
