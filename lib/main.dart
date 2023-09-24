import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:pokedex/page/home_page.dart';
import 'package:pokedex/services/all_pokemon.dart';
import 'package:pokedex/sqlite/dbhelper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // ignore: deprecated_member_use
  FlutterNativeSplash.removeAfter(splashScreen);
  runApp(const MyApp());
}

Future splashScreen(context)async{
  await Future.delayed(Duration(seconds: 3));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      builder: EasyLoading.init(),
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    DBHelper.openDB().then((value){
      if(value=="open"){
        Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => Homepage()),(Route<dynamic> route) => false,);
      }
      else if(value=="closed"){
        DBHelper.createDB().then((value){
          if(value=="done"){
            DBHelper.openDB().whenComplete((){
              Timer(const Duration(milliseconds:30), () async {
                Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => Homepage()),(Route<dynamic> route) => false,);
              });
            });
          }
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    );
  }
}
