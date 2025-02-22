import 'package:core/domain/entities/qr_code.dart';
import 'package:core/domain/repositories/qr_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seekqr_app/presentation/bloc/qr_scan_bloc/state/qr_scan_state.dart';

import 'event/qr_scan_event.dart';

class QrScanBloc extends Bloc<QrScanEvent, QrScanState> {
  final QrRepository qrRepository;

  QrScanBloc({required this.qrRepository}) : super(QrScanInitial());

  @override
  Stream<QrScanState> mapEventToState(QrScanEvent event) async* {
    if (event is ScanQrCode) {
      yield QrScanLoading(); // Estado de carga
      try {
        // Crear un objeto QrCode con los datos escaneados
        final qrCode = QrCode(data: event.data, timestamp: DateTime.now());

        // Guardar el código QR en el repositorio
        await qrRepository.saveQrCode(qrCode);

        // Éxito: Emitir el estado QrScanSuccess con el código QR
        yield QrScanSuccess(qrCode: qrCode);
      } catch (e) {
        // Error: Emitir el estado QrScanFailure con el mensaje de error
        yield QrScanFailure(error: e.toString());
      }
    }
  }
}