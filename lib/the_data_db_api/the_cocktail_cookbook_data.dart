import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:string_extensions/string_extensions.dart';

import '_exports.dart';

class TheCocktailCookbookData {
  String theVersion = 'v1';
  String theKey = '1';
  String apiBaseUrl = 'https://www.thecocktaildb.com/api/json';
  String drinks = 'drinks';

  List<DrinkCategory> categories = [];
  List<Glass> glasses = [];
  List<Ingredient> ingredients = [];
  List<Alcoholic> alcoholic = [];
  bool lTheFilters = false;
  bool lTheFiltersGotten = false;
  List<TheCocktailDBEndpoint> endPointsList = [];

  setMyVersionAndKey(String newVersion, String newKey) {
    theVersion = newVersion;
    theKey = newKey;
  }

  title2ClassName(String name) {
    name = name.toCamelCase!;
    // name = name.replaceAll(RegExp(r'[^\w\s]+'),'').replaceAll(' ', '');
    // name = name.toTitleCase!;
    return name;
  }

  temporalUtil() {
    for (var element in endPointsList) {
      debugPrint('${element.usedFor} -> ${title2ClassName(element.usedFor)}');
    }
  }

  Future<http.Response> fetchResponse(String url) {
    return http.get(Uri.parse(url));
  }

  Future<Map> fetchTheCocktailDBEndpointData(String name,
      {String arguemt = ''}) async {
    Map map = {};
    final tempList =
        endPointsList.where((element) => element.name == name).toList();
    if (tempList.isEmpty) {
      return map;
    }
    TheCocktailDBEndpoint ep = tempList[0];
    String url = ep.url;

    if (theKey == '1' && ep.requieresPay) {
      map = ep.toJson();
    }
    url = url.replaceAll('VERSION', theVersion).replaceAll('KEY', theKey);
    if (ep.requieresArgument) {
      url.replaceAll('ARGUMENT', arguemt);
    }

    http.Response response = await fetchResponse(url);
    if (response.statusCode == 200) {
      map = json.decode(response.body);
    }
    return map;
  }

  // Search cocktail by name
  searchCocktailByName(String name) async {
    Map map = await fetchTheCocktailDBEndpointData("searchCocktailByName",
        arguemt: name);
    debugPrint(map.toString());
    // ep.
  }

  // List all cocktails by first letter
  listAllCocktailsByFirstLetter(String firstLetter) async {
    Map map = await fetchTheCocktailDBEndpointData("listAllCocktailsByFirstLetter",
        arguemt: firstLetter);
    debugPrint(map.toString());
  }

  // Search ingredient by name
  searchIngredientByName(String name) async {
    Map map = await fetchTheCocktailDBEndpointData("searchIngredientByName",
        arguemt: name);
    debugPrint(map.toString());
  }

  // Lookup full cocktail details by id
  lookupFullCocktailDetailsById(String id) async {
    Map map = await fetchTheCocktailDBEndpointData("lookupFullCocktailDetailsById",
        arguemt: id);
    debugPrint(map.toString());
  }

  // Lookup ingredient by ID
  lookupIngredientById(String id) async {
    Map map = await fetchTheCocktailDBEndpointData("lookupIngredientById",
        arguemt: id);
    debugPrint(map.toString());
  }

  // Lookup a random cocktail
  lookupARandomCocktail() async {
    Map map = await fetchTheCocktailDBEndpointData("lookupARandomCocktail");
    // debugPrint(map.toString());
    if (map.containsKey(drinks)) {
      List list = map[drinks];
      if (list.isNotEmpty) {

        randomDrink = Drink.fromJson(list[0]);
        lRandomDrink = true;
        // TODO: Refesh Home Page
        // debugPrint(randomDrink!.drinkThumb);
      }
    }
  }

  Drink? randomDrink;
  bool lRandomDrink = false;

  // Lookup a selection of 10 random cocktails
  lookupASelectionOf10RandomCocktails() async {
    Map map = await fetchTheCocktailDBEndpointData("lookupASelectionOf10RandomCocktails");
    debugPrint(map.toString());
  }

  // List Popular cocktails
  listPopularCocktails() async {
    Map map = await fetchTheCocktailDBEndpointData("listPopularCocktails");
    debugPrint(map.toString());
  }

  // List most latest cocktails
  listMostLatestCocktails() async {
    Map map = await fetchTheCocktailDBEndpointData(
      "listMostLatestCocktails",
    );
    debugPrint(map.toString());
  }

  // Search by ingredient
  searchByIngredient(String ingredientName) async {
    Map map = await fetchTheCocktailDBEndpointData("searchByIngredient");
    debugPrint(map.toString());
  }

  // Filter by multi-ingredient
  filterByMultiIngredient(List<String> multiIngredientNames) async {
    String argument = multiIngredientNames.join(',');
    Map map = await fetchTheCocktailDBEndpointData("filterByMultiIngredient",
        arguemt: argument);
    debugPrint(map.toString());
  }

  // Filter by alcoholic
  filterByAlcoholic(String alcoholic) async {
    Map map = await fetchTheCocktailDBEndpointData("filterByAlcoholic",
        arguemt: alcoholic);
    debugPrint(map.toString());
  }

  // Filter by Category
  filterByCategory(String category) async {
    Map map = await fetchTheCocktailDBEndpointData("filterByCategory",
        arguemt: category);
    debugPrint(map.toString());
  }

  // Filter by Glass
  filterByGlass(String glass) async {
    Map map = await fetchTheCocktailDBEndpointData("filterByGlass",
        arguemt: glass);
    debugPrint(map.toString());
  }

  initAPIEndpoints() {
    endPointsList = [
      TheCocktailDBEndpoint(
        name: "searchCocktailByName",
        usedFor: "Search cocktail by name",
        url:
            "$apiBaseUrl/VERSION/KEY/search.php?s=ARGUMENT",
        requieresArgument: true,
        function: searchCocktailByName,
      ),

      TheCocktailDBEndpoint(
        name: "listAllCocktailsByFirstLetter",
        usedFor: "List all cocktails by first letter",
        url:
            "$apiBaseUrl/VERSION/KEY/search.php?f=ARGUMENT",
        requieresArgument: true,
        function: listAllCocktailsByFirstLetter,
      ),

      TheCocktailDBEndpoint(
        name: "searchIngredientByName",
        usedFor: "Search ingredient by name",
        url:
            "$apiBaseUrl/VERSION/KEY/search.php?i=ARGUMENT",
        requieresArgument: true,
        function: searchIngredientByName,
      ),

      TheCocktailDBEndpoint(
        name: 'lookupFullCocktailDetailsById',
        usedFor: "Lookup full cocktail details by id",
        url:
            "$apiBaseUrl/VERSION/KEY/lookup.php?i=ARGUMENT",
        requieresArgument: true,
        function: lookupFullCocktailDetailsById,
      ),

      TheCocktailDBEndpoint(
        name: "lookupIngredientById",
        usedFor: "Lookup ingredient by ID",
        url:
            "$apiBaseUrl/VERSION/KEY/lookup.php?iid=ARGUMENT",
        requieresArgument: true,
        function: lookupIngredientById,
      ),

      TheCocktailDBEndpoint(
        name: "lookupARandomCocktail",
        usedFor: "Lookup a random cocktail",
        url: "$apiBaseUrl/VERSION/KEY/random.php",
        function: lookupARandomCocktail,
      ),

      TheCocktailDBEndpoint(
        name: "lookupASelectionOf10RandomCocktails",
        usedFor: "Lookup a selection of 10 random cocktails",
        requieresPay: true,
        url:
            "$apiBaseUrl/VERSION/KEY/randomselection.php",
        function: lookupASelectionOf10RandomCocktails,
      ),

      TheCocktailDBEndpoint(
        name: "listPopularCocktails",
        usedFor: "List Popular cocktails",
        requieresPay: true,
        url: "$apiBaseUrl/VERSION/KEY/popular.php",
        function: listPopularCocktails,
      ),

      TheCocktailDBEndpoint(
        name: "listMostLatestCocktails",
        usedFor: "List most latest cocktails",
        requieresPay: true,
        url: "$apiBaseUrl/VERSION/KEY/latest.php",
        function: listMostLatestCocktails,
      ),

      TheCocktailDBEndpoint(
        name: "searchByIngredient",
        usedFor: "Search by ingredient",
        url:
            "$apiBaseUrl/VERSION/KEY/filter.php?i=ARGUMENT",
        requieresArgument: true,
        function: searchByIngredient,
      ),
      // url: "$apiBaseUrl/VERSION/KEY/filter.php?i=Vodka", ),

      TheCocktailDBEndpoint(
        name: "filterByMultiIngredient",
        usedFor: "Filter by multi-ingredient",
        requieresPay: true,
        url: "$apiBaseUrl/VERSION/KEY/filter.php?i=ARGUMENT",
        requieresArgument: true,
        function: filterByMultiIngredient,
      ),

      TheCocktailDBEndpoint(
        name: "filterByAlcoholic",
        usedFor: "Filter by alcoholic",
        url:
            "$apiBaseUrl/VERSION/KEY/filter.php?a=ARGUMENT",
        requieresArgument: true,
        function: filterByAlcoholic,
      ),
      // url: "$apiBaseUrl/VERSION/KEY/filter.php?a=Non_Alcoholic", ),

      TheCocktailDBEndpoint(
          name: "filterByCategory",
          usedFor: "Filter by Category",
          url:
              "$apiBaseUrl/VERSION/KEY/filter.php?c=ARGUMENT",
          requieresArgument: true,
          function: filterByCategory),
      // url: "$apiBaseUrl/VERSION/KEY/filter.php?c=Cocktail", ),

      TheCocktailDBEndpoint(
        name: "filterByGlass",
        usedFor: "Filter by Glass",
        url:
            "$apiBaseUrl/VERSION/KEY/filter.php?g=ARGUMENT",
        requieresArgument: true,
        function: filterByGlass,
      ),
      // url: "$apiBaseUrl/VERSION/KEY/filter.php?g=Champagne_flute", ),
    ];
  }

  getTheFilters() async {
    if (lTheFilters || lTheFiltersGotten) {
      return;
    }
    lTheFilters = true;
    // List the categories, glasses, ingredients or alcoholic filters
    // url: "$apiBaseUrl/VERSION/KEY/list.php?c=list", ),
    // url: "$apiBaseUrl/VERSION/KEY/list.php?g=list", ),
    // url: "$apiBaseUrl/VERSION/KEY/list.php?i=list", ),
    // url: "$apiBaseUrl/VERSION/KEY/list.php?a=list", ),
    const cCategories = "Categories";
    const cGlasses = "Glasses";
    const cIngredients = "Ingredients";
    const cAlcoholic = "Alcoholic";
    Map<String, DrinkFilter> theFilters = {
      cCategories: DrinkFilter<DrinkCategory>(
          cCategories,
          "$apiBaseUrl/VERSION/KEY/list.php?c=list",
          "drinks",
          "strCategory",
          categories),
      cGlasses: DrinkFilter<Glass>(
          cGlasses,
          "$apiBaseUrl/VERSION/KEY/list.php?g=list",
          "drinks",
          "strGlass",
          glasses),
      cIngredients: DrinkFilter<Ingredient>(
          cIngredients,
          "$apiBaseUrl/VERSION/KEY/list.php?i=list",
          "drinks",
          "strIngredient1",
          ingredients),
      cAlcoholic: DrinkFilter<Alcoholic>(
          cAlcoholic,
          "$apiBaseUrl/VERSION/KEY/list.php?a=list",
          "drinks",
          "strAlcoholic",
          alcoholic),
    };
    theFilters.forEach((key, value) async {
      http.Response response = await fetchResponse(value.url);
      if (response.statusCode == 200) {
        Map map = json.decode(response.body);
        if (map.containsKey(value.mainKey)) {
          List theList = map[value.mainKey] ?? [];
          value.theList.clear();
          for (var element in theList) {
            if (kDebugMode) {
              print('$key ${element[value.key]}');
            }
            lTheFiltersGotten = true;
            switch (key) {
              case cCategories:
                value.theList.add(DrinkCategory(element[value.key] ?? "??"));
                break;
              case cGlasses:
                value.theList.add(Glass(element[value.key] ?? "??"));
                break;
              case cIngredients:
                value.theList.add(Ingredient(element[value.key] ?? "??"));
                break;
              case cAlcoholic:
                value.theList.add(Alcoholic(element[value.key] ?? "??"));
                break;
            }
          }
        }
      }
    });
  }

  String aboutImages = """
    // <img src='images/icons/image2.png'> <b>Images</b>
    // Drink thumbnails Add <b>/preview</b> to the end of the cocktail image URL
    // url: "/images/media/drink/vrwquq1478252802.jpg/preview (100x100 pixels)", ),
    // <img src='https://www.thecocktaildb.com/images/media/drink/vrwquq1478252802.jpg/preview' />
    //
    // Ingredient Thumbnails
    // url: "https://www.thecocktaildb.com/images/ingredients/gin-Small.png(100x100 pixels)", ),
    // url: "https://www.thecocktaildb.com/images/ingredients/gin-Medium.png(350x350 pixels)", ),</br>
    // url: "https://www.thecocktaildb.com/images/ingredients/gin.png(700x700 pixels)", ),
    //
    //
    // <img src='https://www.thecocktaildb.com/images/ingredients/gin-Small.png' width='100' height='100'/>
    // <img src='https://www.thecocktaildb.com/images/ingredients/gin-Medium.png' width='200' height='200'/>
    // <img src='https://www.thecocktaildb.com/images/ingredients/gin.png' width='350' height='350'/>
    """;
}
