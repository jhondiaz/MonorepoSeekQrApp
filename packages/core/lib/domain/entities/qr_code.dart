
import 'package:hive/hive.dart';

part 'qr_code.g.dart';

@HiveType(typeId: 0)
class QrCode {
  @HiveField(0)
  final String data;

  @HiveField(1)
  final DateTime timestamp;

  QrCode({required this.data, required this.timestamp});
}