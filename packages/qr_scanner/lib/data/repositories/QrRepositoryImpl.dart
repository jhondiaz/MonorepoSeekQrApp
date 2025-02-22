
import 'package:core/domain/entities/qr_code.dart';
import 'package:core/domain/repositories/qr_repository.dart';
import 'package:hive/hive.dart';
class QrRepositoryImpl implements QrRepository {
  final Box<QrCode> qrCodeBox;

  QrRepositoryImpl({required this.qrCodeBox});

  @override
  Future<void> saveQrCode(QrCode qrCode) async {
    try {
      // Guarda el código QR en la caja
      await qrCodeBox.add(qrCode);
    } catch (e) {
      throw Exception('Error al guardar el código QR: $e');
    }
  }

  @override
  Future<List<QrCode>> getQrCodes() async {
    try {
      // Obtiene todos los códigos QR almacenados en la caja
      final qrCodes = qrCodeBox.values.toList();
      return qrCodes;
    } catch (e) {
      // Maneja errores (por ejemplo, si la caja no está abierta)
      throw Exception('Error al obtener los códigos QR: $e');
    }
  }
}