import 'dart:convert';

class ListPokemon{
  ListPokemon({
    this.result,
  });
  List<Pokemon>? result;


  factory ListPokemon.fromJson(Map<String, dynamic> json) => ListPokemon(
      result: List<Pokemon>.from(json["results"].map((x) => Pokemon.fromJson(x))), 
  );
}

class Pokemon{
  Pokemon({
    this.name,
    this.url,

  });
  String? name;
  String? url;

  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
      name: json["name"]==null?false:json["name"],
      url: json["url"]==null?"":json["url"],
  );
}

class PokemonDetail{
  PokemonDetail({
    this.sprites,
    this.abilities,
  });
  ImagePokemon? sprites;
  List<AbilityList>? abilities;
  factory PokemonDetail.fromJson(Map<String, dynamic> parseJson) => PokemonDetail(
    sprites: ImagePokemon.fromJson(parseJson["sprites"]),
    abilities: List<AbilityList>.from(parseJson["abilities"].map((x) => AbilityList.fromJson(x))), 
  );
}

class ImagePokemon{
  ImagePokemon({
    this.image,
  });
  String? image;
  factory ImagePokemon.fromJson(Map<String, dynamic> json) =>
      ImagePokemon(
          image: json["front_shiny"]==null?"":json["front_shiny"],
      );
}
class AbilityList{
  AbilityList({
    this.abilityName,
  });
  AbilityDetail? abilityName;
  factory AbilityList.fromJson(Map<String, dynamic> json) =>
      AbilityList(
        abilityName: AbilityDetail.fromJson(json["ability"]),
      );
}

class AbilityDetail{
  AbilityDetail({
    this.name,
  });
  String? name;
  factory AbilityDetail.fromJson(Map<String, dynamic> json) =>
      AbilityDetail(
        name: json["name"]==null?"":json["name"],
      );
}

class FullPokemonDetail{
  FullPokemonDetail({
    this.name,
    this.image,
    this.ability

  });
  String? name;
  String? image;
  String? ability;

}
