import 'dart:convert';
import 'package:http/http.dart' as http;

class Pokelist {
  String name;
  Pokelist({this.name});
  List list=[];
  // int poke=0;
  
  Future<dynamic> getApi() async{
 
    var apiUrl = 'https://pokeapi.co/api/v2/pokemon?limit=151&offset=0';
    
    // for(int i; i<=151; i++ ){
    //   poke++;
    //   poke.toString();
    // }
    // var apiType = 'https://pokeapi.co/api/v2/pokemon/$poke';
    print("dsadas");
    var api= await http.get(apiUrl);
    if(api.statusCode==200){
        var data= jsonDecode(api.body);
        list=data;
    }
 }
}