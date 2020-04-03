import 'package:dgri2/src/pages/conv_webview_page.dart';
import 'package:dgri2/src/utils/convocatoria.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:webview_flutter/webview_flutter.dart';

// API SOURCE
// http://ec.europa.eu/info/funding-tenders/opportunities/data/referenceData/grantsTenders.json

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
  int _numberofresults = 0;


  @override
  void initState() {
    super.initState();
    convocatoria = fetchPost();
  }

  _ConvocatoriaPageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
          _numberofresults = 14;
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
            return _convocatoriaListView(context, data);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          // Por defecto, muestra un loading spinner
          return Center(child: CircularProgressIndicator());
        },
      )
    );
  }

    Future<List<Convocatoria>> fetchPost() async {
      final response =
      await http.get('http://ec.europa.eu/info/funding-tenders/opportunities/data/referenceData/grantsTenders.json');

      if (response.statusCode == 200) {
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        List jsonResponse = json.decode(response.body)['fundingData']['GrantTenderObj'];
        return jsonResponse.map((convocatoriaitem) => new Convocatoria.fromJson(convocatoriaitem)).toList();
      } else {
        // Si esta respuesta no fue OK, lanza un error.
        throw Exception('Failed to load post');
      }
    }

    ListView _convocatoriaListView(BuildContext context, List<Convocatoria> data) {
      List<Convocatoria> tempList = new List<Convocatoria>();
      if(_searchText.isNotEmpty) {
      data.forEach((valor) {
        if((valor.title + valor.identifier).toLowerCase().contains(this._searchText.toLowerCase()) && valor.status.contains("Open")) {
          tempList.add(valor);
        } 
      });
      } else {
        data.forEach((valor) {
        if(valor.status.contains("Open")) {
          tempList.add(valor);
        } 
      });
        //tempList = data;
      }
      _numberofresults = tempList.length;
      return ListView.builder(
        itemCount: tempList.length,
        itemBuilder: (context, index) {
          return _tile(context, tempList[index].identifier, tempList[index].deadline.toString(), tempList[index].title, tempList[index].cftId.toString(), tempList[index].type.toString(),tempList[index].status, tempList[index].description, Icons.work);
        },
      );
    }

     ListTile _tile(BuildContext context, String id, String deadline, String title , String etendering, String tipo, String status, String description,  IconData icon) {
       String url = '';
       String text = '';
       if (tipo.contains('0')){
         text = description;
         url = "https://etendering.ted.europa.eu//cft/cft-display.html?cftId="+etendering;
       } else {
         url = "https://ec.europa.eu/info/funding-tenders/opportunities/portal/screen/opportunities/topic-details/" + id.toLowerCase();
       }
      return ListTile(
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
          trailing: Text(status),
          onTap: () => _mostrarAlert(context, id, url, text , tipo)/*() => () {
                  final route = MaterialPageRoute(
                  builder: ( context ) => CallWebViewPage()
                  );
                  Navigator.push(context, route);
                },*/
      );
    }
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
          this._appBarTitle = new Text( 'Convocatorias Europeas' );
          filteredNames = names;
          _filter.clear();
        }
      });
    }

    void _mostrarAlert(BuildContext context, String identifier, String url, String text, String tipo) {
    if (tipo.contains('1')) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0)
          ),
          title: Text('$identifier'),
          content: Container(
            width: 300.0,
            color: Colors.lightGreen,
            child: WebView(
            key: UniqueKey(),
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: url,
            debuggingEnabled: false,
            ),
          ),
        );
      }
    );
    } else {
      showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0)
          ),
          title: Text('$identifier'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 300.0,
                //color: Colors.lightGreen,
                child: Text(text),
                ),
                Container(
                width: 300.0,
                //color: Colors.lightGreen,
                child: Text('Para más información visitar: \n $url'),
                )
            ]
          ),
        );
      }
    );
    }
  }
}
