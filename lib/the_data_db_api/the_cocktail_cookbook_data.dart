import 'dart:convert';

import 'package:cocktail_cookbook/pages/home_page.dart';
import 'package:cocktail_cookbook/pages/widgets/_exports.dart';
import 'package:cocktail_cookbook/pages/widgets/w_clear_search_button.dart';
import 'package:cocktail_cookbook/pages/widgets/w_home_overlaping.dart';
import 'package:cocktail_cookbook/the_data_db_api/search_result.dart';
import 'package:cocktail_cookbook/utils/refresh_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:string_extensions/string_extensions.dart';

import 'package:cocktail_cookbook/dim.dart';
import '_exports.dart';

class TheCocktailCookbookData {
  String theVersion = 'v1';
  String theKey = '1';
  String apiBaseUrl = 'https://www.thecocktaildb.com/api/json';
  String drinks = 'drinks';

  Map<String, Drink> drinksMap = {};

  static const cCategories = "Categories";
  static const cGlasses = "Glasses";
  static const cIngredients = "Ingredients";
  static const cAlcoholic = "Alcoholic";

  bool lInitialized = false;
  List<DrinkCategory> categories = [];
  List<Glass> glasses = [];
  List<Ingredient> ingredients = [];
  List<Alcoholic> alcoholic = [];
  bool lTheFilters = false;
  bool lTheFiltersGotten = false;
  List<TheCocktailDBEndpoint> endPointsList = [];

  Drink? randomDrink;
  bool lRandomDrink = false;
  List<DrinkItem> drinkItemsList = [];

  TextEditingController searchController = TextEditingController();

  List<SearchResult> searchResult = [];

  String coctailsFilterTitle = '';

  searchListener() async {
    String textToSearch = searchController.text;
    searchResult.clear();
    refreshWidget(WSearchClearButton.widgetName);
    if (textToSearch == '') {
      refreshWidget(WSearchResults.widgetName);
      return;
    }
    if (textToSearch.length == 1) {
      // listAllCocktailsByFirstLetter(textToSearch);
    }
    if (textToSearch.length >= 3) {
      List<Drink> aDrinklist = await searchCocktailByName(textToSearch);
      if (aDrinklist.isNotEmpty) {
        searchResult.insert(0, SearchResult('T', 'Drinks'));
        List<SearchResult> tempList = [];
        for (var element in aDrinklist) {
          tempList.add(SearchResult('Drink', element.name, idDrink: element.idDrink));
        }
        searchResult.insertAll(1, tempList);
      }
    }
    List<DrinkCategory> searchDrinkCategory = categories
        .where((element) =>
            element.name.toLowerCase().contains(textToSearch.toLowerCase()))
        .toList();
    List<Alcoholic> searchAlcoholic = alcoholic
        .where((element) =>
            element.name.toLowerCase().contains(textToSearch.toLowerCase()))
        .toList();
    List<Glass> searchGlass = glasses
        .where((element) =>
            element.name.toLowerCase().contains(textToSearch.toLowerCase()))
        .toList();
    List<Ingredient> searchIngredient = ingredients
        .where((element) =>
            element.name.toLowerCase().contains(textToSearch.toLowerCase()))
        .toList();
    if (searchDrinkCategory.isNotEmpty) {
      searchResult.add(SearchResult('T', cCategories));
      for (var element in searchDrinkCategory) {
        searchResult.add(SearchResult(cCategories, element.name));
      }
    }
    if (searchAlcoholic.isNotEmpty) {
      searchResult.add(SearchResult('T', cAlcoholic));
      for (var element in searchAlcoholic) {
        searchResult.add(SearchResult(cAlcoholic, element.name));
      }
    }
    if (searchGlass.isNotEmpty) {
      searchResult.add(SearchResult('T', cGlasses));
      for (var element in searchGlass) {
        searchResult.add(SearchResult(cGlasses, element.name));
      }
    }
    if (searchIngredient.isNotEmpty) {
      searchResult.add(SearchResult('T', cIngredients));
      for (var element in searchIngredient) {
        searchResult.add(SearchResult(cIngredients, element.name));
      }
    }
    refreshWidget(WSearchResults.widgetName);
    // debugPrint(searchResult.toString());
  }

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
      // debugPrint('${element.usedFor} -> ${title2ClassName(element.usedFor)}');
    }
  }

  Future<http.Response> fetchResponse(String url) {
    return http.get(Uri.parse(url));
  }

  Future<Map> fetchTheCocktailDBEndpointData(String name,
      {String argument = ''}) async {
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
      url = url.replaceAll('ARGUMENT', argument.replaceAll(' ', '_'));
    }

    http.Response response = await fetchResponse(url);
    if (response.statusCode == 200) {
      try {
        map = json.decode(response.body);
      } catch (e) {
        // debugPrint(e.toString());
        // debugPrint(url);
        // debugPrint(response.body);
      }
    }
    return map;
  }

  // Search cocktail by name
  Future<List<Drink>> searchCocktailByName(String name) async {
    Map map = await fetchTheCocktailDBEndpointData("searchCocktailByName",
        argument: name);
    // debugPrint(map.toString());
    return getDrinksFromMap(map);
  }

  // List all cocktails by first letter
  listAllCocktailsByFirstLetter(String firstLetter) async {
    Map map = await fetchTheCocktailDBEndpointData(
        "listAllCocktailsByFirstLetter",
        argument: firstLetter);
    // debugPrint(map.toString());
  }

  // Search ingredient by name
  searchIngredientByName(String name) async {
    Map map = await fetchTheCocktailDBEndpointData("searchIngredientByName",
        argument: name);
    // debugPrint(map.toString());
  }

  // Lookup full cocktail details by id
  lookupFullCocktailDetailsById(String id) async {
    if (drinksMap.containsKey(id)) {
      newRandomDrink(drinksMap[id]!);
      return;
    }
    Map map = await fetchTheCocktailDBEndpointData(
        "lookupFullCocktailDetailsById",
        argument: id);
    // debugPrint(map.toString());
    List<Drink> list = getDrinksFromMap(map);
    if (list.isNotEmpty) {
      newRandomDrink(list[0]);
    }
  }

  List<Drink> getDrinksFromMap(Map map) {
    List<Drink> resultList = [];
    if (map.containsKey(drinks)) {
      List list = map[drinks];
      if (list.isNotEmpty) {
        Drink aDrink = Drink.fromJson(list[0]);
        resultList.add(aDrink);
        drinksMap.putIfAbsent(aDrink.idDrink, () => aDrink);
        // debugPrint(drinksMap.length.toString());
      }
    }
    return resultList;
  }

  // Lookup ingredient by ID
  lookupIngredientById(String id) async {
    Map map = await fetchTheCocktailDBEndpointData("lookupIngredientById",
        argument: id);
    // debugPrint(map.toString());
  }

  // Lookup a random cocktail
  lookupARandomCocktail() async {
    Map map = await fetchTheCocktailDBEndpointData("lookupARandomCocktail");
    List<Drink> list = getDrinksFromMap(map);
    if (list.isNotEmpty) {
      newRandomDrink(list[0]);
      coctailsFilterTitle = randomDrink!.category;
      filterByCategory(randomDrink!.category);
    }
  }

  // Lookup a selection of 10 random cocktails
  lookupASelectionOf10RandomCocktails() async {
    Map map = await fetchTheCocktailDBEndpointData(
        "lookupASelectionOf10RandomCocktails");
    // debugPrint(map.toString());
  }

  // List Popular cocktails
  listPopularCocktails() async {
    Map map = await fetchTheCocktailDBEndpointData("listPopularCocktails");
    // debugPrint(map.toString());
  }

  // List most latest cocktails
  listMostLatestCocktails() async {
    Map map = await fetchTheCocktailDBEndpointData(
      "listMostLatestCocktails",
    );
    // debugPrint(map.toString());
  }

  // Search by ingredient
  searchByIngredient(String ingredientName, {bool setDrink = false}) async {
    Map map = await fetchTheCocktailDBEndpointData("searchByIngredient", argument: ingredientName);
    // debugPrint(map.toString());
    getDrinkItemsListFromMap(map);
  }

  // Filter by multi-ingredient
  filterByMultiIngredient(List<String> multiIngredientNames) async {
    String argument = multiIngredientNames.join(',');
    Map map = await fetchTheCocktailDBEndpointData("filterByMultiIngredient",
        argument: argument);
    // debugPrint(map.toString());
    getDrinkItemsListFromMap(map);
  }

  // Filter by alcoholic
  filterByAlcoholic(String alcoholic, {bool setDrink = false}) async {
    Map map = await fetchTheCocktailDBEndpointData("filterByAlcoholic",
        argument: alcoholic);
    // debugPrint(map.toString());
    getDrinkItemsListFromMap(map);
  }

  // Filter by Category
  filterByCategory(String category, {bool setDrink = false}) async {
    Map map = await fetchTheCocktailDBEndpointData("filterByCategory",
        argument: category);
    getDrinkItemsListFromMap(map);
  }

  // Filter by Glass
  filterByGlass(String glass, {bool setDrink = false}) async {
    Map map =
        await fetchTheCocktailDBEndpointData("filterByGlass", argument: glass);
    // debugPrint(map.toString());
    getDrinkItemsListFromMap(map);
  }

  initAPIEndpoints() {
    if (lInitialized) {
      return;
    }
    lInitialized = true;
    searchController.addListener(searchListener);

    endPointsList = [
      TheCocktailDBEndpoint(
        name: "searchCocktailByName",
        usedFor: "Search cocktail by name",
        url: "$apiBaseUrl/VERSION/KEY/search.php?s=ARGUMENT",
        requieresArgument: true,
        function: searchCocktailByName,
      ),

      TheCocktailDBEndpoint(
        name: "listAllCocktailsByFirstLetter",
        usedFor: "List all cocktails by first letter",
        url: "$apiBaseUrl/VERSION/KEY/search.php?f=ARGUMENT",
        requieresArgument: true,
        function: listAllCocktailsByFirstLetter,
      ),

      TheCocktailDBEndpoint(
        name: "searchIngredientByName",
        usedFor: "Search ingredient by name",
        url: "$apiBaseUrl/VERSION/KEY/search.php?i=ARGUMENT",
        requieresArgument: true,
        function: searchIngredientByName,
      ),

      TheCocktailDBEndpoint(
        name: 'lookupFullCocktailDetailsById',
        usedFor: "Lookup full cocktail details by id",
        url: "$apiBaseUrl/VERSION/KEY/lookup.php?i=ARGUMENT",
        requieresArgument: true,
        function: lookupFullCocktailDetailsById,
      ),

      TheCocktailDBEndpoint(
        name: "lookupIngredientById",
        usedFor: "Lookup ingredient by ID",
        url: "$apiBaseUrl/VERSION/KEY/lookup.php?iid=ARGUMENT",
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
        url: "$apiBaseUrl/VERSION/KEY/randomselection.php",
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
        url: "$apiBaseUrl/VERSION/KEY/filter.php?i=ARGUMENT",
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
        url: "$apiBaseUrl/VERSION/KEY/filter.php?a=ARGUMENT",
        requieresArgument: true,
        function: filterByAlcoholic,
      ),
      // url: "$apiBaseUrl/VERSION/KEY/filter.php?a=Non_Alcoholic", ),

      TheCocktailDBEndpoint(
          name: "filterByCategory",
          usedFor: "Filter by Category",
          url: "$apiBaseUrl/VERSION/KEY/filter.php?c=ARGUMENT",
          requieresArgument: true,
          function: filterByCategory),
      // url: "$apiBaseUrl/VERSION/KEY/filter.php?c=Cocktail", ),

      TheCocktailDBEndpoint(
        name: "filterByGlass",
        usedFor: "Filter by Glass",
        url: "$apiBaseUrl/VERSION/KEY/filter.php?g=ARGUMENT",
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
    Map<String, DrinkFilter> theFilters = {
      cCategories: DrinkFilter<DrinkCategory>(
          cCategories,
          "$apiBaseUrl/VERSION/KEY/list.php?c=list",
          drinks,
          "strCategory",
          categories),
      cGlasses: DrinkFilter<Glass>(
          cGlasses,
          "$apiBaseUrl/VERSION/KEY/list.php?g=list",
          drinks,
          "strGlass",
          glasses),
      cIngredients: DrinkFilter<Ingredient>(
          cIngredients,
          "$apiBaseUrl/VERSION/KEY/list.php?i=list",
          drinks,
          "strIngredient1",
          ingredients),
      cAlcoholic: DrinkFilter<Alcoholic>(
          cAlcoholic,
          "$apiBaseUrl/VERSION/KEY/list.php?a=list",
          drinks,
          "strAlcoholic",
          alcoholic),
    };
    theFilters.forEach((key, value) async {
      http.Response response = await fetchResponse(value.url
          .replaceAll('VERSION', theVersion)
          .replaceAll('KEY', theKey));
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
      } else {
        // debugPrint(
        //     '${value.url} -> ${response.statusCode.toString()}\n${response.body}');
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

  newRandomDrink(Drink aDrink) {
    // debugPrint('NEW DRINK TO SHOW ${aDrink.name}');
    randomDrink = aDrink;
    lRandomDrink = true;
    DIM.setDefaultSubViews();

    refreshWidget(WHomeOverlaping.widgetName);
    refreshWidget(WCocktailImage.widgetName);
    refreshWidget(WCocktailName.widgetName);
    // refreshWidget(HomePage .widgetName);
  }

  searchResultSelected(SearchResult e) {
    searchController.text = '';
    switch (e.type) {
      case cCategories:
        coctailsFilterTitle = 'Category: ${e.name}';
        filterByCategory(e.name, setDrink: true);
        break;
      case cAlcoholic:
        coctailsFilterTitle = e.name;
        filterByAlcoholic(e.name, setDrink: true);
        break;
      case cGlasses:
        coctailsFilterTitle = 'Category: ${e.name}';
        filterByGlass(e.name, setDrink: true);
        break;
      case cIngredients:
        coctailsFilterTitle = 'Ingredient: ${e.name}';
        searchByIngredient(e.name, setDrink: true);
        break;
      default:
        // debugPrint('${e.type} -> ${e.name}');
        newRandomDrink(drinksMap[e.idDrink]!);
    }
  }

  getDrinkItemsListFromMap(Map map, {bool setDrink = true}) {
    if (map.containsKey(drinks)) {
      drinkItemsList.clear();
      List list = map[drinks];
      for (var element in list) {
        DrinkItem drinkItem = DrinkItem.fromMap(element);
        drinkItemsList.add(drinkItem);
      }
      if (setDrink && drinkItemsList.isNotEmpty) {
        lookupFullCocktailDetailsById(drinkItemsList[0].idDrink);
      }
      refreshWidget(WCocktailList.widgetName);
    }
  }
}
