import 'package:flutter/material.dart';
import './SecondScreen.dart';
import './DetailPage.dart';

class LandingPage extends StatefulWidget {
 @override
 State<StatefulWidget> createState() {
    return _LandingPage();
  }
}

class _LandingPage extends State<LandingPage> {
  // List<Image> imgList = new List<Image>();
  int counter = 0;
  int _currentIndex = 0;

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
              child: new InkResponse(
                enableFeedback: true,
                child: new Card(
                child: new Image.network(_generate_url(counter++)),
                ),
                onTap: () => _onCardTapped(counter, context),
              )
            );
          }),
        ),
         bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex, // this will be set when a new tab is tapped
              onTap: (newIndex) => setState((){
              _currentIndex = newIndex;
              }), 
              items: [
                BottomNavigationBarItem(
                  icon: new Icon(Icons.search),
                  title: new Text("Search"),
                  ),
                BottomNavigationBarItem(
                  icon: new Icon(Icons.add),
                  title: new Text("Add"),
                  ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bookmark),
                  title: Text("Like")
        )
      ],
    ),
        // floatingActionButton: FloatingActionButton(
        //   child: Icon(Icons.add),
        //   onPressed: (){
        //     Navigator.push(
        //         context,
        //         new MaterialPageRoute(builder: (context) => SecondScreen())
        //     );
        //   }
        // )
    );
  }

  String _generate_url(int counter){
    String url = "http://alchemyzons.com/images/funny_image/$counter"+"_resized.jpg";
    return url;
  }
}

void _onCardTapped(int indexm, BuildContext context){
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => DetailPage())
        );
}

void _onAddBtnClicked(BuildContext context){
  Navigator.push(
    context,
    new MaterialPageRoute(builder: (context) => SecondScreen())
    );
}
