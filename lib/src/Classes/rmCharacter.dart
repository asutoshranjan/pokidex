class RMCharacter {
  final String name;
  final String image;
  final String species;
  final String gender;
  final String status;

  RMCharacter(
    this.name,
    this.image,
    this.species,
    this.gender,
    this.status,
  );
  factory RMCharacter.fromJson(Map<String, dynamic> json) {
    return RMCharacter(json["name"], json["image"], json["species"], json["gender"], json["status"]);
  }
}
