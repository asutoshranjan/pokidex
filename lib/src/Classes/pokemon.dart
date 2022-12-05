class Pokemon {
  final String name;
  final String url;

  Pokemon(
    this.name,
    this.url,
  );
  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(json["name"], json["url"]);
  }
}
