class Recipe {
  final int id;
  final String title;
  final String description;
  final bool vegetarian;
  final bool vegan;
  final bool glutenFree;
  final bool dairyFree;
  final int servings;
  final String sourceUrl;
  final int likes;
  final int readyInMinutes;
  final String image;
  final List<String> ingredients;
  final List<String> instructions;

  Recipe(
      {required this.id,
        required this.title,
        required this.description,
        required this.vegetarian,
        required this.vegan,
        required this.glutenFree,
        required this.dairyFree,
        required this.servings,
        required this.sourceUrl,
        required this.likes,
        required this.readyInMinutes,
        required this.image,
        required this.ingredients,
        required this.instructions});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    var ingredientsJson = json['ingredients'];
    var instructionsJson = json['instructions'];

    return Recipe(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        vegetarian: json['vegetarian'],
        vegan: json['vegan'],
        glutenFree: json['glutenFree'],
        dairyFree: json['dairyFree'],
        servings: json['servings'],
        sourceUrl: json['sourceUrl'],
        likes: json['likes'],
        readyInMinutes: json['readyInMinutes'],
        image: json['image'],
        ingredients: ingredientsJson.cast<String>(),
        instructions: instructionsJson.cast<String>());
  }
}
