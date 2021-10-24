import 'dart:convert';

import 'package:frankfurter/apis/frankfurter/frankfurter_api.dart';
import 'package:frankfurter/exceptions/fetch_data_exception.dart';
import 'package:frankfurter/models/conversion.dart';
import 'package:frankfurter/models/rate.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');

class GetLatest {
  static Future<GetLatestResponse> execute(FrankFurterApi api,
      {required String from,
      required String to,
      required double amount}) async {
    final uri =
        Uri.parse('${api.host}/latest?from=$from&to=$to&amount=$amount');

    try {
      final response = await http.get(uri);
      return GetLatestResponse.parse(response);
    } catch (e) {
      throw FetchDataException('No Internet Connection');
    }
  }
}

class GetLatestResponse {
  int statusCode;
  String response;
  final Conversion conversion;

  GetLatestResponse({
    required this.statusCode,
    required this.response,
    required this.conversion,
  });

  Map<String, dynamic> toMap() {
    return {
      'statusCode': statusCode,
      'response': response,
      'conversion': conversion.toMap(),
    };
  }

  factory GetLatestResponse.parse(http.Response response) {
    final data = jsonDecode(response.body) as Map;
    return GetLatestResponse(
      statusCode: response.statusCode,
      response: response.body,
      conversion: Conversion(
          amount: data['amount'],
          baseCurrencyCode: data['base'],
          date: _dateFormat.parse(data['date']),
          rates: (data['rates'] as Map)
              .entries
              .map((e) => Rate(
                  currencyCode: e.key,
                  amount: e.value.runtimeType == int
                      ? (e.value as int).toDouble()
                      : e.value))
              .toList()),
    );
  }
}
