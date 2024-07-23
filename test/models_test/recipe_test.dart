import 'package:flutter_test/flutter_test.dart';
import '../../lib/models/recipe.dart';// Update the import to your actual file path

void main() {
  group('Recipe', () {
    test('fromJson with valid data', () {
      final json = {
        'id': 1,
        'title': 'Test Recipe',
        'image': 'http://example.com/image.jpg',
        'imageType': 'jpg',
        'readyInMinutes': 30,
        'spoonacularScore': 85.5,
        'summary': 'This is a test recipe.'
      };

      final recipe = Recipe.fromJson(json);

      expect(recipe.id, 1);
      expect(recipe.title, 'Test Recipe');
      expect(recipe.image, 'http://example.com/image.jpg');
      expect(recipe.imageType, 'jpg');
      expect(recipe.readyInMinutes, 30);
      expect(recipe.score, 85);
      expect(recipe.summary, 'This is a test recipe.');
    });

    test('fromJson with missing fields', () {
      final json = {
        'id': 1,
        'title': 'Test Recipe',
        'image': 'http://example.com/image.jpg',
        'imageType': 'jpg',
        'readyInMinutes': 30,
        'spoonacularScore': 85.5
        // 'summary' is missing
      };

      final recipe = Recipe.fromJson(json);

      expect(recipe.id, 1);
      expect(recipe.title, 'Test Recipe');
      expect(recipe.image, 'http://example.com/image.jpg');
      expect(recipe.imageType, 'jpg');
      expect(recipe.readyInMinutes, 30);
      expect(recipe.score, 85);
      expect(recipe.summary, ''); // Assuming default value is empty string
    });


    test('fromJson with empty JSON', () {
      final Map<String, dynamic> json = {};

      final recipe = Recipe.fromJson(json);

      expect(recipe.id, 0); // Assuming default value is 0
      expect(recipe.title, '');
      expect(recipe.image, '');
      expect(recipe.imageType, '');
      expect(recipe.readyInMinutes, 0);
      expect(recipe.score, 0);
      expect(recipe.summary, '');
    });
  });
}
