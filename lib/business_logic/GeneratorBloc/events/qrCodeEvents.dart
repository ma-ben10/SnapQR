import 'dart:ui';

abstract class QrCodeEvents {}

class GenerateFromText extends QrCodeEvents {
  String text;

  GenerateFromText({required this.text});
}

class GenerateFromImage extends QrCodeEvents {
  Image image;

  GenerateFromImage({required this.image});
}
class SaveQrCode extends QrCodeEvents{}