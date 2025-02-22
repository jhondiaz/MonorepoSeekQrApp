import 'package:core/domain/entities/qr_code.dart';
import 'package:core/domain/repositories/qr_repository.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:qr_scanner/data/repositories/QrRepositoryImpl.dart';
import 'package:qr_scanner/qr_scanner.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(QrCodeAdapter()); // Registra el adaptador generado
  final qrCodeBox = await Hive.openBox<QrCode>('qr_codes'); // Abre la caja

  final qrRepository = QrRepositoryImpl(qrCodeBox: qrCodeBox);

  runApp(MyApp(qrRepository: qrRepository));
}

class MyApp extends StatelessWidget {
  final QrRepository qrRepository;

  const MyApp({required this.qrRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('QR Scan App')),
        body: Center(
          child: FutureBuilder<List<QrCode>>(
            future: qrRepository.getQrCodes(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Text('No hay códigos QR escaneados.');
              } else {
                final qrCodes = snapshot.data!;
                return ListView.builder(
                  itemCount: qrCodes.length,
                  itemBuilder: (context, index) {
                    final qrCode = qrCodes[index];
                    return ListTile(
                      title: Text(qrCode.data),
                      subtitle: Text('Escaneado el ${qrCode.timestamp}'),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}


