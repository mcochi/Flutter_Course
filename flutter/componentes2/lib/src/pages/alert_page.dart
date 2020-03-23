import 'package:flutter/material.dart';

class AlertPage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alert Page')
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Mostrar Alerta!'),
          color: Colors.blue,
          onPressed: () => _mostrarAlert(context),
          shape: StadiumBorder(),
          ) 
        ,),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.format_textdirection_r_to_l),
        onPressed: () {
          Navigator.pop(context);
        }),
    );
  }

  void _mostrarAlert(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0)
          ),
          title: Text('Titutlo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Este es el contenido de la alerta'),
              FlutterLogo(size: 100.0)
            ]
          ,),
          actions: <Widget>[
            FlatButton(
              child:Text('ok'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child:Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

          ],
        );
      }
    );
  }
}