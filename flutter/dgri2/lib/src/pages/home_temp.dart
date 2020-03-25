import 'package:flutter/material.dart';

class HomePageTemp extends StatelessWidget {
  
  final opciones = ['Uno', 'Dos', 'Tres', 'Cuatro', 'Cinco'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Componentes Temp'),
      ),
      body: ListView(
        //children: _crearItems()
        children: _crearitemcorto(),
      ),
    );
  }

  List<Widget> _crearItems() {
    List<Widget> lista = new List<Widget>();
    for (String opt in opciones) {
      final tempWidget = ListTile(
        title: Text( opt )
      );
      lista.add(tempWidget);
      lista.add(Divider());

    }

    return lista;
  }


  List<Widget> _crearitemcorto() {
    return opciones.map((item) {
      return Column(
        children: <Widget>[
          ListTile(
            subtitle: Text('Cualquier cosa'),
            leading: Icon(Icons.account_balance_wallet),
            trailing: Icon(Icons.arrow_right),
            title: Text(item + '!'),
            onTap: () {},
          ),
          Divider(),
        ],
      );
    }).toList();
  
  }
}