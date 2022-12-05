class Pokemon {
  final String name;
  final String image;

  Pokemon(
    this.name,
    this.image,
  );
  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(json["name"], json["image"]);
  }
}
