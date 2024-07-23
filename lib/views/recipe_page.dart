import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recipewiki/models/recipe.dart';

import '../models/equipment.dart';
import '../models/ingredient.dart';
import '../models/instruction.dart';
import '../models/nutrient.dart';

class RecipePage extends StatefulWidget {
  final Recipe recipe;
  final List<Equipment> equipments;
  final List<Nutrient> nutrients;
  final List<Ingredient> ingredients;
  final List<Instruction> instructions;

  const RecipePage({super.key, required this.recipe, required this.equipments, required this.nutrients, required this.ingredients, required this.instructions});


  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  bool showNutrients = false;
  bool showEquipments = false;
  bool showIngredients = false;
  bool showInstructions = false;

  void setShowNutrients () {
    setState(() {
      showNutrients = !showNutrients;
    });
  }

  void setShowEquipments () {
    setState(() {
      showEquipments = !showEquipments;
    });
  }

  void setShowIngredients () {
    setState(() {
      showIngredients = !showIngredients;
    });
  }

  void setShowInstructions () {
    setState(() {
      showInstructions = !showInstructions;
    });
  }




  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  Image.network(widget.recipe.image,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: const Icon(Icons.download_outlined),
                        onPressed: () {
                          // Add bookmark functionality here
                        },
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              )
            ),
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Colors.white,

                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.recipe.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        const Gap(10),
                        Row(
                          children: [
                            const Icon(Icons.access_time, color: Colors.green),
                            const Gap(5),
                            Text("${widget.recipe.readyInMinutes} mins"),
                            const Gap(20),
                            const Icon(Icons.score, color: Color(0xFFFFD700)),
                            const Gap(5),
                            Text("${widget.recipe.score}/100"),
                          ],
                        ),
                        const Gap(20),
                        Row(
                          children: [
                            const Text(
                              "Nutrients",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            const Spacer(),
                            IconButton(onPressed: setShowNutrients, icon: Icon(showNutrients ? Icons.remove : Icons.add))

                          ],
                        ),
                        const Divider(),
                        if (showNutrients)
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: widget.nutrients.length,
                            itemBuilder: (context, index) {
                              final nutrient = widget.nutrients[index];
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      Text("${index + 1}. ${nutrient.name}", style: const TextStyle(fontSize: 18),),
                                      const Spacer(),
                                      Text("${nutrient.amount} ${nutrient.unit}", style: const TextStyle(fontSize: 15),)
                                    ],
                                  ),
                                  const Gap(10)
                                ],
                              );
                            },
                          ),
                        Row(
                          children: [
                            const Text(
                              "Equipment",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            const Spacer(),
                            IconButton(onPressed: setShowEquipments, icon: Icon(showEquipments ? Icons.remove : Icons.add))
                          ],
                        ),
                        const Divider(),
                        if (showEquipments)
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: widget.equipments.length,
                            itemBuilder: (context, index) {
                              final equipment = widget.equipments[index];
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black, width: 2), // Black border with 2 width
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.network(
                                            'https://spoonacular.com/cdn/equipment_100x100/${equipment.image}',
                                            width: 60,
                                            height: 60,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const Gap(10),
                                      Text(equipment.name, style: const TextStyle(fontSize: 20),),
                                    ],
                                  ),
                                  const Gap(10)
                                ],
                              );
                            },
                          ),
                        Row(
                          children: [
                            const Text(
                              "Ingredients",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            const Spacer(),
                            IconButton(onPressed: setShowIngredients, icon: Icon(showIngredients ? Icons.remove : Icons.add))
                          ],
                        ),
                        const Divider(),
                        if (showIngredients)
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: widget.ingredients.length,
                            itemBuilder: (context, index) {
                              final ingredient = widget.ingredients[index];
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black, width: 2), // Black border with 2 width
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.network('https://spoonacular.com/cdn/ingredients_100x100/${ingredient.image}', width: 40, height: 40, fit: BoxFit.cover,),
                                        ),
                                      ),
                                      const Gap(5),
                                      Text(ingredient.name),
                                      const Spacer(),
                                      Text("${ingredient.value} ${ingredient.unit}")
                                    ],
                                  ),
                                  const Gap(10)
                                ],
                              );
                            },
                          ),

                        Row(
                          children: [
                            const Text(
                              "Instructions",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            const Spacer(),
                            IconButton(onPressed: setShowInstructions, icon: Icon(showInstructions ? Icons.remove : Icons.add))
                          ],
                        ),
                        if (showInstructions)
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: widget.instructions.length,
                            itemBuilder: (context, index) {
                              final instruction = widget.instructions[index];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${index+1}. ${instruction.step}", style: TextStyle(fontSize: 18),),
                                  const Gap(10)
                                ],
                              );
                            },
                          ),
                      // Add more content here, e.g., ingredients, steps, etc.
                      ]
                    ),

                  ),
                ),
              )
            )
          ],
        )
      ),
    );
  }
}
