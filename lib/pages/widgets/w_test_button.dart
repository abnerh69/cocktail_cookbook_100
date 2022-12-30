import 'package:flutter/material.dart';

class WTestButton extends StatefulWidget {
  const WTestButton({Key? key}) : super(key: key);

  @override
  State<WTestButton> createState() => _WTestButtonState();
}

class _WTestButtonState extends State<WTestButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          // DIM.getTheSamples.getTheFilters();
          // for (var element in DIM.getTheSamples.categories) {
          //   debugPrint(element.name);
          // }
          // DIM.theCocktailCookbookData.temporalUtil();
          // DIM.theCocktailCookbookData.initAPIEndpoints();
          // DIM.theCocktailCookbookData.lookupARandomCocktail();
        },
        child: const Text('Test The Cocktail Cookbook Data'));
  }
}
