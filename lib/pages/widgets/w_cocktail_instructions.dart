import 'package:flutter/material.dart';

import '../../dim.dart';
import 'list_card.dart';

class WCocktailInstructions extends StatefulWidget {
  const WCocktailInstructions({Key? key}) : super(key: key);

  @override
  State<WCocktailInstructions> createState() => _WCocktailInstructionsState();
}

class _WCocktailInstructionsState extends State<WCocktailInstructions> {
  @override
  Widget build(BuildContext context) {
    debugPrint('Showing WCocktailInstructions');
    return Positioned(
        top: MediaQuery.of(context).size.height / 4,
    left: (MediaQuery.of(context).size.width -
    (MediaQuery.of(context).size.width / 1.5)) /
    2,
    child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: DIM.selectedInstructions
            ? listCard(context, 'Instructions', [
          DIM.theCocktailCookbookData.randomDrink!.instructions,
          // DIM.theCocktailCookbookData.randomDrink!
          //     .instructionsES ??
          //     '',
          // DIM.theCocktailCookbookData.randomDrink!
          //     .instructionsDE ??
          //     '',
          // DIM.theCocktailCookbookData.randomDrink!
          //     .instructionsIT ??
          //     '',
          // DIM.theCocktailCookbookData.randomDrink!
          //     .instructionsFR ??
          //     '',
        ])
            : const SizedBox(height: 0, width: 0)));
  }
}
