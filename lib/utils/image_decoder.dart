import 'dart:typed_data';

import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:zxing2/qrcode.dart';

import 'platform_support.dart';

class DecodedCode {
  const DecodedCode({
    required this.rawValue,
    required this.format,
    this.hintedType,
  });

  final String rawValue;
  final String format;
  final String? hintedType;
}

Future<DecodedCode?> decodeFromXFile(XFile file) async {
  if (supportsNativeAnalyzeImage && file.path.isNotEmpty) {
    final controller = MobileScannerController(autoStart: false);
    try {
      final capture = await controller.analyzeImage(file.path);
      final barcode = capture?.barcodes.cast<Barcode?>().firstWhere(
        (item) => item?.rawValue != null && item!.rawValue!.isNotEmpty,
        orElse: () => null,
      );
      if (barcode?.rawValue != null) {
        return DecodedCode(
          rawValue: barcode!.rawValue!,
          format: barcode.format.name,
          hintedType: barcode.type.name,
        );
      }
    } catch (_) {
      // Fall through to the Dart decoder.
    } finally {
      controller.dispose();
    }
  }

  final bytes = await file.readAsBytes();
  return decodeQrBytes(bytes);
}

DecodedCode? decodeQrBytes(Uint8List bytes) {
  final decoded = img.decodeImage(bytes);
  if (decoded == null) return null;

  var image = decoded;
  const maxSide = 1600;
  if (image.width > maxSide || image.height > maxSide) {
    image = img.copyResize(
      image,
      width: image.width >= image.height ? maxSide : null,
      height: image.height > image.width ? maxSide : null,
    );
  }

  final pixels = image
      .convert(numChannels: 4)
      .getBytes(order: img.ChannelOrder.abgr)
      .buffer
      .asInt32List();
  final source = RGBLuminanceSource(image.width, image.height, pixels);

  Result? tryDecode(Binarizer binarizer) {
    try {
      return QRCodeReader().decode(BinaryBitmap(binarizer));
    } catch (_) {
      return null;
    }
  }

  final result =
      tryDecode(HybridBinarizer(source)) ??
      tryDecode(GlobalHistogramBinarizer(source));
  if (result == null || result.text.isEmpty) return null;
  return DecodedCode(rawValue: result.text, format: 'qrCode');
}
