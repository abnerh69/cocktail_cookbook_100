class DrinkItem {
  late String idDrink;
  late String name;
  late String drinkThumb;

  DrinkItem.fromMap(json) {
    idDrink = json["idDrink"];
    name = json["strDrink"];
    drinkThumb = json["strDrinkThumb"];
  }
}

class Drink {
  late String idDrink; // "14446",
  late String name; // "Kool-Aid Slammer",
  String? drinkAlternate; // null,
  String? tags; // null,
  String? video; // null,
  late String category; // "Shot",
  String? iba; // null,
  late String alcoholic; // "Alcoholic",
  late String glass; // "Shot glass",
  late String
      instructions; // "Fill half the shot glass with the kool-aid first. Then put a paper towel over the top of the glass and slowly pour in the vodka. If you do it right, you should be able to see that the two liquids are separated, with the vodka on top. Now slam it! The last thing you'll taste is the kool-aid.",
  String? instructionsES; // null,
  String?
      instructionsDE; // "Füllen Sie zuerst die Hälfte des Schnapsglases mit dem Kool-Aid. Dann legen Sie ein Papiertuch über das Glas und gießen Sie den Wodka langsam ein. Wenn du es richtig machst, solltest du sehen können, dass die beiden Flüssigkeiten getrennt sind, mit dem Wodka oben drauf. Jetzt knall es rein! Das Letzte, was du schmecken wirst, ist das Kool-Aid.",
  String? instructionsFR; // null,
  String?
      instructionsIT; // "Riempi prima metà del bicchierino con il kool-aid.\r\nQuindi mettere un tovagliolo di carta sulla parte superiore del bicchiere e versare lentamente la vodka.\r\nSe lo fai bene, dovresti essere in grado di vedere che i due liquidi sono separati, con la vodka sopra.\r\nOra sbattilo! L'ultima cosa che assaggerai è il kool-aid.",
  String? instructionsZHHANS; // null,
  String? instructionsZHHANT; // null,
  late String
      drinkThumb; // "https  ////www.thecocktaildb.com/images/media/drink/kugu2m1504735473.jpg",
  String? ingredient1; // "Kool-Aid",
  String? ingredient2; // "Vodka",
  String? ingredient3; // null,
  String? ingredient4; // null,
  String? ingredient5; // null,
  String? ingredient6; // null,
  String? ingredient7; // null,
  String? ingredient8; // null,
  String? ingredient9; // null,
  String? ingredient10; // null,
  String? ingredient11; // null,
  String? ingredient12; // null,
  String? ingredient13; // null,
  String? ingredient14; // null,
  String? ingredient15; // null,
  String? measure1; // "1/2 oz Grape ",
  String? measure2; // "1/2 oz ",
  String? measure3; // null,
  String? measure4; // null,
  String? measure5; // null,
  String? measure6; // null,
  String? measure7; // null,
  String? measure8; // null,
  String? measure9; // null,
  String? measure10; // null,
  String? measure11; // null,
  String? measure12; // null,
  String? measure13; // null,
  String? measure14; // null,
  String? measure15; // null,
  String? imageSource; // null,
  String? imageAttribution; // null,
  late String creativeCommonsConfirmed; // "No",
  late String dateModified; // "2017-09-06 23  //04  //33"
  Map<String, String> ingredientsList = {};

  getInfo() {}

  Drink.fromJson(json) {
    idDrink = json["idDrink"];
    name = json["strDrink"];
    drinkAlternate = json["strDrinkAlternate"];
    tags = json["strTags"];
    video = json["strVideo"];
    category = json["strCategory"];
    iba = json["strIBA"];
    alcoholic = json["strAlcoholic"];
    glass = json["strGlass"];
    instructions = json["strInstructions"];
    instructionsES = json["strInstructionsES"];
    instructionsDE = json["strInstructionsDE"];
    instructionsFR = json["strInstructionsFR"];
    instructionsIT = json["strInstructionsIT"];
    instructionsZHHANS = json["strInstructionsZH-HANS"];
    instructionsZHHANT = json["strInstructionsZH-HANT"];
    drinkThumb = json["strDrinkThumb"];
    ingredient1 = json["strIngredient1"];
    ingredient2 = json["strIngredient2"];
    ingredient3 = json["strIngredient3"];
    ingredient4 = json["strIngredient4"];
    ingredient5 = json["strIngredient5"];
    ingredient6 = json["strIngredient6"];
    ingredient7 = json["strIngredient7"];
    ingredient8 = json["strIngredient8"];
    ingredient9 = json["strIngredient9"];
    ingredient10 = json["strIngredient10"];
    ingredient11 = json["strIngredient11"];
    ingredient12 = json["strIngredient12"];
    ingredient13 = json["strIngredient13"];
    ingredient14 = json["strIngredient14"];
    ingredient15 = json["strIngredient15"];
    measure1 = json["strMeasure1"];
    measure2 = json["strMeasure2"];
    measure3 = json["strMeasure3"];
    measure4 = json["strMeasure4"];
    measure5 = json["strMeasure5"];
    measure6 = json["strMeasure6"];
    measure7 = json["strMeasure7"];
    measure8 = json["strMeasure8"];
    measure9 = json["strMeasure9"];
    measure10 = json["strMeasure10"];
    measure11 = json["strMeasure11"];
    measure12 = json["strMeasure12"];
    measure13 = json["strMeasure13"];
    measure14 = json["strMeasure14"];
    measure15 = json["strMeasure15"];
    imageSource = json["strImageSource"];
    imageAttribution = json["strImageAttribution"];
    creativeCommonsConfirmed = json["strCreativeCommonsConfirmed"];
    dateModified = json["dateModified"] ?? '';

    ingredientsList.clear();
    for (int i = 1; i <= 15; i++) {
      if (json["strIngredient$i"] != null) {
        ingredientsList.putIfAbsent(json["strIngredient$i"].toString(),
            () => json["strMeasure$i"] ?? '');
      }
    }
  }
}
