import 'package:dgri2/src/utils/diagonal_shape.dart';
import 'package:flutter/material.dart';
import 'package:dgri2/src/providers/menu_provider.dart';
import 'package:dgri2/src/utils/iconco_string_util.dart';

class DGRI2HomePage extends StatefulWidget {
  DGRI2HomePage({Key key}) : super(key: key);

  @override
  _DGRI2HomePageState createState() => _DGRI2HomePageState();
}

class _DGRI2HomePageState extends State<DGRI2HomePage> {

  //final _volume = 40.0;
  final double _imageHeight = 256.0;
  List<String> opt = ['News','Convocatorias','Cursos','Equipamiento'];
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
      body: Stack(
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
          _tarjetaBienvenida2(),
          _boton(210.0,opt[0],iconos[0]),
          _boton(320.0,opt[1],iconos[1]),
          _boton(440.0,opt[2],iconos[2]),
          _boton(560.0,opt[3],iconos[3]),
          //Estaría bien montar un background image

          //_listaOpciones(),
        ],),
    );
  }

  Widget _boton(double position, String texto, String icono) {
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
              },
              ),
              Text('$texto')
            ],
            ),
          );
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
      height: 640.0,
      //color: Colors.redAccent,
      padding: EdgeInsets.only(top: 350.0, left: 110.0),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        child: Column(
          children: <Widget>[
            ListTile(
              leading:Icon(Icons.explore, color: Colors.blue),
              title: Text('SRI:'),
              subtitle: Text('El Sistema Riojano de Innovación se define en la Ley 3/2009 de Ciencia, Tecnología e Innovación de La Rioja, como TODOS los agentes, estructuras e instrumentos públicos y privados, que participan activamente en el desarrollo de la capacidad de innovación de la región, estableciendo entre si a lo largo del proceso de innovación múltiples interconexiones.') 
              ,

            ),
          ],
        ),
      ),
    );
  }

  Widget _botones() {
    List<String> opt = ['News','Convocatorias Europeas','Cursos','Equipamiento'];
    List<String> iconos = ['add_alert', 'accessibility', 'folder_open', 'donut_large'];

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

  
}