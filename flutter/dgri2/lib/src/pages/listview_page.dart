import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ListaPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListaPage> {

  ScrollController _scrollController  = new ScrollController();
  
  List<int> _listanumeros= new List();
  int _ultimoitem = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _agregar10();
    _scrollController.addListener(() { //Esto se va a disparar cada vez que hagamos scrol
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        //_agregar10();  
        _fetchData();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listas'),
      ),
      body: Stack(
        children: <Widget>[
          _crearLista(),
          _crearlaoding(),
        ],
      )
    );
  }

  Widget _crearLista() {
    return RefreshIndicator(
        onRefresh: _obtenerPagina1,
        child: ListView.builder(//Los elementos se renderizan según sean necesarios
        controller:_scrollController,
        itemCount: _listanumeros.length,
        itemBuilder: (BuildContext context, int index) {//Se está creando el contexto ahora, no lo mandamos como argumento
          final imagen = _listanumeros[index];
          return FadeInImage(
            image: NetworkImage('https://picsum.photos/500/300/?image=$imagen'),
            placeholder: AssetImage('assets/original.gif'),
          );
        },

        ),
    );
  }

  Future<Null> _obtenerPagina1() async {
    final duration = new Duration(seconds: 2);
    new Timer(duration,() {
      _listanumeros.clear();
      _ultimoitem++;
      _agregar10();
    });
    return Future.delayed(duration);
  }

  void _agregar10() {
    for (var i = 0; i < 10; i++) {
      _ultimoitem++;
      _listanumeros.add(_ultimoitem);
      setState(() {
        
      });
    }
  }

  Future _fetchData() async {
    _isLoading = true;
    setState(() {});
    final duration = new Duration(seconds: 2);
    return new Timer(duration, respuestaHTTP); 
  }

  void respuestaHTTP() {
    _isLoading = false;
    _agregar10();
    _scrollController.animateTo(
      _scrollController.position.pixels + 100,
      curve: Curves.fastLinearToSlowEaseIn,
      duration: Duration(milliseconds: 250)
    );
  }


  Widget _crearlaoding() {
    if (_isLoading) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
            ],
          ),
          SizedBox(height: 15.0,),
        ],
      );
    } else {
      return Container();
    }
  }
  
}

// https://picsum.photos/500/300/?image=4