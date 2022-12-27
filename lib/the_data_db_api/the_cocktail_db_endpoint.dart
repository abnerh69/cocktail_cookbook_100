class TheCocktailDBEndpoint {
  String name;
  String usedFor;
  String url;
  bool requieresPay;
  bool requieresArgument;
  Function function;

  TheCocktailDBEndpoint(
      {required this.name,
        required this.usedFor,
        required this.url,
        this.requieresPay = false,
        this.requieresArgument = false,
        required this.function});

  toJson() {
    return {
      "name": name,
      "usedFor": usedFor,
      "url": url,
      "requieresPay": requieresPay,
      "requieresArgument": requieresArgument,
    };
  }
}