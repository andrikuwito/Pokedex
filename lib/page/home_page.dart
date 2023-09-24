import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pokedex/model/pokemon_model.dart';
import 'package:pokedex/page/pokemon_detail_page.dart';
import 'package:pokedex/services/all_pokemon.dart';
import 'package:pokedex/services/pokemon_detail.dart';
import 'package:pokedex/sqlite/dbhelper.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  List<Pokemon> dataPokemonFull = [];
  List<Pokemon> dataPokemon = [];
  TextEditingController searchController = new TextEditingController();
  String? valueDropDown;
  List<String> sorting =["ASC","DES"];

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Future getData()async{
    print("dwa");
    await allPokemon().then((value) async {
      if(value=="done"){
        await getDataFromSQL();
      }
    });

  }
  Future getDataFromSQL()async{
    dataPokemonFull=[];
    DBHelper.selectGlobalQuery('SELECT * FROM SQLPokemon').then((value){
      if (value != null && value.length > 0) {
        value.forEach((json){
          dataPokemonFull.add(
            Pokemon(name: json["PokemonName"],url: json["url"])
          );
        });
        
        setState(() {
          
        });
        dataPokemon = dataPokemonFull;
        EasyLoading.dismiss();
      }
    });
  }

  onSearchTextChanged(String text) async {
    List<Pokemon> results = [];
    if (text.isEmpty) {
      results = dataPokemonFull;
    } else {
      results = dataPokemonFull
          .where((pokemon) => pokemon.name!
              .toLowerCase()
              .contains(text.toLowerCase()))
          .toList();
    }
    setState(() {
      dataPokemon = results;
    });
  }


  @override
  Widget build(BuildContext context) {
    print(dataPokemon);
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokedex"),
        backgroundColor: Colors.grey,
        ),
      body: Column(
        children: [
          Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      suffixIcon: IconButton(
                        padding:EdgeInsets.only(bottom:1),
                        focusColor: Colors.transparent,
                        hoverColor:Colors.transparent,
                        highlightColor:Colors.transparent,
                        splashColor:Colors.transparent,
                        icon: Icon(Icons.clear),
                        onPressed: (){
                          searchController.clear();
                          onSearchTextChanged('');
                        },
                      ),
                      prefixIcon: IconButton(
                        padding:EdgeInsets.only(bottom:1),
                        icon: Icon(Icons.search),
                        onPressed: null,
                      ),
                      hintText: 'Search',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.grey), //<-- SEE HERE
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.grey),
                      ),
                      contentPadding: EdgeInsets.only(top: 10)
                    ),
                    onChanged: onSearchTextChanged,
                    autofocus: false,
                  ),
                ),
                DropdownButton(
                  hint: Text("Default"),
                  value:valueDropDown ,
                  items: sorting.map((item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(), 
                  onChanged: (String? newValue){
                    if(newValue=="ASC"){
                      dataPokemon.sort((a, b) => a.name!.compareTo(b.name!));
                    }else{
                      dataPokemon.sort((a, b) => b.name!.compareTo(a.name!));
                    }
                    
                    setState(() {
                      valueDropDown = newValue!;
                    });
                  },),
                  ],
                ),

              
            
          Flexible(
            child: ListView.builder(
              itemCount: dataPokemon.length,
              itemBuilder: (context,index){
               return Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height/20,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>PokemonDetailPage(pokemonDetail: dataPokemon[index],)));
                        },
                        child: Card(
                          shape: RoundedRectangleBorder( 
                            side: BorderSide(
                         
                            ),
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                            child: Text(dataPokemon[index].name!.toUpperCase(),style: TextStyle(fontSize: 15),))),
                      ),
                    )
                  ],
                );
                 
            })
          ),
        ],
      ),
    );
  }
}