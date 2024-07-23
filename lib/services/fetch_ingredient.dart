import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../models/ingredient.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<List<Ingredient>> fetchIngredients(int id) async {
  String apiUrl = 'https://api.spoonacular.com/recipes/$id/ingredientWidget.json?apiKey=${dotenv.env['API_KEY']}';

  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<Ingredient> ingredients = (data['ingredients'] as List)
          .map((ingredientJson) => Ingredient.fromJson(ingredientJson))
          .toList();

      return ingredients;
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