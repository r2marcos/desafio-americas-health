import 'package:flutter_test/flutter_test.dart';
import 'package:frankfurter/apis/frankfurter/frankfurter_api.dart';

main() {
  test('get currencies', () async {
    final result = await FrankFurterApi.instance.getCurrencies();
    expect(result.statusCode, 200);
    expect(result.currencies, isNotEmpty);
  });

  test('get latest', () async {
    final result = await FrankFurterApi.instance
        .getLatest(from: 'USD', to: 'BRL', amount: 1.0);
    expect(result.statusCode, 200);
    expect(result.conversion, isNotNull);
  });

  test('get history', () async {
    final result = await FrankFurterApi.instance.getHistory(
        from: 'USD', to: 'BRL', amount: 1.0, startDate: DateTime(2021, 10, 1));
    expect(result.statusCode, 200);
    expect(result.conversion, isNotNull);
  });
}
