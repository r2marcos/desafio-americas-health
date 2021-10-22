import 'package:frankfurter/apis/frankfurter/methods/get_currencies.dart';
import 'package:frankfurter/apis/frankfurter/methods/get_history.dart';
import 'package:frankfurter/apis/frankfurter/methods/get_latest.dart';

class FrankFurterApi {
  FrankFurterApi._();
  static final FrankFurterApi instance = FrankFurterApi._();

  final String host = 'https://api.frankfurter.app';

  Future<GetCurrenciesResponse> getCurrencies() async =>
      await GetCurrencies.execute(this);

  Future<GetLatestResponse> getLatest(
          {required String from,
          required String to,
          required double amount}) async =>
      await GetLatest.execute(this, from: from, to: to, amount: amount);

  Future<GetHistoryResponse> getHistory(
          {required String from,
          required String to,
          required double amount,
          required DateTime startDate,
          DateTime? endDate}) async =>
      await GetHistory.execute(this,
          from: from,
          to: to,
          amount: amount,
          startDate: startDate,
          endDate: endDate);
}
