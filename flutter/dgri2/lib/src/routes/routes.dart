
import 'package:flutter/material.dart';

import 'package:dgri2/src/pages/dgri2_homepage.dart';


Map<String,WidgetBuilder> getApplicationRoutes() {

  return <String, WidgetBuilder> {
        '/': (BuildContext context) => DGRI2HomePage(),

  };

}