import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:flutter/scheduler.dart';
import 'dart:math' as math;

import '../Main.dart';

class Anime extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AnimeState();
  }
}

class _AnimeState extends State<Anime> with TickerProviderStateMixin {
  AnimationController animationController;
  AnimationController _animeController;
  ScrollController _scrollcontroller = new ScrollController();

  bool navigation = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    animationController = AnimationController(
        duration: Duration(milliseconds: 4000), vsync: this);

    print(" this ");
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        navigation = true;
        print(" this is happending navigation ");
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => LandingPage()));
      }
    });

    _animeController = AnimationController(
        duration: Duration(milliseconds: 4000), vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController?.dispose();
    _animeController?.dispose();

    super.dispose();
  }

  // function to start the animation when you click on it
  Future _startAnime() async {
    try {
      await animationController.forward().orCancel;
    } on TickerCanceled {
      print(" error with animation start");
    }
  }

  Future _startAnime2() async {
    try {
      await _animeController.forward().orCancel;
    } on TickerCanceled {
      print(" error with animation start");
    }
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 3.0;
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Anime'),
          backgroundColor: Colors.deepPurple,
        ),
        body: GestureDetector(
          onTap: () {
            _startAnime();
          },
          child: Center(
            child: Container(
              height: 700.0,
              width: 400.0,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                border: Border.all(
                  color: Colors.purple[300],
                  style: BorderStyle.solid,
                  width: 15.0
                ),
              ),
              child: AnimationStateful(
                controller: animationController,
                scrollCon: new ScrollController(),
              ),
            ),
          ),
        ),
        backgroundColor: Color.lerp(Colors.black, Colors.black, 0.1),
      ),
    );
  }
}

class AnimationStateful extends StatefulWidget {
  Animation controller;
  ScrollController scrollCon;
  AnimationStateful({Key key, this.controller, this.scrollCon});
  @override
  State<StatefulWidget> createState() =>
      AnimationThing(controller: controller, scrollCon: scrollCon);
}

class SinCurve extends Curve
{
  const SinCurve(this.frequency ,{  this.power = 1 } ) :assert(frequency != null);
  final double frequency;
  final int power;

  @override
  double transform( double t)
  {
    return math.pow( math.sin(frequency *t), power);
  }
}
















class AnimationThing extends State {
  AnimationThing({Key key, this.controller, this.scrollCon})
      : opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.0,
              1.0,
              curve: new SinCurve(50.0, power: 2),
            ),
          ),
        ),
        rotate = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.0,
              1.0,
              curve:new SinCurve(100.0, power: 2),
            ))),
        width = Tween<double>(begin: 0.0, end: 300.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.7,
              0.9,
              curve: Curves.easeOut,
            ),
          ),
        ),
        height = Tween<double>(begin: 500.0, end: 500.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.7,
              1.0,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        count = IntTween(
          begin: 0,
          end: 10,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.1,
              1.0,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        color = ColorTween(begin: Colors.red[100], end: Colors.deepPurple[300])
            .animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 1.0, curve: Curves.elasticInOut),
          ),
        );

  final Animation<double> controller;

  
  final Animation<double> opacity;
  final Animation<double> width;
  final Animation<double> height;

  final Animation<int> count;
  final Animation<Color> color;
  final Animation<double> rotate;

  final ScrollController scrollCon;


  

  final String wordings = " Joke of the Day";
  final int JokeoftheDay = math.Random().nextInt(9);

  bool start = false;
  bool end = false;

  @override
  Widget build(BuildContext context) {

    String _wordsToDisplay = wordings.substring(0, count.value);

    // TODO: implement build
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
         
          return Container(
              alignment: Alignment.center,
              //transform:  Matrix4.identity()..rotateZ(rotate.value),
              child: Opacity(
                  opacity: 0.9,
                  child: Column(children: [
                    Opacity(
                      opacity: opacity.value,
                      
                      child:
                    ConstrainedBox(


                      constraints: BoxConstraints(

                        
                          maxHeight: 50.0,
                          maxWidth: 50.0,
                      







                      )
                      ,

                      child:
                      DecoratedBox(
                      


                        decoration: BoxDecoration(

                          color: Colors.purple[50],
                          








                        ),



                        child: 
                        Card (  
                          child: Icon( Icons.star ,
                        color: Colors.yellowAccent, 
                        size: 40.0,)),
                      )









                    )
                    ),







                    ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: 100.0,
                          maxWidth: 400.0,
                        ),
                        
                        child: Container(
                           width: width.value,
                            height: 50.0,
                            child: Card(
                               
                              color: Colors.black87,
                                child: Align( 
                                  alignment: Alignment(0.0, 0.0),
                                  
                                  child: 
                                RichText(
                              text: TextSpan(
                                text:  _wordsToDisplay,
                                style: TextStyle(fontWeight: FontWeight.bold , decorationStyle: TextDecorationStyle.wavy ),
                              ),
                            ))))),

                            Container(
                                child: Transform(
                                alignment: FractionalOffset.center,
                                transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.001)
                                ..rotateY(rotate.value),
                                child: Image.network(

                                  generate_url(count.value),
                                  width: 400.0,
                                  height: 400.0,
                                  fit: BoxFit.contain,
                                )),

                            



                            ),




                 
                  ])));
        });
  }

  

  void _goToElement(double index) {
    scrollCon.animateTo(
        ((index)), // 100 is the height of container and index of 6th element is 5
        duration: const Duration(milliseconds: 100),
        curve: Curves.fastOutSlowIn);
  }

  Future _startScrollAnime(double index) async {
    try {
      await _goToElement(index);
    } on TickerCanceled {
      print(" error with auto scroll animation");
    }
  }

  String generate_url(int counter) {
    String url =
        "http://alchemyzons.com/images/funny_image/$counter" + "_resized.jpg";
    return url;
  }
}
// Image.network(
//                                   !start
//                                       ? "https://i.imgur.com/btkN0x5.png"
//                                       : generate_url(!end ? math.Random().nextInt(9) : index),
//                                   width: 400.0,
//                                   height: 500.0,
//                                   fit: BoxFit.contain,
//                                 ),