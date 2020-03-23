import 'package:flutter/material.dart';


class CardPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cards'),
      ),
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          _cardTipo1(),
          SizedBox(height: 30.0,),
          _cardTipo2(),
          _cardTipo1(),
          SizedBox(height: 30.0,),
          _cardTipo2(),
          _cardTipo1(),
          SizedBox(height: 30.0,),
          _cardTipo2(),
          _cardTipo1(),
          SizedBox(height: 30.0,),
          _cardTipo2(),
          _cardTipo1(),
          SizedBox(height: 30.0,),
          _cardTipo2(),
          _cardTipo1(),
          SizedBox(height: 30.0,),
          _cardTipo2(),
        ],
      ),
    );
  }

  Widget _cardTipo1 () {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      child: Column(
        children: <Widget>[
          ListTile(
            leading:Icon(Icons.photo_album, color: Colors.blue),
            title: Text('Soy el título de esta tarjeta'),
            subtitle: Text('Esto es el subtitulo de la tarjeta para que veais como funciona el tema de las tarjetas'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {},
            ),
            FlatButton(
              child: Text('Cancelar'),
              onPressed: () {},
            ),
          ])
        ],
      ),
    );
  }

  Widget _cardTipo2 () {

    final card = Container(
      child: Column(
        children: <Widget>[
          FadeInImage(
            image:NetworkImage('https://lh3.googleusercontent.com/-H6PacdskbPehw_P3NQvLvIix3PK3gNC82AZXhpFhYm5PVY26CqyHieUp_jifhmYY-FrcezAVQ=w640-h400-e365'),
            placeholder: AssetImage('assets/original.gif'),
            fadeInDuration: Duration(milliseconds: 200),
            fit: BoxFit.cover,
            ), 
          //Image(
           // image: NetworkImage('https://lh3.googleusercontent.com/-H6PacdskbPehw_P3NQvLvIix3PK3gNC82AZXhpFhYm5PVY26CqyHieUp_jifhmYY-FrcezAVQ=w640-h400-e365'),
           // ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text('No tengo ni idea de que poner'))
        ],
      )
    );
    return Container(
      //color: Colors.white,
      child: ClipRRect(child: card,
      borderRadius: BorderRadius.circular(30.0),),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(35.0),
        boxShadow: <BoxShadow> [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            spreadRadius: 2.0,
            offset: Offset(3.0,3.0)
          )
        ]
      ),
    );
  }
}