// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appName => '扫一扫';

  @override
  String get scanTab => '扫码';

  @override
  String get generateTab => '生成';

  @override
  String get historyTab => '历史';

  @override
  String get scanHistoryTitle => '扫码历史';

  @override
  String get generateHistoryTitle => '生成历史';

  @override
  String get settingsTab => '设置';

  @override
  String get cameraPermissionDenied => '请允许使用相机以扫描二维码';

  @override
  String cameraError(String error) {
    return '无法启动相机: $error';
  }

  @override
  String get scanFromImage => '从相册识别';

  @override
  String get torchOn => '打开手电筒';

  @override
  String get torchOff => '关闭手电筒';

  @override
  String get switchCamera => '切换摄像头';

  @override
  String get actionTorch => '闪光灯';

  @override
  String get actionAlbum => '相册';

  @override
  String get actionFlip => '翻转';

  @override
  String get copy => '复制';

  @override
  String get copied => '已复制';

  @override
  String get share => '分享';

  @override
  String get openLink => '打开链接';

  @override
  String get searchWeb => '网页搜索';

  @override
  String get callNumber => '拨打电话';

  @override
  String get sendEmail => '发送邮件';

  @override
  String get sendSms => '发送短信';

  @override
  String get noHistory => '暂无记录';

  @override
  String get deleteRecord => '删除记录';

  @override
  String get deleteRecordConfirm => '确定删除这条记录吗？';

  @override
  String get deleteAllRecords => '删除全部记录';

  @override
  String get deleteAllRecordsConfirm => '确定删除全部历史吗？此操作无法撤销。';

  @override
  String get recordDeleted => '记录已删除';

  @override
  String get allRecordsDeleted => '全部记录已删除';

  @override
  String get cancel => '取消';

  @override
  String get delete => '删除';

  @override
  String get generateQr => '生成二维码';

  @override
  String get inputHint => '输入内容';

  @override
  String get typeText => '文本';

  @override
  String get typeUrl => '链接';

  @override
  String get typeWifi => 'Wi-Fi';

  @override
  String get typePhone => '电话';

  @override
  String get typeEmail => '邮箱';

  @override
  String get wifiSsid => '网络名称 (SSID)';

  @override
  String get wifiPassword => '密码';

  @override
  String get wifiEncryption => '加密方式';

  @override
  String get saveShareQr => '分享二维码图片';

  @override
  String get scanResult => '扫码结果';

  @override
  String get generateResult => '生成结果';

  @override
  String formatLabel(String format) {
    return '格式: $format';
  }

  @override
  String get noCodeFound => '这张图片里没有找到二维码或条码';

  @override
  String get pickImageFailed => '无法打开图片';

  @override
  String get enterContent => '请输入要生成二维码的内容';

  @override
  String versionLabel(String version) {
    return '版本 $version';
  }

  @override
  String get aboutTitle => '关于';

  @override
  String get aboutContent =>
      '免费二维码 / 条码扫描工具。\n\n• 无广告、无需账号\n• 历史记录只保存在本机\n• 仅在扫码页使用相机\n• 除打开链接外均可离线使用';

  @override
  String get liveScanUnsupported => '当前平台不支持实时摄像头扫码，请选择包含二维码的图片。';

  @override
  String get wpa => 'WPA/WPA2';

  @override
  String get wep => 'WEP';

  @override
  String get nopass => '无密码';

  @override
  String get ok => '确定';

  @override
  String get scanningHint => '将二维码对准取景框';

  @override
  String get imageScanning => '正在识别图片…';

  @override
  String get scanPickUpPhone => '拿起手机开始扫码';

  @override
  String get typeSms => '短信';

  @override
  String get typeGeo => '位置';

  @override
  String get typeProduct => '商品条码';

  @override
  String get typeContact => '名片';

  @override
  String get typeIsbn => 'ISBN';

  @override
  String get openWifi => 'Wi-Fi 信息';

  @override
  String get ssidLabel => '名称';

  @override
  String get passwordLabel => '密码';

  @override
  String get themeTitle => '主题';

  @override
  String get themeAppearance => '外观';

  @override
  String get themeSystem => '系统';

  @override
  String get themeLight => '浅色';

  @override
  String get themeDark => '深色';

  @override
  String get themeColor => '配色';

  @override
  String get themeOrange => '柑色';

  @override
  String get themeGreen => '绿色';

  @override
  String get themeTeal => '青绿';

  @override
  String get themeBlue => '蓝色';

  @override
  String get themeSlate => '岩灰';

  @override
  String get themePaper => '纸色';

  @override
  String get themePaperFilter => '纸质滤镜';

  @override
  String get themePaperGrain => '粗糙度';

  @override
  String get themePaperGrainFine => '细腻';

  @override
  String get themePaperGrainCoarse => '粗糙';

  @override
  String get themeFont => '字体';

  @override
  String get themeIconStyle => '图标风格';

  @override
  String get iconStyleAnime => '动画';

  @override
  String get iconStyleBusiness => '商务';

  @override
  String get fontRounded => '圆润';

  @override
  String get fontMaru => '圆体';

  @override
  String get fontXiaoWei => '小薇';

  @override
  String get fontNunito => '软圆';

  @override
  String get fontSystem => '系统';
}

/// The translations for Chinese, as used in China (`zh_CN`).
class AppLocalizationsZhCn extends AppLocalizationsZh {
  AppLocalizationsZhCn() : super('zh_CN');

  @override
  String get appName => '扫一扫';

  @override
  String get scanTab => '扫码';

  @override
  String get generateTab => '生成';

  @override
  String get historyTab => '历史';

  @override
  String get scanHistoryTitle => '扫码历史';

  @override
  String get generateHistoryTitle => '生成历史';

  @override
  String get settingsTab => '设置';

  @override
  String get cameraPermissionDenied => '请允许使用相机以扫描二维码';

  @override
  String cameraError(String error) {
    return '无法启动相机: $error';
  }

  @override
  String get scanFromImage => '从相册识别';

  @override
  String get torchOn => '打开手电筒';

  @override
  String get torchOff => '关闭手电筒';

  @override
  String get switchCamera => '切换摄像头';

  @override
  String get actionTorch => '闪光灯';

  @override
  String get actionAlbum => '相册';

  @override
  String get actionFlip => '翻转';

  @override
  String get copy => '复制';

  @override
  String get copied => '已复制';

  @override
  String get share => '分享';

  @override
  String get openLink => '打开链接';

  @override
  String get searchWeb => '网页搜索';

  @override
  String get callNumber => '拨打电话';

  @override
  String get sendEmail => '发送邮件';

  @override
  String get sendSms => '发送短信';

  @override
  String get noHistory => '暂无记录';

  @override
  String get deleteRecord => '删除记录';

  @override
  String get deleteRecordConfirm => '确定删除这条记录吗？';

  @override
  String get deleteAllRecords => '删除全部记录';

  @override
  String get deleteAllRecordsConfirm => '确定删除全部历史吗？此操作无法撤销。';

  @override
  String get recordDeleted => '记录已删除';

  @override
  String get allRecordsDeleted => '全部记录已删除';

  @override
  String get cancel => '取消';

  @override
  String get delete => '删除';

  @override
  String get generateQr => '生成二维码';

  @override
  String get inputHint => '输入内容';

  @override
  String get typeText => '文本';

  @override
  String get typeUrl => '链接';

  @override
  String get typeWifi => 'Wi-Fi';

  @override
  String get typePhone => '电话';

  @override
  String get typeEmail => '邮箱';

  @override
  String get wifiSsid => '网络名称 (SSID)';

  @override
  String get wifiPassword => '密码';

  @override
  String get wifiEncryption => '加密方式';

  @override
  String get saveShareQr => '分享二维码图片';

  @override
  String get scanResult => '扫码结果';

  @override
  String get generateResult => '生成结果';

  @override
  String formatLabel(String format) {
    return '格式: $format';
  }

  @override
  String get noCodeFound => '这张图片里没有找到二维码或条码';

  @override
  String get pickImageFailed => '无法打开图片';

  @override
  String get enterContent => '请输入要生成二维码的内容';

  @override
  String versionLabel(String version) {
    return '版本 $version';
  }

  @override
  String get aboutTitle => '关于';

  @override
  String get aboutContent =>
      '免费二维码 / 条码扫描工具。\n\n• 无广告、无需账号\n• 历史记录只保存在本机\n• 仅在扫码页使用相机\n• 除打开链接外均可离线使用';

  @override
  String get liveScanUnsupported => '当前平台不支持实时摄像头扫码，请选择包含二维码的图片。';

  @override
  String get wpa => 'WPA/WPA2';

  @override
  String get wep => 'WEP';

  @override
  String get nopass => '无密码';

  @override
  String get ok => '确定';

  @override
  String get scanningHint => '将二维码对准取景框';

  @override
  String get imageScanning => '正在识别图片…';

  @override
  String get scanPickUpPhone => '拿起手机开始扫码';

  @override
  String get typeSms => '短信';

  @override
  String get typeGeo => '位置';

  @override
  String get typeProduct => '商品条码';

  @override
  String get typeContact => '名片';

  @override
  String get typeIsbn => 'ISBN';

  @override
  String get openWifi => 'Wi-Fi 信息';

  @override
  String get ssidLabel => '名称';

  @override
  String get passwordLabel => '密码';

  @override
  String get themeTitle => '主题';

  @override
  String get themeAppearance => '外观';

  @override
  String get themeSystem => '系统';

  @override
  String get themeLight => '浅色';

  @override
  String get themeDark => '深色';

  @override
  String get themeColor => '配色';

  @override
  String get themeOrange => '柑色';

  @override
  String get themeGreen => '绿色';

  @override
  String get themeTeal => '青绿';

  @override
  String get themeBlue => '蓝色';

  @override
  String get themeSlate => '岩灰';

  @override
  String get themePaper => '纸色';

  @override
  String get themePaperFilter => '纸质滤镜';

  @override
  String get themePaperGrain => '粗糙度';

  @override
  String get themePaperGrainFine => '细腻';

  @override
  String get themePaperGrainCoarse => '粗糙';

  @override
  String get themeFont => '字体';

  @override
  String get themeIconStyle => '图标风格';

  @override
  String get iconStyleAnime => '动画';

  @override
  String get iconStyleBusiness => '商务';

  @override
  String get fontRounded => '圆润';

  @override
  String get fontMaru => '圆体';

  @override
  String get fontXiaoWei => '小薇';

  @override
  String get fontNunito => '软圆';

  @override
  String get fontSystem => '系统';
}
