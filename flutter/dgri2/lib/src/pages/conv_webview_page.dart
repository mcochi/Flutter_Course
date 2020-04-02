import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CallWebViewPage extends StatefulWidget {
  //CallWebViewPage(this._url);
  //String _url;
  
  @override
  _CallWebViewPageState createState() => _CallWebViewPageState();
}

class _CallWebViewPageState extends State<CallWebViewPage> {

  //_CallWebViewPageState(this._defaulturl)
  String _defaulturl= "https://ec.europa.eu/info/funding-tenders/opportunities/portal/screen/opportunities/topic-details/compet-06-2014;freeTextSearchKeyword=optical;typeCodes=0,1;statusCodes=31094501,31094502,31094503;programCode=null;programDivisionCode=null;focusAreaCode=null;crossCuttingPriorityCode=null;callCode=Default;sortQuery=openingDate;orderBy=asc;onlyTenders=false;topicListKey=topicSearchTablePageState";

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