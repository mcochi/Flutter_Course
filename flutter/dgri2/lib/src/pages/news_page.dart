import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsPage extends StatefulWidget {
  NewsPage({Key key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}



class _NewsPageState extends State<NewsPage> {

  String _defaulturl = 'https://twitter.com/riojainnovacion?lang=eu';

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
        actions: <Widget>[
          Container(
            child:FlatButton (
              color: Colors.white24,
              child: Text('Innovación'),
              onPressed: () {
                setState(() {
                  this._defaulturl = 'https://twitter.com/riojainnovacion?lang=eu';
                });
              },) 
              ,),
              SizedBox(width: 5.0,),
              Container(
            child:FlatButton (
              color: Colors.white24,
              child: Text('ThinkTIC'),
              onPressed: () {
                setState(() {
                  this._defaulturl = 'https://twitter.com/thinktic?lang=eu';
                });
              },) 
              ,)
        ],
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('News'),
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
}


  

  
  


