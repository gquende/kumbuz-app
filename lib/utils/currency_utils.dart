import 'package:currency_formatter/currency_formatter.dart';

String currencyFormatUtils(dynamic value) {
  CurrencyFormat settings = const CurrencyFormat(
    symbol: 'AOA',
    symbolSide: SymbolSide.right,
    thousandSeparator: ' ',
    decimalSeparator: ',',
    symbolSeparator: ' ',
  );

  return CurrencyFormatter.format(value, settings);
}
