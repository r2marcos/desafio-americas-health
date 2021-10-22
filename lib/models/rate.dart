import 'dart:convert';

class Rate {
  final String currencyCode;
  final double amount;
  final DateTime? date;

  Rate({
    required this.currencyCode,
    required this.amount,
    this.date,
  });

  Rate copyWith({
    String? currencyCode,
    double? amount,
    DateTime? date,
  }) {
    return Rate(
      currencyCode: currencyCode ?? this.currencyCode,
      amount: amount ?? this.amount,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'currencyCode': currencyCode,
      'amount': amount,
      'date': date?.millisecondsSinceEpoch,
    };
  }

  factory Rate.fromMap(Map<String, dynamic> map) {
    return Rate(
      currencyCode: map['currencyCode'],
      amount: map['amount'],
      date: map['date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['date'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Rate.fromJson(String source) => Rate.fromMap(json.decode(source));

  @override
  String toString() =>
      'Rate(currencyCode: $currencyCode, amount: $amount, date: $date)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Rate &&
        other.currencyCode == currencyCode &&
        other.amount == amount &&
        other.date == date;
  }

  @override
  int get hashCode => currencyCode.hashCode ^ amount.hashCode ^ date.hashCode;
}
