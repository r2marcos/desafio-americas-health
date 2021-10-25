import 'package:flutter/material.dart';
import 'package:frankfurter/models/currency.dart';
import 'package:frankfurter/repositories/currency_repository.dart';

class RateProvider with ChangeNotifier {
  double _amount = 0.0;
  double get amount => _amount;
  set amount(double value) {
    _amount = value;
    notifyListeners();
  }

  double _rate = 0.0;
  double get rate => _rate;
  set rate(double value) {
    _rate = value;
    notifyListeners();
  }

  String? _rateCurrencyCode = '';
  String get rateCurrencyCode => _rateCurrencyCode ?? '';
  set rateCurrencyCode(String value) {
    _rateCurrencyCode = value;
    notifyListeners();
  }

  List<Currency> _currencies = [];
  List<Currency> get currencies => _currencies;
  set currencies(List<Currency> value) {
    _currencies = value;
    notifyListeners();
  }

  Currency? _fromCurrency;
  Currency? get fromCurrency => _fromCurrency;
  set fromCurrency(Currency? value) {
    _fromCurrency = value;
    notifyListeners();
  }

  Currency? _toCurrency;
  Currency? get toCurrency => _toCurrency;
  set toCurrency(Currency? value) {
    _toCurrency = value;
    notifyListeners();
  }

  fetchCurrencies() async =>
      currencies = await CurrencyRepository.instance.fetchData();

  fetchRate() async {
    final response = await CurrencyRepository.instance
        .fetchRate(fromCurrency!.code, toCurrency!.code, amount);
    if (response.statusCode == 200) {
      rate = response.conversion.rates.single.amount;
      rateCurrencyCode = response.conversion.rates.single.currencyCode;
    }
  }

  tooggleCurrencies() {
    final currentFromCurrency = fromCurrency;
    final currentToCurrency = toCurrency;

    fromCurrency = currentToCurrency;
    toCurrency = currentFromCurrency;
  }
}
