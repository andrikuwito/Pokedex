import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:pokemon/pokedetails.dart';
import 'package:pokemon/pokemodel.dart';

class pokelist extends StatefulWidget {
  @override
  _pokelistState createState() => _pokelistState();
}
String capitalize(String s) {
  return '${s[0].toUpperCase()}${s.substring(1)}';
}
List pokename =[];
Pokemodel pokemodel;  
List pokee=[];

class _pokelistState extends State<pokelist> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.pokemon();
  }

  
  Future<void>pokemon() async{
      String apiUrl = "https://pokeapi.co/api/v2/pokemon?limit=151&offset=0";
      var api = await http.get(apiUrl);
      if(api.statusCode==200){
        var items = json.decode(api.body)['results'];
        setState(() {
          pokename = items;
        });  
      }
      for(int i=0 ; i<pokename.length; i++){
        print(pokename[i]['url']);
        var apitype = await http.get(pokename[i]['url']);
        if(apitype.statusCode==200){
          var itemstype=jsonDecode(apitype.body); 
          var poki= Pokemodel.fromJson(itemstype);
         
          setState(() {
            pokee.add(poki);
          });
        }
      } 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("P@kedex"),actions: <Widget>[IconButton(icon: Icon(Icons.search), onPressed:(){
          showSearch(context: context, delegate: pokemonSearch());
        }) 
        ],),
        body: getBody(),
      );
  }

  Widget getBody(){
    return ListView.builder(itemCount:pokee.length ,itemBuilder: (context,index){
      var bl=pokee[index];
      var name= bl.name;
      var image= bl.image;
      return InkWell( onTap: (){
        Navigator.push(context, MaterialPageRoute(builder:(context)=>pokedetails(pokemodel: bl)));
      },
        child: Card(
          child: Column(
            children: <Widget>[
              Container(width: 100),
              Image.network(image,height: 170,width: 170),
              Text(capitalize(name),style: TextStyle(fontSize: 25),),
            ],
          ),
      )
    );
    });
  }
}

class pokemonSearch extends SearchDelegate<String>{

  @override
  List<Widget> buildActions(BuildContext context) {
      return[
        IconButton(icon: Icon(Icons.clear), onPressed:(){query='';})
      ];
    }
  
    @override
    Widget buildLeading(BuildContext context) {
      return IconButton(icon: Icon(Icons.arrow_back), onPressed: (){close(context, null);});
    }
  
    @override
    Widget buildResults(BuildContext context) {
     final pokeee= query.isEmpty? pokee: pokee.where((p) => p.name.startsWith(query.toLowerCase())).toList();
     return pokeee.isEmpty? Text("No Pokemon"): ListView.builder(itemCount: pokeee.length , itemBuilder: (context,index){

       final pokemon = pokeee[index];
       return InkWell( onTap: (){
        Navigator.push(context, MaterialPageRoute(builder:(context)=>pokedetails(pokemodel:pokemon)));
      },
        child: Card(
          child: Column(
            children: <Widget>[
              Container(margin: EdgeInsets.only(bottom:10)),
              Text(capitalize(pokemon.name),style: TextStyle(fontSize: 25),),
              Container(margin: EdgeInsets.only(bottom:15)),
            ],
          ),
      )
    );
     });
    }
  
    @override
    Widget buildSuggestions(BuildContext context) {
     final pokeee= query.isEmpty? pokee: pokee.where((p) => p.name.startsWith(query.toLowerCase())).toList();
     return pokeee.isEmpty? Text("No Pokemon"): ListView.builder(itemCount: pokeee.length , itemBuilder: (context,index){

       final pokemon = pokeee[index];
       return InkWell( onTap: (){
        Navigator.push(context, MaterialPageRoute(builder:(context)=>pokedetails(pokemodel:pokemon)));
      },
        child: Card(
          child: Column(
            children: <Widget>[
              Container(margin: EdgeInsets.only(bottom:10)),
              Text(capitalize(pokemon.name),style: TextStyle(fontSize: 25),),
              Container(margin: EdgeInsets.only(bottom:15)),
            ],
          ),
      )
    );
     });
  }

}