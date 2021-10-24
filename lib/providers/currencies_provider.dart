import 'package:flutter/material.dart';
import 'package:frankfurter/models/currency.dart';
import 'package:frankfurter/repositories/currency_repository.dart';

class CurrenciesProvider with ChangeNotifier {
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

  tooggleCurrencies() {
    final currentFromCurrency = fromCurrency;
    final currentToCurrency = toCurrency;

    fromCurrency = currentToCurrency;
    toCurrency = currentFromCurrency;

    notifyListeners();
  }
}
