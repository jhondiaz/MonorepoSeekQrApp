import '../entities/qr_code.dart';

abstract class QrRepository {
  Future<void> saveQrCode(QrCode qrCode);
  Future<List<QrCode>> getQrCodes();
}