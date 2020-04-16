import 'package:dgri2/src/utils/convocatoria.dart';
import 'package:dgri2/src/utils/equipamiento.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EquipamientoPage extends StatefulWidget {
  EquipamientoPage({Key key}) : super(key: key);

  @override
  _EquipamientoPageState createState() => _EquipamientoPageState();
}

class _EquipamientoPageState extends State<EquipamientoPage> {

  Future<List<Equipamiento>> convocatoria;
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text( 'Equipamiento' );
  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  List names = new List();
  List filteredNames = new List();
  //int _numberofresults = 0;


  @override
  void initState() {
    super.initState();
    convocatoria = fetchPost();
  }

  _EquipamientoPageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
          //_numberofresults = 14;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(context),
      body: FutureBuilder<List<Equipamiento>>(
        future: convocatoria,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Equipamiento> data = snapshot.data;
            return _convocatoriaListView(data);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          // Por defecto, muestra un loading spinner
          return Center(child: CircularProgressIndicator());
        },
      )
    );
  }

    Future<List<Equipamiento>> fetchPost() async {
      final response =
      await http.get('http://*.*.*.*:*/Equip');

      if (response.statusCode == 200) {
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((convocatoriaitem) => new Equipamiento.fromJson(convocatoriaitem)).toList();
      } else {
        // Si esta respuesta no fue OK, lanza un error.
        throw Exception('Failed to load post');
      }
    }

    ListView _convocatoriaListView(List<Equipamiento> data) {
      List<Equipamiento> tempList = new List<Equipamiento>();
      if(_searchText.isNotEmpty) {
      data.forEach((valor) {
        if((valor.descripcion).toLowerCase().contains(this._searchText.toLowerCase())) {
          tempList.add(valor);
        }
      });
      } else {
        tempList = data;
      }
      //_numberofresults = tempList.length;
      return ListView.builder(
        itemCount: tempList.length,
        itemBuilder: (context, index) {
          return _tile(tempList[index].inv, tempList[index].marca, tempList[index].modelo,tempList[index].dto,tempList[index].descripcion, Icons.equalizer, context);
        },
      );
    }

     ListTile _tile(String inv, String marca, String modelo , String dto, String descripcion, IconData icon, BuildContext context) => ListTile(
        title: Text(descripcion,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
        subtitle: Text(marca),
        trailing: Icon(Icons.subdirectory_arrow_right, color: Colors.blue),
        onTap: () => _mostrarAlert(context, inv, marca,modelo, dto, descripcion),
        /*leading: Icon(
          icon,
          color: Colors.blue[500],
        ),*/
        //trailing: Text(dto),
    );


    Widget _buildBar(BuildContext context) {
    return new AppBar(
      backgroundColor: Colors.lightGreen,
      centerTitle: true,
      title: _appBarTitle,
      actions: <Widget>[
        IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed),
      ] 
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
              hintText: 'Search...',
              //suffix: Text('$_numberofresults resultados'),

            ),
          )
          ;
        } else {
          this._searchIcon = new Icon(Icons.search);
          this._appBarTitle = new Text( 'Equipmamiento' );
          filteredNames = names;
          _filter.clear();
        }
      });
    }


    void _mostrarAlert(BuildContext context, String inv, String marca, String modelo , String dto, String descripcion) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0)
          ),
          title: Text('$descripcion $marca  (INV: $inv)'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Divider(),
              Text('Para más información contactar con $dto'),
              //Text('$dto')
            ]
          ,),
          /*actions: <Widget>[
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

          ],*/
        );
      }
    );
  }

}
