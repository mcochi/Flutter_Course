import 'package:dgri2/src/pages/cdti_idi_page.dart';
import 'package:dgri2/src/pages/convocatoria_paget.dart';
import 'package:dgri2/src/pages/dgri2_homepage.dart';
import 'package:dgri2/src/pages/eureka_page.dart';
import 'package:dgri2/src/pages/interreg_page.dart';
import 'package:flutter/material.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RedesPage extends StatefulWidget {
  RedesPage({Key key}) : super(key: key);

  @override
  _RedesPageState createState() => _RedesPageState();
}

class _RedesPageState extends State<RedesPage> {

  Future<RssFeed> convocatoria;
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text( 'Red.es' );
  Widget _appBarBottom = new PreferredSize(child: Text(''),preferredSize: Size(0.0,0.0),);
  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  List names = new List();
  List filteredNames = new List();

  @override
  void initState() {
    super.initState();
    convocatoria = fetchPost();
  }

  _RedesPageState() {
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

  Future<RssFeed> fetchPost() async {
      RssFeed response = await http.get("https://www.red.es/redes/rss").then((response) {
        return response.body;
      }).then((bodyString) {
        var channel = new RssFeed.parse(bodyString);
        print(channel);
        return channel;
      });
      return response;
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _homebutton(),
      drawer: _buildDrawer(),
      appBar: _buildBar(context),
      body: FutureBuilder(
        future: convocatoria,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            RssFeed data = snapshot.data;
            print(data.items[5].title);
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


   ListView _convocatoriaListView(BuildContext context, RssFeed data) {
       List<RssItem> tempList = new List<RssItem>();
      // Búsqueda por palabra clave
      if(_searchText.isNotEmpty) {
        data.items.forEach((valor) {
          if(valor.title.toLowerCase().contains(this._searchText.toLowerCase())) {
            tempList.add(valor);
            //print(valor.title);
          } 
          }
        );
      } else {
        tempList = data.items;
      }
      //print(tempList.length);
      return ListView.builder(
        itemCount: 30,
        itemBuilder: (context, index) {
           return _tile(context, tempList[index].title, tempList[index].link,Icons.work); 
        },
      );
    }

  Widget _tile(BuildContext context, String title, String  link,  IconData icon) {
      return Column(
        children: <Widget>[
          ListTile(
              title: Text(title),
              subtitle: Text(link),
              leading: Icon(
                icon,
                color: Colors.blue[500],
              ),
              trailing: Icon(Icons.arrow_forward),
              onTap: () => _mostrarAlert(context, title, link)/*() => () {
                      final route = MaterialPageRoute(
                      builder: ( context ) => CallWebViewPage()
                      );
                      Navigator.push(context, route);
                    },*/
          ),
          Divider(),
        ],
      );
  }

   void _mostrarAlert(BuildContext context, String title, String url) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0)
          ),
          title: Text('$title'),
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

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      //bottom: _appBarBottom,
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
          this._appBarTitle =  TextField(
            controller: _filter,
            decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search,),
              hintText: 'Search...',
              focusColor: Colors.white,
              //suffix: Text('$_numberofresults resultados'),
            ),
          )
          ;
        } else {
          this._searchIcon = new Icon(Icons.search);
          this._appBarTitle = new Text( 'Red.es' );
          this._appBarBottom = new PreferredSize(child: Text(''),preferredSize: Size(0.0,00.0),);
          filteredNames = names;
          _filter.clear();
        }
      });
    }
}