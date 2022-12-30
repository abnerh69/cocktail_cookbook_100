import 'package:cocktail_cookbook/the_data_db_api/the_cocktail_cookbook_data.dart';

class DIM {
  static TheCocktailCookbookData theCocktailCookbookData = TheCocktailCookbookData();
  static bool lInitialized = false;

  static late bool displayText;
  static late bool selectedIngredients;
  static late bool selectedInstructions;
  static late bool selectedInfo;

  static init() async {
    if (lInitialized) {
      return;
    }
    lInitialized = true;
    setDefaultSubViews();
    theCocktailCookbookData.getTheFilters();
    theCocktailCookbookData.initAPIEndpoints();
    // getTheSamples.getThe();
  }

  static setDefaultSubViews() {
    displayText = true;
    selectedIngredients = false;
    selectedInstructions = false;
    selectedInfo = false;
  }
}