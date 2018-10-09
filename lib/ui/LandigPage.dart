import 'package:flutter/material.dart';
import 'package:memage/ui/SecondScreen.dart';

class LandingPage extends StatefulWidget {
  @override
  LandingPageState createState() {
    return new LandingPageState();
  }
}

class LandingPageState extends State<LandingPage> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    int counter =0;
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
//        floatingActionButton: FloatingActionButton(
//            child: Icon(Icons.add),
//            onPressed: (){
//              Navigator.push(
//                  context,
//                  new MaterialPageRoute(builder: (context) => SecondScreen())
//              );
//            }
//        )
    );

  }

  String generate_url(int counter){
    String url = "http://alchemyzons.com/images/funny_image/$counter"+"_resized.jpg";
    return url;
  }
}
