class DrinkFilter<T> {
  DrinkFilter(this.name, this.url, this.mainKey, this.key, this.theList);

  String name;
  String url;

  // T theClass;
  List<T> theList;
  String mainKey;
  String key;
}