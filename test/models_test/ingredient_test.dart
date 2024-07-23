import 'package:flutter_test/flutter_test.dart';
import '../../lib/models/ingredient.dart';

void main() {
  group('Ingredient', () {
    test('Object creation with valid input', () {
      final ingredient = Ingredient(
        image: 'image_url',
        name: 'Flour',
        value: 200.0,
        unit: 'g',
      );

      expect(ingredient.image, 'image_url');
      expect(ingredient.name, 'Flour');
      expect(ingredient.value, 200.0);
      expect(ingredient.unit, 'g');
    });

    test('fromJson with valid JSON', () {
      final json = {
        'amount': {
          'metric': {
            'value': 200.0,
            'unit': 'g'
          }
        },
        'image': 'image_url',
        'name': 'Flour'
      };
      final ingredient = Ingredient.fromJson(json);

      expect(ingredient.image, 'image_url');
      expect(ingredient.name, 'Flour');
      expect(ingredient.value, 200.0);
      expect(ingredient.unit, 'g');
    });

    test('fromJson with missing fields', () {
      final json = {
        'amount': {
          'metric': {
            'unit': 'g'
          }
        },
        'image': 'image_url',
        'name': 'Flour'
      };

      expect(() => Ingredient.fromJson(json), throwsA(isA<TypeError>()));
    });

    test('fromJson with additional fields', () {
      final json = {
        'amount': {
          'metric': {
            'value': 200.0,
            'unit': 'g'
          }
        },
        'image': 'image_url',
        'name': 'Flour',
        'extra': 'extra_value'
      };
      final ingredient = Ingredient.fromJson(json);

      expect(ingredient.image, 'image_url');
      expect(ingredient.name, 'Flour');
      expect(ingredient.value, 200.0);
      expect(ingredient.unit, 'g');
    });

    test('fromJson with null fields', () {
      final json = {
        'amount': {
          'metric': {
            'value': null,
            'unit': null
          }
        },
        'image': null,
        'name': null
      };

      expect(() => Ingredient.fromJson(json), throwsA(isA<TypeError>()));
    });

    test('fromJson with empty fields', () {
      final json = {
        'amount': {
          'metric': {
            'value': 0.0,
            'unit': ''
          }
        },
        'image': '',
        'name': ''
      };
      final ingredient = Ingredient.fromJson(json);

      expect(ingredient.image, '');
      expect(ingredient.name, '');
      expect(ingredient.value, 0.0);
      expect(ingredient.unit, '');
    });
  });
}
