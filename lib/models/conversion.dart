import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:frankfurter/models/rate.dart';

class Conversion {
  final double amount;
  final String baseCurrencyCode;
  final DateTime? date;
  final DateTime? startDate;
  final DateTime? endDate;
  List<Rate> rates;

  Conversion({
    required this.amount,
    required this.baseCurrencyCode,
    this.date,
    this.startDate,
    this.endDate,
    required this.rates,
  });

  Conversion copyWith({
    double? amount,
    String? baseCurrencyCode,
    DateTime? date,
    DateTime? startDate,
    DateTime? endDate,
    List<Rate>? rates,
  }) {
    return Conversion(
      amount: amount ?? this.amount,
      baseCurrencyCode: baseCurrencyCode ?? this.baseCurrencyCode,
      date: date ?? this.date,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      rates: rates ?? this.rates,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'baseCurrencyCode': baseCurrencyCode,
      'date': date?.millisecondsSinceEpoch,
      'startDate': startDate?.millisecondsSinceEpoch,
      'endDate': endDate?.millisecondsSinceEpoch,
      'rates': rates.map((x) => x.toMap()).toList(),
    };
  }

  factory Conversion.fromMap(Map<String, dynamic> map) {
    return Conversion(
      amount: map['amount'],
      baseCurrencyCode: map['baseCurrencyCode'],
      date: map['date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['date'])
          : null,
      startDate: map['startDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['startDate'])
          : null,
      endDate: map['endDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['endDate'])
          : null,
      rates: List<Rate>.from(map['rates']?.map((x) => Rate.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Conversion.fromJson(String source) =>
      Conversion.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Conversion(amount: $amount, baseCurrencyCode: $baseCurrencyCode, date: $date, startDate: $startDate, endDate: $endDate, rates: $rates)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Conversion &&
        other.amount == amount &&
        other.baseCurrencyCode == baseCurrencyCode &&
        other.date == date &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        listEquals(other.rates, rates);
  }

  @override
  int get hashCode {
    return amount.hashCode ^
        baseCurrencyCode.hashCode ^
        date.hashCode ^
        startDate.hashCode ^
        endDate.hashCode ^
        rates.hashCode;
  }
}
