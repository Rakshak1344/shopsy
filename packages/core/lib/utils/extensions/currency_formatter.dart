import 'package:intl/intl.dart';

extension CurrencyPriceFormatter on double {
  String formatAsCurrency() {
    return NumberFormat.simpleCurrency(
      locale: 'en_IN',
      name: 'INR',
    ).format(this);
  }
}
