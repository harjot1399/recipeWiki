import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import '../models/recipe.dart';
import '../services/fetch_equipment.dart';
import '../services/fetch_ingredient.dart';
import '../services/fetch_instructions.dart';
import '../services/fetch_nutrient.dart';
import 'recipe_page.dart';

class RecipesList extends StatefulWidget {
  final List<Recipe> recipes;
  final int totalRecipes;
  final String baseURL;

  const RecipesList({super.key, required this.recipes, required this.totalRecipes, required this.baseURL});

  @override
  State<RecipesList> createState() => _RecipesListState();
}

class _RecipesListState extends State<RecipesList> {

  List<Recipe> recipes = [];
  int offsetNumber = 0;
  bool isLoadMoreRecipes = true;

  @override
  void initState() {
    super.initState();
    recipes = widget.recipes;
  }


  void offSetUpdate () {
    int fetchedRecipes = offsetNumber + 25;
    if (fetchedRecipes >= widget.totalRecipes){
      setState(() {
        isLoadMoreRecipes = false;
        offsetNumber = 0;
      });
    }else{
      setState(() {
        offsetNumber = fetchedRecipes;

      });
    }
  }

  Future<void> fetchMoreRecipes () async {
    offSetUpdate();
    final String apiUrl = "${widget.baseURL}&offset=$offsetNumber";

    try{
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200){
        final Map<String, dynamic> data = json.decode(response.body);
        final List<Recipe> newRecipes = (data['results'] as List)
            .map((recipeJson) => Recipe.fromJson(recipeJson))
            .toList();

        setState(() {
          recipes.addAll(newRecipes);
        });
      }else {
        throw Exception('Failed to load more recipes');
      }
    }catch (error){
      if (kDebugMode) {
        print(error);

      }}
  }


  Future<Map<String, dynamic>> fetchRecipeDetails(int id) async {
    final equipmentFuture = fetchEquipment(id);
    final nutrientFuture = fetchNutrient(id);
    final ingredientFuture = fetchIngredients(id);
    final instructionFuture = fetchInstructions(id);

    final results = await Future.wait([
      equipmentFuture,
      nutrientFuture,
      ingredientFuture,
      instructionFuture,
    ]);

    return {
      'equipment': results[0],
      'nutrients': results[1],
      'ingredients': results[2],
      'instructions': results[3],
    };
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const Gap(60),
                    const Center(
                      child: Text(
                        "Recipe Wiki",
                        style: TextStyle(color: Colors.green, fontSize: 30),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(20),
              const Padding(
                padding: EdgeInsets.only(left: 30),
                child: Text(
                  "Recipes",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
              const Gap(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.recipes.length,
                  itemBuilder: (context, index) {
                    final recipe = widget.recipes[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => const Center(
                              child: CircularProgressIndicator(color: Colors.green,),
                            ),
                          );
                          fetchRecipeDetails(recipe.id).then((details) {
                            Navigator.pop(context); // Close the CircularProgressIndicator
                            if (context.mounted) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RecipePage(
                                    recipe: recipe,
                                    equipments: details['equipment'],
                                    nutrients: details['nutrients'],
                                    ingredients: details['ingredients'],
                                    instructions: details['instructions'],
                                  ),
                                ),
                              );
                            }
                          }).catchError((error) {
                            Navigator.pop(context); // Close the CircularProgressIndicator
                            if (kDebugMode) {
                              print('Error Occurred: $error');
                            }
                          });
                        },
                        child: SizedBox(
                          height: 100,
                          width: double.infinity,
                          child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    recipe.image,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const Gap(20),
                                Expanded(
                                  child: Text(
                                    recipe.title,
                                    style: const TextStyle(fontSize: 16),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Gap(10),
              if (isLoadMoreRecipes)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Center(
                    child: SizedBox(
                      width: 150,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: fetchMoreRecipes,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: Colors.green,
                          elevation: 3, // Elevation (shadow)
                        ),
                        child: const Text('View More', style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
