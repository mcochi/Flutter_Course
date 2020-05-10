import 'package:flutter/material.dart';
import 'package:lora_gps/src/pages/lora_gps_home_page.dart';
import './src/routes/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en','US'), // English
        const Locale('es','ES'), // Hebrew
        const Locale.fromSubtags(languageCode: 'zh'), // Chinese *See Advanced Locales below*
    // ... other locales the app supports
      ],
      //home: HomePage(),
      initialRoute: '/',
      routes: getApplicationRoutes(),
      onGenerateRoute: (RouteSettings settings) {// En el caso de que nos lleve a una ruta que no está definida
        print('Ruta llamada: ${settings.name}');
        return MaterialPageRoute (
          builder: (BuildContext context) => LoraGPSPage()
        );
      },
    );
  }
}