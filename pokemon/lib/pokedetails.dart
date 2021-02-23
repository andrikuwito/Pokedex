import 'package:flutter/material.dart';
import 'package:pokemon/pokemodel.dart';
String capitalize(String s) {
  return '${s[0].toUpperCase()}${s.substring(1)}';
}
class pokedetails extends StatelessWidget {
  final Pokemodel pokemodel;
  pokedetails({this.pokemodel});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(pokemodel.name),),
        body:getBody()
      );
  }

  Widget getBody()=>Stack(
            children: <Widget>[Positioned(width:400 ,child: Column(children: [

              Container(margin: EdgeInsets.only(top:100)),
              Image.network(pokemodel.image, height: 200,width: 200,),
              Container(margin: EdgeInsets.only(bottom:10)),
              Text(capitalize(pokemodel.name),style:TextStyle(fontSize: 50)),
              Container(margin: EdgeInsets.only(bottom:10)),
              Text("Height: "+pokemodel.height.toString()),
              Container(margin: EdgeInsets.only(bottom:10)),
              Text("Weight: "+pokemodel.weight.toString()),
              Container(margin: EdgeInsets.only(bottom:10)),
              Row(mainAxisAlignment: MainAxisAlignment.center,children: [Text("Types: "),
              Row(mainAxisAlignment: MainAxisAlignment.center,children:pokemodel.types.map((typeText) =>FilterChip(
              backgroundColor: Colors.deepOrange, label: Text(typeText), onSelected: (bool value) {},)).toList(),)]),
              Container(margin: EdgeInsets.only(bottom:10),),

              Row(mainAxisAlignment: MainAxisAlignment.center,children: [Text("Abilities: "),
              Row(mainAxisAlignment: MainAxisAlignment.center,children:pokemodel.abilities.map((abilitiesText) =>FilterChip(
              backgroundColor: Colors.deepOrange, label: Text(abilitiesText), onSelected: (bool value) {},)).toList(),)]),
              ])),
              
            ],
          );
     
  

}