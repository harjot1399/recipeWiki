import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:recipewiki/models/recipe.dart';
import 'package:recipewiki/views/recipes_list.dart';
import 'package:recipewiki/widgets/selections_widget.dart';

class SearchRecipe extends StatefulWidget {
  const SearchRecipe({super.key});

  @override
  State<SearchRecipe> createState() => _SearchRecipeState();
}

class _SearchRecipeState extends State<SearchRecipe> {
  bool isAdvanced = false;
  bool showCuisines = false;
  bool showDiets = false;
  bool showCalories = false;
  bool showMealTypes = false;
  bool showTolerances= false;
  TextEditingController searchItem = TextEditingController();
  TextEditingController minCaloriesController = TextEditingController();
  TextEditingController maxCaloriesController = TextEditingController();
  Set<String> selectedCuisines = <String>{};
  Set<String> selectedDiets = <String>{};
  Set<String> selectedMealTypes = <String>{};
  Set<String> selectedIntolerances = <String>{};

  void toggleSwitch(bool value){
    setState(() {
      isAdvanced = value;
    });
  }


  void toggleCalories () {
    setState(() {
      showCalories = !showCalories;
    });
  }

  final List<String> diets = [
    "Gluten Free",
    "Ketogenic",
    "Vegetarian",
    "Lacto-Vegetarian",
    "Ovo-Vegetarian",
    "Vegan",
    "Pescetarian",
    "Paleo",
    "Primal",
    "Low FODMAP",
    "Whole30"
  ];

  final List<String> mealTypes = [
    'Main Course',
    'Side Dish',
    'Dessert',
    'Appetizer',
    'Salad',
    'Bread',
    'Breakfast',
    'Soup',
    'Beverage',
    'Sauce',
  ];


  final List<String> cuisines = const [
    'African',
    'Asian',
    'American',
    'British',
    'Cajun',
    'Caribbean',
    'Chinese',
    'Eastern European',
    'European',
    'French',
    'German',
    'Greek',
    'Indian',
    'Irish',
    'Italian',
    'Japanese',
    'Jewish',
    'Korean',
    'Latin American',
    'Mediterranean',
    'Mexican',
    'Middle Eastern',
    'Nordic',
    'Southern',
    'Spanish',
    'Thai',
    'Vietnamese'
  ];

  final List<String> intolerances = [
    'Dairy',
    'Egg',
    'Gluten',
    'Grain',
    'Peanut',
    'Seafood',
    'Sesame',
    'Shellfish',
    'Soy',
    'Sulfite',
    'Tree Nut',
    'Wheat'
  ];

  Future<void> fetchRecipes () async {


    String baseApiUrl = 'https://api.spoonacular.com/recipes/complexSearch?apiKey=${dotenv.env['API_KEY']}&number=25&addRecipeInformation=true';
    List<String> queryParams = [];

    if (searchItem.text.isNotEmpty){
      queryParams.add('query=${searchItem.text}');
    }

    if (minCaloriesController.text.isNotEmpty){
      queryParams.add('minCalories=${minCaloriesController.text}');
    }

    if (maxCaloriesController.text.isNotEmpty){
      queryParams.add('maxCalories=${maxCaloriesController.text}');
    }

    if (selectedCuisines.isNotEmpty){
      String cuisines = selectedCuisines.join(',');
      queryParams.add('cuisine=$cuisines');
    }

    if (selectedDiets.isNotEmpty){
      String diets = selectedDiets.join(',');
      queryParams.add('diet=$diets');
    }


    if (selectedMealTypes.isNotEmpty){
      String mealTypes = selectedMealTypes.join(',');
      queryParams.add('type=$mealTypes');
    }

    if (selectedIntolerances.isNotEmpty){
      String intolerances = selectedIntolerances.join(',');
      queryParams.add('intolerances=$intolerances');

    }

    String finalApiUrl = '$baseApiUrl&${queryParams.join('&')}';

    try{
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(color: Colors.green),
        ),
      );
      final response = await http.get(Uri.parse(finalApiUrl));

      if (response.statusCode == 200){
        final Map<String, dynamic> data = json.decode(response.body);
        final List<Recipe> recipes = (data['results'] as List)
            .map((recipeJson) => Recipe.fromJson(recipeJson))
            .toList();

        final int totalRecipes = data['totalResults'];

        if (mounted) {// Check if the widget is still mounted
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(

              builder: (context) => RecipesList(recipes: recipes, totalRecipes: totalRecipes,baseURL: finalApiUrl,),
            ),
          );
        }
      } else {
        throw Exception('Failed to load recipes');
      }

    } catch(e) {
      Navigator.pop(context);
      print('Error Occurred: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(child: Text("Recipe Wiki", style: TextStyle(color: Colors.green, fontSize: 30),)),
                const Gap(20),
                Card(
                  color: Colors.white,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: SizedBox(
                    width: 350,
                    child: TextField(
                      controller: searchItem,
                      decoration: const InputDecoration(
                        hintText: "Search for any recipe",
                        prefixIcon: Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          borderSide: BorderSide.none, // Removes the underline
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0), // Adjusts padding
                      ),
                    ),
                  ),
                ),
                const Gap(10),
                Row(
                  children: [
                    const Text("Advanced Search", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                    const Spacer(),
                    Transform.scale(
                        scale: 0.7,
                        child: Switch(
                            value: isAdvanced,
                            onChanged: toggleSwitch,
                          activeColor: Colors.green,
                          activeTrackColor: Colors.lightGreen, // Track color when the switch is on
                          inactiveThumbColor: Colors.grey, // Thumb color when the switch is off
                          inactiveTrackColor: Colors.grey[400], // Thumb color when the switch is off
                        )
          
                    )
          
                  ],
                ),

                const Gap(20),
                if (isAdvanced) // Use curly braces here
                  SelectionsWidget(title: "Cuisines", options: cuisines, selectedOptions: selectedCuisines),

                if (isAdvanced) // Use curly braces here
                  SelectionsWidget(title: "Diets", options: diets, selectedOptions: selectedDiets),

                if (isAdvanced) // Use curly braces here
                  SelectionsWidget(title: "Meal Types", options: mealTypes, selectedOptions: selectedMealTypes),

                if (isAdvanced) // Use curly braces here
                  SelectionsWidget(title: "Intolerances", options: intolerances, selectedOptions: selectedIntolerances),

                if (isAdvanced) // Use curly braces here
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Calories", style: TextStyle(fontSize: 20)),
                          IconButton(
                            onPressed: toggleCalories,
                            icon: Icon(showCalories ? Icons.remove : Icons.add),
                          ),
                        ],
                      ),
                      if (showCalories)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 90,
                              height: 40,// Adjust the width of the TextField
                              child: TextField(
                                controller: minCaloriesController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: 'Min',
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green), // Focused border color
                                  ),
                                  contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0), // Adjust padding
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Text('to', style: TextStyle(fontSize: 20),),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: 90,
                              height: 40,// Adjust the width of the TextField
                              child: TextField(
                                controller: maxCaloriesController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: 'Max',
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green), // Focused border color
                                  ),
                                  contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0), // Adjust padding
                                ),
                              ),
                            ),
                          ],
                        ),


                    ],
                  ),
                const Gap(20),// End of if (isAdvanced)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Center(
                    child: SizedBox(
                      width: 150,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: fetchRecipes,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: Colors.green,
                          elevation: 3, // Elevation (shadow)
                        ),
                        child: const Text('Search', style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
        
      ),
    );
  }
}