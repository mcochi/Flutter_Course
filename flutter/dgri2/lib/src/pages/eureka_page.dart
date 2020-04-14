import 'package:flutter/material.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EurekaPage extends StatefulWidget {
  EurekaPage({Key key}) : super(key: key);

  @override
  _EurekaPageState createState() => _EurekaPageState();
}

class _EurekaPageState extends State<EurekaPage> {

  Future<RssFeed> convocatoria;
  @override
  void initState() {
    super.initState();
    convocatoria = fetchPost();
  }

  Future<RssFeed> fetchPost() async {
      RssFeed response = await http.get("https://www.eurekanetwork.org/rss-eureka-feed.xml").then((response) {
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
      appBar: AppBar(
        title: Text('Eureka Call for Proposals'),
        backgroundColor: Colors.lightGreen,
        centerTitle: true,),
      body: FutureBuilder(
        future: convocatoria,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            RssFeed data = snapshot.data;
            print(data.items[5].title);
            return _convocatoriaListView(context, data);
            
            
            
            /*Column(
              children: <Widget>[
                Text(data.title),
                Text(data.description),
                Text(data.link),
                Text(data.items[0].title),
                Text(data.items[0].description),
                Text(data.items[1].title),
                Text(data.items[1].description),
                Text(data.items[2].title),
                Text(data.items[3].title),
                Text(data.items[4].title),
                Text(data.items[5].title),
                Text(data.items[6].title),


                //Text(data.author),
              ],
            );*/
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
      return ListView.builder(
        itemCount: data.items.length,
        itemBuilder: (context, index) {
          if(index != 0) {
            return _tile(context, data.items[index].title, data.items[index].link,Icons.work);     
          } else{
            return Divider();
          }
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
}