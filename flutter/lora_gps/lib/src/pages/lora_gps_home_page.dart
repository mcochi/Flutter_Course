
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:lora_gps/src/utils/coordinates.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class LoraGPSPage extends StatefulWidget {
  LoraGPSPage({Key key}) : super(key: key);

  @override
  _LoraGPSPageState createState() => _LoraGPSPageState();
}

class _LoraGPSPageState extends State<LoraGPSPage> {

  Future<Coordinate> last_coordinate;

  @override
  void initState() { 
    super.initState();
    last_coordinate = fetchPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Where is my Car?'),
        backgroundColor: Colors.lightGreen,
        elevation: 50.0,
      ),
      body: FutureBuilder<Coordinate>(
        future: last_coordinate,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Coordinate data = snapshot.data;
            return _stackcreation(data);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          // Por defecto, muestra un loading spinner
          return Center(child: CircularProgressIndicator());
        }
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: _refreshAction,
      ),
    );
  }
  _refreshAction() {
  setState(() {
    last_coordinate = fetchPost();
  });
}

  Widget _stackcreation(Coordinate data){
    return Stack(children: <Widget>[
      _tarjetaBienvenida(data),
      _crearMapa(data),
    ],);
  } 
  
  Widget _crearMapa(Coordinate data) {

    // Preprocess Data that comes from API Rest
    String latitud = data.latitud;
    String longitud  = data.longitud;
    String fechahora = data.fechahora;

    // Recuerda que me he liado a la hora de definir latitud y longitud en la api y que hay que intercambiarla
    List <String> latitudList = latitud.split('-');
    List <String> longitudList = longitud.split('-');
    double finallatitud;
    double finallongitud;

    if (latitudList[1].contains('W')) {
       // Si es West hay que muliplicar el número por -1
      // Recuerda que el formato de este es DDDmm.mm
      int latitudmantisa = int.parse(latitudList[0].substring(0,3));
      double latituddecimal = double.parse(latitudList[0].substring(3))/60.0;
      finallatitud = (latitudmantisa + latituddecimal) * -1.0; 
    } else {
      // Si es West hay que muliplicar el número por -1
      // Recuerda que el formato de este es DDDmm.mm
      int latitudmantisa = int.parse(latitudList[0].substring(0,3));
      double latituddecimal = double.parse(latitudList[0].substring(3))/60.0;
      finallatitud = (latitudmantisa + latituddecimal);
    }

     if (longitudList[1].contains('S')) {
       // Si es West hay que muliplicar el número por -1
      // Recuerda que el formato de este es DDmm.mm
      int longitudmantisa = int.parse(longitudList[0].substring(0,2));
      double longituddecimal = double.parse(longitudList[0].substring(2))/60.0;
      finallongitud = (longitudmantisa + longituddecimal) * -1.0; 
    } else {
      // Si es West hay que muliplicar el número por -1
      // Recuerda que el formato de este es DDmmm.mm
      int longitudmantisa = int.parse(longitudList[0].substring(0,2));
      double longituddecimal = double.parse(longitudList[0].substring(2))/60.0;
      finallongitud = (longitudmantisa + longituddecimal);
    }
    print(finallatitud);
    print(finallongitud);
    return Container(
      height: 800.0,
      width: 420.0,
       padding: EdgeInsets.only(top: 80.0),
      child: FlutterMap(
              options: new MapOptions(
                zoom: 16.0,
                center: LatLng(finallongitud,finallatitud),
              ),
              layers: [
                new TileLayerOptions(
                  urlTemplate: "https://api.tiles.mapbox.com/v4/"
                      "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
                  additionalOptions: {
                    'accessToken': 'pk.eyJ1IjoiY29yb2RyaSIsImEiOiJjazg4anhmdjgwOHoxM2duYW94eHh5ZXU4In0.eMWj4O7qmGTnDK6XkEOTJQ',
                    'id': 'mapbox.streets',
                  },
                ),
                new MarkerLayerOptions(
                  markers: [
                    new Marker(
                      width: 80.0,
                      height: 80.0,
                      point: LatLng(finallongitud,finallatitud),
                      builder: (ctx) =>
                      new Container(
                        child: new Icon(Icons.gps_fixed),
                      ),
                    ),
                  
                  ],

                ),
              ],
            ),
    );
  } 
  Widget _tarjetaBienvenida(Coordinate data) {
    String latitud = data.latitud;
    String longitud  = data.longitud;
    String fechahora = data.fechahora;
    return Container(
      height: 80.0,
      padding: EdgeInsets.only(top: 0.0, left: 0.0),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        child: Column(
          children: <Widget>[
            ListTile(
              leading:Icon(Icons.question_answer, color: Colors.blue),
              title: Text("Last updated on " + fechahora),
              subtitle: Text("Latitud: " + longitud + "\nLongitud: " + latitud), //Recuerda que me lie en la API y puse longitud y latitud cambiados
            ),
          ],
        ),
      ),
    );
  } 
  Future<Coordinate> fetchPost() async {
      final response =
      await http.get('http://83.32.158.101:3002/lora_gps_last');

      if (response.statusCode == 200) {
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((convocatoriaitem) => new Coordinate.fromJson(convocatoriaitem)).toList()[0];
      } else {
        // Si esta respuesta no fue OK, lanza un error.
        throw Exception('Failed to load post');
      }
    }
}

