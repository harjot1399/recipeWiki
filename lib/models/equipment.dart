class Equipment {
  final String image;
  final String name;

  Equipment({
    required this.image,
    required this.name,
  });

  factory Equipment.fromJson(Map<String, dynamic> json) {
    return Equipment(
      image: json['image'],
      name: json['name'],
    );
  }
}