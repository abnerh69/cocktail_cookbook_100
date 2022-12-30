
class SearchResult {
  late String type;
  late String name;
  late String idDrink;

  SearchResult(this.type, this.name, {this.idDrink = ''});

  @override
  String toString() {
    return '$type -> $name';
  }
}