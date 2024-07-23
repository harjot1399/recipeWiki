import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/instruction.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


Future<List<Instruction>> fetchInstructions(int id) async {
  String apiUrl = 'https://api.spoonacular.com/recipes/$id/analyzedInstructions?apiKey=${dotenv.env['API_KEY']}';

  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        final List<Instruction> steps = (data[0]['steps'] as List)
            .map((stepJson) => Instruction.fromJson(stepJson))
            .toList();

        return steps;
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to load instruction');
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error Occurred: $e');
    }
    throw Exception('Error fetching instruction');
  }
}