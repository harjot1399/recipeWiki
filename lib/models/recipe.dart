class Recipe {
  final int id;
  final String title;
  final String image;
  final String imageType;
  final int readyInMinutes;
  final int score;
  final String summary;

  Recipe({
    required this.id,
    required this.title,
    required this.image,
    required this.imageType,
    required this.readyInMinutes,
    required this.score,
    required this.summary
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      imageType: json['imageType'] ?? '',
      readyInMinutes: json['readyInMinutes'] ?? 0,
      score: (json['spoonacularScore'] as num?)?.toDouble().floor() ?? 0,
      summary: json['summary'] ?? '', // Provide default value for missing field
    );
  }
}