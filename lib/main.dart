import 'package:flutter/material.dart';
import 'package:cocktail_cookbook/app.dart';
import 'package:cocktail_cookbook/viewmodels/recipe_viewmodel.dart';

import 'dim.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DIM.init();
  await RecipeViewModel.load();
  runApp(const RecipeApp());
}

// https://www.thecocktaildb.com/api.php