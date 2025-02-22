import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner/data/repositories/QrRepositoryImpl.dart';

import '../bloc/qr_scan_bloc/event/qr_scan_event.dart';
import '../bloc/qr_scan_bloc/qr_scan_bloc.dart';
import '../bloc/qr_scan_bloc/state/qr_scan_state.dart';


class QrScanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QrScanBloc(qrRepository: QrRepositoryImpl(qrCodeBox: null)),
      child: Scaffold(
        appBar: AppBar(title: Text('Escáner QR')),
        body: BlocConsumer<QrScanBloc, QrScanState>(
          listener: (context, state) {
            if (state is QrScanFailure) {
              // Mostrar un mensaje de error si ocurre un fallo
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          builder: (context, state) {
            if (state is QrScanLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is QrScanSuccess) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Código QR escaneado:'),
                    Text(state.qrCode.data),
                    Text('Escaneado el: ${state.qrCode.timestamp}'),
                  ],
                ),
              );
            } else {
              return Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Simular el escaneo de un código QR
                    final fakeQrData = 'https://example.com';
                    context.read<QrScanBloc>().add(ScanQrCode(data: fakeQrData));
                  },
                  child: Text('Escanear Código QR'),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}