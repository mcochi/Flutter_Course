import 'package:dgri2/src/pages/convocatoria_paget.dart';
import 'package:dgri2/src/pages/cursos_page.dart';
import 'package:dgri2/src/pages/equip_page.dart';
import 'package:dgri2/src/pages/news_page.dart';
import 'package:dgri2/src/utils/diagonal_shape.dart';
import 'package:flutter/material.dart';
import 'package:dgri2/src/providers/menu_provider.dart';
import 'package:dgri2/src/utils/iconco_string_util.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'alert_page.dart';

class DGRI2HomePage extends StatefulWidget {
  DGRI2HomePage({Key key}) : super(key: key);

  @override
  _DGRI2HomePageState createState() => _DGRI2HomePageState();
}

class _DGRI2HomePageState extends State<DGRI2HomePage> {

  //final _volume = 40.0;
  final double _imageHeight = 256.0;
  List<String> opt = ['News','Convocatorias','Cursos','Equipamiento',''];
  List<String> iconos = ['add_alert', 'accessibility', 'folder_open', 'donut_large'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
        //title: Text('DGRI2 Home Page'),
        //backgroundColor: Colors.lightGreen,
        //shape: ContinuousRectangleBorder(
          //borderRadius: BorderRadiusDirectional.circular(70.0),
        //),
        //elevation: 50.0,
      //),
      body: SingleChildScrollView(
              child: Stack(
          children: <Widget>[
            /*Container(
              decoration: BoxDecoration(image: DecorationImage(
                image: AssetImage('images/birds.jpb'),
                fit: BoxFit.contain,
              )),
            ),*/
            _buildIamge(),
            _tarjetaBienvenida(),
            Divider(),
            _crearMapa(),
            //_tarjetaBienvenida2(),
            _boton(310.0,opt[0],iconos[0],context,'news'),
            _boton(420.0,opt[1],iconos[1],context,'convocatorias'),
            _boton(540.0,opt[2],iconos[2],context,'cursos'),
            _boton(660.0,opt[3],iconos[3],context,'equipamiento'),
            //_boton(760.0,opt[3],iconos[3],context,'equipamiento'),
            _tarjetaBienvenida2(),
            _crearMapa(),
            //_boton(760.0,opt[3],iconos[3]),


            //Estaría bien montar un background image

            //_listaOpciones(),
          ],),
      ),
    );
  }

  Widget _boton(double position, String texto, String icono, BuildContext context, String nextscreen) {
    return Container(
            width: 110.0,
            padding: EdgeInsets.only(top: position, left:10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
              IconButton(
              icon: getIcon(icono),
              tooltip: 'Increase volume by 10',
              iconSize: 48.0,
              color: Colors.blue,
              onPressed: () {
                final route = MaterialPageRoute(
                builder: ( context ) => _nextscreen(nextscreen)
                );
                Navigator.push(context, route);
              },
              ),
              Text('$texto')
            ],
            ),
          );
  }

  Widget _nextscreen(String nextscreen) {
    switch(nextscreen) { 
      case "news": {  return NewsPage(); } 
      break; 
     
      case "convocatorias": {  return ConvocatoriaPage(); } 
      break; 
     
      case "cursos": {  return CursosPage(); } 
      break; 
     
      case "equipamiento": {  return EquipamientoPage(); } 
      break;
       
     
      default: { return AlertPage(); } 
      break; 
   } 
  }

  Widget _tarjetaBienvenida() {
    return Container(
      height: 350.0,
      padding: EdgeInsets.only(top: 190.0, left: 110.0),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        child: Column(
          children: <Widget>[
            ListTile(
              leading:Icon(Icons.question_answer, color: Colors.blue),
              title: Text('D.G. Reindustrialización, Internacionalización e Innovación'),
              subtitle: Text('En esta app encontrarás las últimas noticias, cursos y eventos relacionados la dirección y la innovación en La Rioja')
              ,
            ),
          ],
        ),
      ),
    );
  }

  Widget _tarjetaBienvenida2() {
    return Container(
      height: 800.0,
      //color: Colors.redAccent,
      padding: EdgeInsets.only(top: 675.0, left: 110.0),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        child: Column(
          children: <Widget>[
            ListTile(
              leading:Icon(Icons.gps_fixed, color: Colors.blue),
              title: Text('Centro Tecnológico de La Rioja'),
              subtitle: Text('Av. Zaragoza 21, \n 26006 \n Logroño, \n La Rioja') 
              ,

            ),
          ],
        ),
      ),
    );
  }

  Widget _botones() {
    List<String> opt = ['News','Convocatorias Europeas','Cursos','Equipamiento','Equipamiento'];
    List<String> iconos = ['add_alert', 'accessibility', 'folder_open', 'donut_large','donut_large'];

    return Expanded(
          child: Container(
        height: 400.0,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                    child: Container(
                    //color: Colors.lime,
                    child: _botonIcono(opt[0],iconos[0]),
                  ),
                ),
                Expanded(
                            child: Container(
                    //color: Colors.pink,
                    child: _botonIcono(opt[1],iconos[1]),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              children: <Widget>[
                Expanded(
                    child: Container(
                    //color: Colors.yellow,
                    child: _botonIcono(opt[2],iconos[2]),
                  ),
                ),
                Expanded(
                    child: Container(
                    //color: Colors.redAccent,
                    child: _botonIcono(opt[3],iconos[3]),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _botonIcono(String texto, String icono) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      IconButton(
        icon: getIcon(icono),
        tooltip: 'Increase volume by 10',
        iconSize: 48.0,
        onPressed: () {
        },
      ),
      Text('$texto')
    ],
  );
  }

  Widget _buildIamge() {
    return new Positioned.fill(
      bottom: null,
      child: new ClipPath(
        clipper: new DialogonalClipper(),
        child: new Image.asset(
          'images/ctr.jpg',
          fit: BoxFit.cover,
          height: _imageHeight,
          colorBlendMode: BlendMode.srcOver,
          filterQuality: FilterQuality.low,
          color: new Color.fromARGB(120, 20, 10, 40),
        ),
      ),
    );
  }

  Widget _crearMapa() {
    return 
        Positioned(
          left: 120.0,
          top: 360.0,
          height: 300.0,        
          child: Container(
          width: 280.0,
          //height: 800.0,

          color: Colors.redAccent,
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
      ),
        );
  }

  
}