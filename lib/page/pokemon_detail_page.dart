import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pokedex/model/pokemon_model.dart';
import 'package:pokedex/services/pokemon_detail.dart';
import 'package:pokedex/sqlite/dbhelper.dart';

class PokemonDetailPage extends StatefulWidget {
  Pokemon pokemonDetail;
  PokemonDetailPage({required this.pokemonDetail,super.key});

  @override
  State<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  List<FullPokemonDetail> pokeDetail=[];


  Future getData()async{
    
    DBHelper.selectGlobalQuery(
      "Select * FROM SQLPokemon pokemon join SQLAbility ability on pokemon.IdPokemon = ability.IdPokemon where pokemon.PokemonName = '${widget.pokemonDetail.name}'"
    ).then((value) async {
      print(value);
      if (value != null && value.length > 0) {
        value.forEach((json){
          pokeDetail.add(
            FullPokemonDetail(
              name: widget.pokemonDetail.name,
              image: json["Image"],
              ability: json["AbilityName"]
            )
          );
          setState(() {
            
          });
        });
      }else{
        print("MASUK");
        await pokemonDetail(widget.pokemonDetail).then((value){
          if(value=="done"){
            print(value);
            DBHelper.selectGlobalQuery(
            "Select * FROM SQLPokemon pokemon join SQLAbility ability on pokemon.IdPokemon = ability.IdPokemon where pokemon.PokemonName = '${widget.pokemonDetail.name}'"
          ).then((value) async {
            if (value != null && value.length > 0) {
              value.forEach((json){
                pokeDetail.add(
                  FullPokemonDetail(
                    name: widget.pokemonDetail.name,
                    image: json["Image"],
                    ability: json["AbilityName"]
                  )
                );
                setState(() {
                  
                });
              });
            }
            });
            EasyLoading.dismiss();
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: null,
        builder: (context, snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          child: Column(
            children: [
              if(pokeDetail.length>1)...[
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(pokeDetail[0].name!.toUpperCase(),style: TextStyle(fontSize: 30),)
                ),
                Image.network(pokeDetail[0].image!),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text("Abilities",style: TextStyle(fontSize: 20),)),
                Flexible(
                  child: ListView.builder(
                    itemCount: pokeDetail.length,
                    itemBuilder: (context,index){
                      return Card(
                        shape: RoundedRectangleBorder( 
                            
                          ),
                        child: Text(pokeDetail[index].ability!,style: TextStyle(fontSize: 20)));
                    }
                  ),
                )
              ]
            ],
          ),
        );
        }

      ),
    );
  }
}