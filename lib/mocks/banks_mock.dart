import '../features/open_finance/domain/entity/bank_entity.dart';

List<Bank> mockBanks = [
  Bank(
    "1a2b3c4d",
    "Bank of America",
    "BOFAUS3N",
    "https://logo.com/bankofamerica.png",
  )..countries = ["US", "MX", "CA"],
  Bank(
    "2e3f4g5h",
    "HSBC",
    "HSBCGB2L",
    "https://logo.com/hsbc.png",
  )..countries = ["GB", "HK", "FR"],
  Bank(
    "3i4j5k6l",
    "Santander",
    "BSCHESMM",
    "https://logo.com/santander.png",
  )..countries = ["ES", "BR", "MX"],
  Bank(
    "4m5n6o7p",
    "ING",
    "INGBNL2A",
    "https://logo.com/ing.png",
  )..countries = ["NL", "BE", "DE"],
  Bank(
    "5q6r7s8t",
    "Deutsche Bank",
    "DEUTDEFF",
    "https://logo.com/deutschebank.png",
  )..countries = ["DE", "US", "IN"]
];
