
abstract class QrScanEvent {}

class ScanQrCode extends QrScanEvent {
  final String data; // Datos escaneados del código QR

  ScanQrCode({required this.data});
}