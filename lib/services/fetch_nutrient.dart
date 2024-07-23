import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../models/nutrient.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<List<Nutrient>> fetchNutrient(int id) async {
  String apiUrl = 'https://api.spoonacular.com/recipes/$id/nutritionWidget.json?apiKey=${dotenv.env['API_KEY']}';

  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<Nutrient> nutrients = (data['nutrients'] as List)
          .map((nutrientJson) => Nutrient.fromJson(nutrientJson))
          .toList();

      return nutrients;
    } else {
      throw Exception('Failed to load recipes');
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error Occurred: $e');
    }
    if (kDebugMode) {
      print(apiUrl);
    }
    throw Exception('Error fetching equipment');
  }
}