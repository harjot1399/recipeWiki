class Ingredient {
  final String image;
  final String name;
  final double value;
  final String unit;

  Ingredient({
    required this.image,
    required this.name,
    required this.value,
    required this.unit
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      value: json['amount']['metric']['value'],
      unit: json['amount']['metric']['unit'],
      image: json['image'],
      name: json['name'],
    );
  }
}