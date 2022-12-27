import 'dart:convert';
import 'package:cocktail_cookbook/models/recipe.dart';
import 'package:flutter/services.dart' show rootBundle;

class RecipeViewModel {
  static List<Recipe> recipes = <Recipe>[];
  static late Recipe selected; // = Recipe();

  static Future load() async{
    List jsonParsed = json.decode(await getRecipes());
    recipes = jsonParsed.map((i) => Recipe.fromJson(i)).toList();
    selected = recipes[0];
  }

  static Future<String> getRecipes() async {
    return await rootBundle.loadString('assets/recipes.json');
  }
}