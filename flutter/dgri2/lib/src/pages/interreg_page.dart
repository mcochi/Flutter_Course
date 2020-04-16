import 'package:dgri2/src/pages/cdti_idi_page.dart';
import 'package:dgri2/src/pages/convocatoria_paget.dart';
import 'package:dgri2/src/pages/dgri2_homepage.dart';
import 'package:dgri2/src/pages/eureka_page.dart';
import 'package:dgri2/src/pages/red_es_page.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InterregPage extends StatefulWidget {
  InterregPage({Key key}) : super(key: key);

  @override
  _InterregPageState createState() => _InterregPageState();
}



class _InterregPageState extends State<InterregPage> {

  String _defaulturl = 'https://www.interregeurope.eu/discover-projects/';

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      drawer: _buildDrawer(),
      floatingActionButton: _homebutton(),
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text('Interreg'),
      ),
      body: Container(
        color: Colors.lightGreen,
        child: WebView(
          key: UniqueKey(),
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: _defaulturl,
          ),
      ),
    );
  }

  Widget _homebutton() {
    return (
      FloatingActionButton(
        backgroundColor: Colors.lightGreen,
        child: Icon(Icons.home, ),
        onPressed: () {
                final route = MaterialPageRoute(
                builder: ( context ) => DGRI2HomePage()
                );
                Navigator.push(context, route);
        },
      )
    );
  }

  Widget _buildDrawer() {
    return(
      Drawer(
        elevation: 20.0,
        child: new ListView(
          children: <Widget> [
            new DrawerHeader(child: new Image.asset(
          'images/head.jpg',
          fit: BoxFit.fill,
          colorBlendMode: BlendMode.srcOver,
          filterQuality: FilterQuality.low,
          color: new Color.fromARGB(120, 20, 10, 40),
        )),
            new ListTile(
              title: new Text('Convocatorias Europeas'),
              leading: Icon(Icons.euro_symbol),
              onTap: () {
                final route = MaterialPageRoute(
                builder: ( context ) => ConvocatoriaPage()
                );
                Navigator.push(context, route);
              },
            ),
            new ListTile(
              title: new Text('Eureka calls'),
              leading: Icon(Icons.headset_mic),
              onTap: () {
                final route = MaterialPageRoute(
                builder: ( context ) => EurekaPage()
                );
                Navigator.push(context, route);
              },
            ),
            new ListTile(
              title: new Text('Interreg'),
              leading: Icon(Icons.speaker_group),
              onTap: () {
                final route = MaterialPageRoute(
                builder: ( context ) => InterregPage()
                );
                Navigator.push(context, route);
              },
            ),
            //new Divider(),
            new ListTile(
              title: new Text('CDTI'),
              leading: Icon(Icons.nature),
              onTap: () {
                final route = MaterialPageRoute(
                builder: ( context ) => CdtiIDIPage()
                );
                Navigator.push(context, route);
              },
            ),
             new ListTile(
              title: new Text('Red.es'),
              leading: Icon(Icons.wifi),
              onTap: () {
                final route = MaterialPageRoute(
                builder: ( context ) => RedesPage()
                );
                Navigator.push(context, route);
              },
            ),
          ],
        )
      )
    );
  }
}


  

  
  


