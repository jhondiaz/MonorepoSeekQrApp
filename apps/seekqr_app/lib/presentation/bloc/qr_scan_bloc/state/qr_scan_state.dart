
import 'package:core/domain/entities/qr_code.dart';

abstract class QrScanState {}

class QrScanInitial extends QrScanState {}

class QrScanLoading extends QrScanState {}

class QrScanSuccess extends QrScanState {
  final QrCode qrCode; // Código QR escaneado

  QrScanSuccess({required this.qrCode});
}

class QrScanFailure extends QrScanState {
  final String error; // Mensaje de error

  QrScanFailure({required this.error});
}