// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appName => 'QRスキャン Caju';

  @override
  String get scanTab => 'スキャン';

  @override
  String get generateTab => '作成';

  @override
  String get historyTab => '履歴';

  @override
  String get scanHistoryTitle => '読み取り履歴';

  @override
  String get generateHistoryTitle => '作成履歴';

  @override
  String get settingsTab => '設定';

  @override
  String get cameraPermissionDenied => 'コードを読み取るにはカメラの使用を許可してください';

  @override
  String cameraError(String error) {
    return 'カメラを起動できません: $error';
  }

  @override
  String get scanFromImage => '画像から読み取る';

  @override
  String get torchOn => 'ライトをオン';

  @override
  String get torchOff => 'ライトをオフ';

  @override
  String get switchCamera => 'カメラを切り替え';

  @override
  String get actionTorch => 'ライト';

  @override
  String get actionAlbum => 'アルバム';

  @override
  String get actionFlip => '切替';

  @override
  String get copy => 'コピー';

  @override
  String get copied => 'コピーしました';

  @override
  String get share => '共有';

  @override
  String get openLink => 'リンクを開く';

  @override
  String get searchWeb => 'ウェブ検索';

  @override
  String get callNumber => '電話をかける';

  @override
  String get sendEmail => 'メールを送信';

  @override
  String get sendSms => 'SMSを送信';

  @override
  String get noHistory => '履歴はありません';

  @override
  String get deleteRecord => '記録を削除';

  @override
  String get deleteRecordConfirm => 'この記録を削除しますか？';

  @override
  String get deleteAllRecords => 'すべて削除';

  @override
  String get deleteAllRecordsConfirm => '履歴をすべて削除しますか？この操作は元に戻せません。';

  @override
  String get recordDeleted => '削除しました';

  @override
  String get allRecordsDeleted => '履歴をすべて削除しました';

  @override
  String get cancel => 'キャンセル';

  @override
  String get delete => '削除';

  @override
  String get generateQr => 'QRコードを作成';

  @override
  String get inputHint => '内容を入力';

  @override
  String get typeText => 'テキスト';

  @override
  String get typeUrl => 'URL';

  @override
  String get typeWifi => 'Wi-Fi';

  @override
  String get typePhone => '電話';

  @override
  String get typeEmail => 'メール';

  @override
  String get wifiSsid => 'ネットワーク名 (SSID)';

  @override
  String get wifiPassword => 'パスワード';

  @override
  String get wifiEncryption => 'セキュリティ';

  @override
  String get saveShareQr => 'QR画像を共有';

  @override
  String get scanResult => '読み取り結果';

  @override
  String get generateResult => '作成結果';

  @override
  String formatLabel(String format) {
    return '形式: $format';
  }

  @override
  String get noCodeFound => 'この画像にコードは見つかりませんでした';

  @override
  String get pickImageFailed => '画像を開けませんでした';

  @override
  String get enterContent => 'QRコードにする内容を入力してください';

  @override
  String versionLabel(String version) {
    return 'バージョン $version';
  }

  @override
  String get aboutTitle => 'このアプリについて';

  @override
  String get aboutContent =>
      '無料のQR / バーコードスキャナーです。\n\n• 広告なし、アカウント不要\n• 履歴はこの端末のみに保存\n• カメラはスキャン画面でのみ使用\n• リンクを開くとき以外はオフラインで利用できます';

  @override
  String get liveScanUnsupported => 'この環境ではライブスキャンに対応していません。QRコードの画像を選んでください。';

  @override
  String get wpa => 'WPA/WPA2';

  @override
  String get wep => 'WEP';

  @override
  String get nopass => 'なし';

  @override
  String get ok => 'OK';

  @override
  String get scanningHint => '枠の中にコードを合わせてください';

  @override
  String get imageScanning => '画像を読み取り中…';

  @override
  String get scanPickUpPhone => 'スキャンを開始するには携帯電話を持ち上げてください';

  @override
  String get typeSms => 'SMS';

  @override
  String get typeGeo => '位置情報';

  @override
  String get typeProduct => '商品';

  @override
  String get typeContact => '連絡先';

  @override
  String get typeIsbn => 'ISBN';

  @override
  String get openWifi => 'Wi-Fi情報';

  @override
  String get ssidLabel => 'SSID';

  @override
  String get passwordLabel => 'パスワード';

  @override
  String get themeTitle => 'テーマ';

  @override
  String get themeAppearance => '外観';

  @override
  String get themeSystem => 'システム';

  @override
  String get themeLight => 'ライト';

  @override
  String get themeDark => 'ダーク';

  @override
  String get themeColor => '配色';

  @override
  String get themeOrange => 'オレンジ';

  @override
  String get themeGreen => 'グリーン';

  @override
  String get themeTeal => 'ティール';

  @override
  String get themeBlue => 'ブルー';

  @override
  String get themeSlate => 'スレート';

  @override
  String get themePaper => 'ペーパー';

  @override
  String get themePaperFilter => '紙の質感';

  @override
  String get themePaperGrain => 'ざらつき';

  @override
  String get themePaperGrainFine => 'なめらか';

  @override
  String get themePaperGrainCoarse => '粗い';

  @override
  String get themeFont => 'フォント';

  @override
  String get themeIconStyle => 'アイコン';

  @override
  String get iconStyleAnime => 'アニメ';

  @override
  String get iconStyleBusiness => 'ビジネス';

  @override
  String get fontRounded => 'ラウンド';

  @override
  String get fontMaru => '丸ゴ';

  @override
  String get fontXiaoWei => '小薇';

  @override
  String get fontNunito => 'Nunito';

  @override
  String get fontSystem => 'システム';
}
