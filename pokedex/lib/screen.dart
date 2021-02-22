import 'package:flutter/material.dart';
import 'package:pokedex/pokelist.dart';

class screen extends StatefulWidget {
  @override
  _screenState createState() => _screenState();
}

class _screenState extends State<screen> {

  Pokelist pokemon = Pokelist();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.pokemon;
  }

  void getPokemon() async{
    print("dsa");
    await pokemon.getApi();
    // setState(() {
    //   pokemon;
    // });
  }
  
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text("P@kedex"),
       ),
       body: Text("dsadsa"),
      );
  }

}