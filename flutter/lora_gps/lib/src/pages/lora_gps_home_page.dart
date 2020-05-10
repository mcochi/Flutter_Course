
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';


class LoraGPSPage extends StatefulWidget {
  LoraGPSPage({Key key}) : super(key: key);

  @override
  _LoraGPSPageState createState() => _LoraGPSPageState();
}

class _LoraGPSPageState extends State<LoraGPSPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Where is my Car?'),
        backgroundColor: Colors.lightGreen,
        elevation: 50.0,
      ),
      body: SingleChildScrollView(
              child: Stack(
          children: <Widget>[
            _crearMapa(),
            _tarjetaBienvenida(),
          ],),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {},
      ),
    );
  }

  
  Widget _crearMapa() {
    return Container(
      height: 800.0,
      width: 420.0,
      child: FlutterMap(
              options: new MapOptions(
                zoom: 15.0,
                center: LatLng(42.460805,-2.415805),
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
                      point: LatLng(42.460805,-2.415805),
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



  Widget _tarjetaBienvenida() {
    return Container(
      height: 100.0,
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
              title: Text('Last Update: '),
            ),
          ],
        ),
      ),
    );
  } 
}

