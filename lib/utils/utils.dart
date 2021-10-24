import 'package:intl/intl.dart';

class Utils {
  static NumberFormat get _currencyFormatter =>
      NumberFormat.currency(locale: 'pt_BR', name: '', decimalDigits: 2);

  static String formatCurrency(double value) =>
      _currencyFormatter.format(value);
}
