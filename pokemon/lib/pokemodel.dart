class Pokemodel {
  String name;
  double height;
  double weight;
  String image;
  List<String> types;
  List<String> abilities;

  Pokemodel({
    this.name, 
    this.height, 
    this.weight, 
    this.image,
    this.types,
    this.abilities
  });

  factory Pokemodel.fromJson(Map<String, dynamic> json) { 
    List<String> type = (json['types'] as List)
        .map((data) => data['type']['name'].toString())
        .toList();
     List<String> abiliti = (json['abilities'] as List)
        .map((data) => data['ability']['name'].toString())
        .toList();

    return Pokemodel(
      name: json['name'],
      height: double.parse(json["height"].toString()),
      weight: double.parse(json["weight"].toString()),
      image: json["sprites"]["other"]["official-artwork"]["front_default"],
      types: type,
      abilities: abiliti
    );
  }
}