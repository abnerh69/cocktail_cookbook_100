import 'package:cocktail_cookbook/the_data_db_api/the_cocktail_cookbook_data.dart';

class DIM {
  static TheCocktailCookbookData theCocktailCookbookData = TheCocktailCookbookData();
  static bool lInitialized = false;

  static init() async {
    if (lInitialized) {
      return;
    }
    lInitialized = true;
    theCocktailCookbookData.getTheFilters();
    theCocktailCookbookData.initAPIEndpoints();
    // getTheSamples.getThe();
  }
}