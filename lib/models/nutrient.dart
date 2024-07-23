class Nutrient {
  final String name;
  final String unit;
  final double amount;

  Nutrient({
    required this.name,
    required this.unit,
    required this.amount
  });

  factory Nutrient.fromJson(Map<String, dynamic> json) {
    return Nutrient(
      name: json['name'],
      unit: json['unit'],
      amount: _toDouble(json['amount'])
    );
  }

  static double _toDouble(dynamic value) {
    if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    } else {
      throw Exception('Invalid type for amount: ${value.runtimeType}');
    }
  }
}