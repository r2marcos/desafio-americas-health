import 'dart:convert';

import 'package:frankfurter/apis/frankfurter/frankfurter_api.dart';
import 'package:frankfurter/models/currency.dart';
import 'package:http/http.dart' as http;

class GetCurrencies {
  static Future<GetCurrenciesResponse> execute(FrankFurterApi api) async {
    final uri = Uri.parse('${api.host}/currencies');

    final response = await http.get(uri);
    return GetCurrenciesResponse.parse(response);
  }
}

class GetCurrenciesResponse {
  final int statusCode;
  final String response;
  final List<Currency> currencies;

  GetCurrenciesResponse({
    required this.statusCode,
    required this.response,
    required this.currencies,
  });

  Map<String, dynamic> toMap() {
    return {
      'statusCode': statusCode,
      'response': response,
      'currencies': currencies.map((x) => x.toMap()).toList(),
    };
  }

  factory GetCurrenciesResponse.parse(http.Response response) {
    final data = jsonDecode(response.body) as Map;
    return GetCurrenciesResponse(
      statusCode: response.statusCode,
      response: response.body,
      currencies: data.entries
          .map((e) => Currency(code: e.key, name: e.value))
          .toList(),
    );
  }
}
