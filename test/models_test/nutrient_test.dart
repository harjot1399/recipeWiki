import 'package:flutter_test/flutter_test.dart';
import '../../lib/models/nutrient.dart';

void main() {
  group('Nutrient', () {
    test('Object creation with valid input', () {
      final nutrient = Nutrient(
        name: 'Protein',
        unit: 'g',
        amount: 12.5,
      );

      expect(nutrient.name, 'Protein');
      expect(nutrient.unit, 'g');
      expect(nutrient.amount, 12.5);
    });

    test('fromJson with valid JSON and double amount', () {
      final json = {
        'name': 'Protein',
        'unit': 'g',
        'amount': 12.5,
      };
      final nutrient = Nutrient.fromJson(json);

      expect(nutrient.name, 'Protein');
      expect(nutrient.unit, 'g');
      expect(nutrient.amount, 12.5);
    });

    test('fromJson with valid JSON and int amount', () {
      final json = {
        'name': 'Carbohydrates',
        'unit': 'g',
        'amount': 30,
      };
      final nutrient = Nutrient.fromJson(json);

      expect(nutrient.name, 'Carbohydrates');
      expect(nutrient.unit, 'g');
      expect(nutrient.amount, 30.0);
    });

    test('fromJson with invalid amount type', () {
      final json = {
        'name': 'Fat',
        'unit': 'g',
        'amount': 'invalid',
      };

      expect(() => Nutrient.fromJson(json), throwsException);
    });
    //
    test('fromJson with missing fields', () {
      final json = {
        'name': 'Fat',
        'unit': 'g',
      };

      expect(() => Nutrient.fromJson(json), throwsA(isA<Exception>()));
    });

    test('fromJson with additional fields', () {
      final json = {
        'name': 'Fat',
        'unit': 'g',
        'amount': 20.0,
        'extra': 'extra_value',
      };
      final nutrient = Nutrient.fromJson(json);

      expect(nutrient.name, 'Fat');
      expect(nutrient.unit, 'g');
      expect(nutrient.amount, 20.0);
    });

  });
}
