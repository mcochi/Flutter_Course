import 'package:flutter/material.dart';

class AvatarPage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Avatar Page'),
        actions: <Widget> [
          Container(
            padding: EdgeInsets.all(5.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage('https://pbs.twimg.com/profile_images/1018943227791982592/URnaMrya_400x400.jpg'),
              radius: 25.0,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              right: 10.0
            ),
            child: CircleAvatar(
              child: Text('SL'),
              backgroundColor: Colors.brown,
            ),
          )
        ]
      ),
      body: Center(
        child: FadeInImage(
          image: NetworkImage('https://peru21.pe/resizer/yegUVI2Mw6ovIIz9HkXDzgPaABQ=/980x528/smart/arc-anglerfish-arc2-prod-elcomercio.s3.amazonaws.com/public/Z7OAHOX4E5GK7NXUT2A5MCCI34.jpg'),
          placeholder: AssetImage('assets/original.gif'),
        ),)
    );
  }
}