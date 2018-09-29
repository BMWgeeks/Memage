import 'package:flutter/material.dart';

void main() => runApp(new MainApp());

class MainApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: new LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Grid Demo'),
        ),
        body: new GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(20.0),
          children: new List<Widget>.generate(16, (index) {
            return new GridTile(
              child: new Card(
                child: Image.network("image.url"),
//                  child: new Text('tile $index')
//                child: Image.network(
//                    "https://memegen.link/_YnV6egltZW1lcy9tZW1lcy1ldmVyeXdoZXJl.jpg"),
                // color: Colors.blue.shade200,
                //  child: new Center(

                //  )
              ),
            );
          }),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
//          onPressed: fetchImage,
        )
    );
  }
}


