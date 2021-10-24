import 'package:frankfurter/apis/frankfurter/frankfurter_api.dart';
import 'package:frankfurter/apis/frankfurter/methods/get_latest.dart';
import 'package:frankfurter/models/currency.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrencyRepository {
  CurrencyRepository._();
  static final CurrencyRepository instance = CurrencyRepository._();

  Future<List<Currency>> fetchData() async {
    final preferences = await SharedPreferences.getInstance();

    if (!preferences.containsKey('currencies')) {
      final result = await FrankFurterApi.instance.getCurrencies();
      if (result.statusCode == 200) {
        final currenciesStringList =
            result.currencies.map((e) => e.toJson()).toList();
        await preferences.setStringList('currencies', currenciesStringList);
      }
    }

    final currencies = preferences
        .getStringList('currencies')!
        .map((e) => Currency.fromJson(e))
        .toList();

    return currencies;
  }

  Future<GetLatestResponse> fetchRate(
          String from, String to, double amount) async =>
      await FrankFurterApi.instance
          .getLatest(from: from, to: to, amount: amount);
}
