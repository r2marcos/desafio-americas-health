import 'dart:convert';

import 'package:frankfurter/apis/frankfurter/frankfurter_api.dart';
import 'package:frankfurter/exceptions/fetch_data_exception.dart';
import 'package:frankfurter/models/conversion.dart';
import 'package:frankfurter/models/rate.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');

class GetHistory {
  static Future<GetHistoryResponse> execute(FrankFurterApi api,
      {required String from,
      required String to,
      required double amount,
      required DateTime startDate,
      DateTime? endDate}) async {
    final startDateStr = _dateFormat.format(startDate);
    final endDateStr = endDate == null ? '' : _dateFormat.format(endDate);

    final uri = Uri.parse(
        '${api.host}/$startDateStr..$endDateStr?from=$from&to=$to&amount=$amount');

    try {
      final response = await http.get(uri);
      return GetHistoryResponse.parse(response);
    } catch (e) {
      throw FetchDataException('No Internet Connection');
    }
  }
}

class GetHistoryResponse {
  int statusCode;
  String response;
  final Conversion conversion;

  GetHistoryResponse({
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

  factory GetHistoryResponse.parse(http.Response response) {
    final data = jsonDecode(response.body) as Map;
    return GetHistoryResponse(
      statusCode: response.statusCode,
      response: response.body,
      conversion: Conversion(
          amount: data['amount'],
          baseCurrencyCode: data['base'],
          startDate: _dateFormat.parse(data['start_date']),
          endDate: _dateFormat.parse(data['end_date']),
          rates: (data['rates'] as Map)
              .entries
              .map((e) => Rate(
                  date: _dateFormat.parse(e.key),
                  currencyCode: e.value.entries.first.key,
                  amount: e.value.entries.first.value))
              .toList()),
    );
  }
}
