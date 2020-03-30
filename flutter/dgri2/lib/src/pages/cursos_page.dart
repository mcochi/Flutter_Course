import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CursosPage extends StatefulWidget {
  CursosPage({Key key}) : super(key: key);

  @override
  _CursosPageState createState() => _CursosPageState();
}

class _CursosPageState extends State<CursosPage> {

  String _defaulturl = 'https://www.larioja.org/thinktic/es/cursos-eventos';

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text('Cursos'),
      ),
      body: Container(
        color: Colors.lightGreen,
        child: WebView(
          key: UniqueKey(),
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: _defaulturl,
          debuggingEnabled: false,
          ),
      ),
    );
  }
}


  

  
  


