import 'package:dgri2/src/utils/convocatoria.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ConvocatoriaPage extends StatefulWidget {
  ConvocatoriaPage({Key key}) : super(key: key);

  @override
  _ConvocatoriaPageState createState() => _ConvocatoriaPageState();
}

class _ConvocatoriaPageState extends State<ConvocatoriaPage> {

  Future<List<Convocatoria>> convocatoria;
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text( 'Convocatorias Europeas' );
  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  List names = new List();
  List filteredNames = new List();

  @override
  void initState() {
    super.initState();
    convocatoria = fetchPost();
  }

  _ExamplePageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(context),
      body: FutureBuilder<List<Convocatoria>>(
        future: convocatoria,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Convocatoria> data = snapshot.data;
            return _convocatoriaListView(data);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          // Por defecto, muestra un loading spinner
          return CircularProgressIndicator();
        },
      )
    );
  }

    Future<List<Convocatoria>> fetchPost() async {
      final response =
      await http.get('http://79.153.17.195:3002/ProyEu');

      if (response.statusCode == 200) {
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((convocatoriaitem) => new Convocatoria.fromJson(convocatoriaitem)).toList();
      } else {
        // Si esta respuesta no fue OK, lanza un error.
        throw Exception('Failed to load post');
      }
    }

    ListView _convocatoriaListView(List<Convocatoria> data) {
      return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _tile(data[index].id, data[index].deadline, data[index].title, Icons.work);
        },

      );
    }

     ListTile _tile(String id, String deadline, String title , IconData icon) => ListTile(
        title: Text(id,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
        subtitle: Text(title),
        leading: Icon(
          icon,
          color: Colors.blue[500],
        ),
        trailing: Text(deadline),
    );

    Widget _crearInput() {
      return TextField(
        //autofocus: true,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          //counter: Text('Letras ${_nombre.length}'),
          hintText: 'Nombre de la persona',
          labelText: 'Nombre',
          helperText: 'Sólo es el nombre',
          suffixIcon: Icon(Icons.accessibility),
          icon: Icon(Icons.account_circle),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
          ), 
        ),
        onChanged: (valor) {
          setState(() {
          });
        },
      );
    }

    Widget _buildBar(BuildContext context) {
    return new AppBar(
      backgroundColor: Colors.lightGreen,
      centerTitle: true,
      title: _appBarTitle,
      leading: new IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed),
      );
  }

    void _searchPressed() {
      setState(() {
        if (this._searchIcon.icon == Icons.search) {
          this._searchIcon = new Icon(Icons.close);
          this._appBarTitle = new TextField(
            controller: _filter,
            decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search),
              hintText: 'Search...'
            ),
          );
        } else {
          this._searchIcon = new Icon(Icons.search);
          this._appBarTitle = new Text( 'Convocatorias Europeas' );
          filteredNames = names;
          _filter.clear();
        }
      });
    }

}
