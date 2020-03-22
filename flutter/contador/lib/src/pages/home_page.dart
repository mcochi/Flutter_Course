import 'package:flutter/material.dart';



class HomePage extends StatelessWidget {
  
  final estiloTexto = new TextStyle(fontSize: 25);
  final conteo = 10;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Titulo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Número de clicks:',style: estiloTexto ,),
            Text('$conteo',style: estiloTexto ,),
          ],
        )
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Hola mundo!');
          //conteo = conteo + 1;
        },
        child: Icon(Icons.add_circle_outline),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}