import 'package:flutter/material.dart';

import '../../dim.dart';
import 'list_card.dart';

class WCocktailIngredients extends StatefulWidget {
  const WCocktailIngredients({Key? key}) : super(key: key);

  @override
  State<WCocktailIngredients> createState() => _WCocktailIngredientsState();
}

class _WCocktailIngredientsState extends State<WCocktailIngredients> {
  @override
  Widget build(BuildContext context) {
    debugPrint('Showing WCocktailIngredients');
    return Positioned(
        top: MediaQuery.of(context).size.height / 4,
        left: (MediaQuery.of(context).size.width -
            (MediaQuery.of(context).size.width / 1.5)) /
            2,
        child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: DIM.selectedIngredients
                ? listCard(
                    context,
                    'Ingredients',
                    DIM.theCocktailCookbookData.randomDrink!.ingredientsList
                        .entries
                        .map((e) => '${e.value} - ${e.key}')
                        .toList())
                // RecipeViewModel.selected.ingredients)
                : const SizedBox(height: 0, width: 0)));
  }
}
