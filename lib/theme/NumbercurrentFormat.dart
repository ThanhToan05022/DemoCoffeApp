import 'package:intl/intl.dart';

String Numbercurrentformat(num? current) {
  final value = current ?? 0;

  final formatCurrent = NumberFormat.simpleCurrency(
    locale: 'vi_VN',
    decimalDigits: 0,
  );

  return formatCurrent.format(value);
}
