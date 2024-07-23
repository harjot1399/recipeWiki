import 'package:flutter_test/flutter_test.dart';
import '../../lib/models/equipment.dart';

void main() {

  group('Equipment', () {
    test('Object creation with valid input', () {
      final equipment = Equipment(image: 'image_url', name: 'Spatula');

      expect(equipment.image, 'image_url');
      expect(equipment.name, 'Spatula');
    });

    test('fromJson with valid JSON', () {
      final json = {'image': 'image_url', 'name': 'Spatula'};
      final equipment = Equipment.fromJson(json);

      expect(equipment.image, 'image_url');
      expect(equipment.name, 'Spatula');
    });

    test('fromJson with missing fields', () {
      final json = {'name': 'Spatula'};

      expect(() => Equipment.fromJson(json), throwsA(isA<TypeError>()));
    });

    test('fromJson with additional fields', () {
      final json = {
        'image': 'image_url',
        'name': 'Spatula',
        'extra': 'extra_value'
      };
      final equipment = Equipment.fromJson(json);

      expect(equipment.image, 'image_url');
      expect(equipment.name, 'Spatula');
    });

    test('fromJson with null fields', () {
      final json = {'image': null, 'name': null};

      expect(() => Equipment.fromJson(json), throwsA(isA<TypeError>()));
    });

    test('fromJson with empty fields', () {
      final json = {'image': '', 'name': ''};
      final equipment = Equipment.fromJson(json);

      expect(equipment.image, '');
      expect(equipment.name, '');
    });

  });

}