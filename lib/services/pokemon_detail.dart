import 'dart:async';
import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/global.dart';
import 'package:pokedex/model/pokemon_model.dart';
import 'package:pokedex/sqlite/dbhelper.dart';

Future pokemonDetail(Pokemon pokemon) async{
  try {
    easyloadingInstance();
    EasyLoading.show();
    final url = Uri.parse(pokemon.url!);
    print(url);
    var request = http.Request('GET', url);
    
    var send = await request.send();
    var response = await http.Response.fromStream(send);
    final jsonResponse = json.decode(response.body);
    print(jsonResponse);
    var data = PokemonDetail.fromJson(jsonResponse);
    // await Future.forEach(dataList, (String data) async {
    //       // Lakukan pemrosesan data di sini
    //       await processDataItem(data);
    // });

    Future someFunc() async {
      for(AbilityList ability in data.abilities!) {
        await DBHelper.selectGlobalQuery("SELECT * FROM SQLPokemon Where PokemonName = '${pokemon.name}'").then((value){
          if (value != null && value.length > 0) {
            value.forEach((json) async {
              await DBHelper.insertGlobal(
                "INSERT INTO SQLAbility (IdPokemon, AbilityName,Image)"
                "Values('${json["IdPokemon"]}','${ability.abilityName!.name}','${data.sprites!.image}')"
              );

            });
            print("Selesai");
          }
        });
      }
    }
    await someFunc();

    return "done";
  }
  catch(error){
    print(error);
  }
}