import 'package:contador/src/pages/contador_page.dart';
import 'package:contador/src/pages/home_page.dart';
import 'package:flutter/material.dart';



class Myapp extends StatelessWidget{
  
  @override
  Widget build( context ) {//Context conoce el árbol de widget
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Center(
        //child: HomePage(),
        child: ContadorPage(),
      ) 
    );
  }
}