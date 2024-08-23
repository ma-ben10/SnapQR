abstract class ScannerQrEvent {}

class CatchDataFromQr extends ScannerQrEvent {
  String data;

  CatchDataFromQr({required this.data});
}
