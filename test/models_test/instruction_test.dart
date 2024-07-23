import 'package:flutter_test/flutter_test.dart';
import '../../lib/models/instruction.dart';

void main() {
  group('Instruction', () {
    test('Object creation with valid input', () {
      final instruction = Instruction(
        step: 'Mix the ingredients.',
        number: 1,
      );

      expect(instruction.step, 'Mix the ingredients.');
      expect(instruction.number, 1);
    });

    test('fromJson with valid JSON', () {
      final json = {
        'step': 'Mix the ingredients.',
        'number': 1,
      };
      final instruction = Instruction.fromJson(json);

      expect(instruction.step, 'Mix the ingredients.');
      expect(instruction.number, 1);
    });

    test('fromJson with missing fields', () {
      final json = {
        'step': 'Mix the ingredients.',
      };

      expect(() => Instruction.fromJson(json), throwsA(isA<TypeError>()));
    });

    test('fromJson with additional fields', () {
      final json = {
        'step': 'Mix the ingredients.',
        'number': 1,
        'extra': 'extra_value',
      };
      final instruction = Instruction.fromJson(json);

      expect(instruction.step, 'Mix the ingredients.');
      expect(instruction.number, 1);
    });

    test('fromJson with null fields', () {
      final json = {
        'step': null,
        'number': null,
      };

      expect(() => Instruction.fromJson(json), throwsA(isA<TypeError>()));
    });

    test('fromJson with empty fields', () {
      final json = {
        'step': '',
        'number': 0,
      };
      final instruction = Instruction.fromJson(json);

      expect(instruction.step, '');
      expect(instruction.number, 0);
    });


  });
}
