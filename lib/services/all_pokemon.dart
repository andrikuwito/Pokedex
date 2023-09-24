import 'dart:async';
import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/global.dart';
import 'package:pokedex/model/pokemon_model.dart';
import 'package:pokedex/sqlite/dbhelper.dart';


Future allPokemon() async{
  final url = Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=100000&offset=0');
  try {
    easyloadingInstance();
    EasyLoading.show();
    var request = http.Request('GET', url);
    var streamedResponse = await request.send().timeout(
      Duration(seconds: 60),
      onTimeout: () {
        throw TimeoutException("no internet").message.toString();
      },
    );
    var response = await http.Response.fromStream(streamedResponse);
    final jsonResponse = json.decode(response.body);
    final data = ListPokemon.fromJson(jsonResponse);

    data.result!.forEach((element) async {
      // await pokemonDetail(element.name!,element.url!);
      DBHelper.insertGlobal(
        "INSERT INTO SQLPokemon (PokemonName, url)"
        "SELECT '${element.name}','${element.url}'"
        "WHERE NOT EXISTS (SELECT 1 FROM SQLPokemon WHERE PokemonName = '${element.name}' )"
    );

    });

    return "done";
  }
  catch(error){
    print(error);
  }
}