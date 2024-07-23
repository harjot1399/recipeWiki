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
      id: json['id'],
      title: json['title'],
      image: json['image'],
      imageType: json['imageType'],
      readyInMinutes: json['readyInMinutes'],
      score: json['spoonacularScore'].floor(),
      summary: json['summary']
    );
  }
}