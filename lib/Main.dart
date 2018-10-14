import 'package:flutter/material.dart';
import 'package:memage/ui/SecondScreen.dart';
import 'package:memage/Model/MemeModel.dart';

import './ui/OpeningPage.dart';

void main() => runApp(new MainApp());

class MainApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Memage',
      theme: new ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: new Anime(),
    );
  }
}

class LandingPage extends StatelessWidget {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Grid Demo'),
        ),
        body: new GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(20.0),
          children: new List<Widget>.generate(10, (index) {
            return new GridTile(
              child: new Card(
//                child: Image.network("image.url"),
                child: Image.network(generate_url(counter++)),
              ),
            );
          }),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
            Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) => SecondScreen())
            );
          }
        )
    );
  }

  String generate_url(int counter){
    String url = "http://alchemyzons.com/images/funny_image/$counter"+"_resized.jpg";
    return url;
  }
}


