import 'package:intl/intl.dart';

String Numbercurrentformat(current) {
  final formatCurrent = NumberFormat.simpleCurrency(
    locale: 'vi_vn',
    decimalDigits: 0,
  );
  return formatCurrent.format(current);
}
