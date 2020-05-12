import 'package:flutter/material.dart';
import 'package:lora_gps/src/pages/lora_gps_experimental.dart';
import 'package:lora_gps/src/pages/lora_gps_home_page.dart';


Map<String,WidgetBuilder> getApplicationRoutes() {

  return <String, WidgetBuilder> {
        //'/': (BuildContext context) => LoraGPSPage()
        '/': (BuildContext context) => ExperimentalLoraGPSPage()

  };

}