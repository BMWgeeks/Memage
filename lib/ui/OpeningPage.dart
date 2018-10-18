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
              height: 500.0,
              width: 300.0,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                border: Border.all(
                  color: Colors.blueAccent,
                  style: BorderStyle.solid,
                ),
              ),
              child: AnimationStateful(
                controller: animationController,
                scrollCon: new ScrollController(),
              ),
            ),
          ),
        ),
        backgroundColor: Color.lerp(Colors.white, Colors.deepPurpleAccent, 0.1),
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

class AnimationThing extends State {
  AnimationThing({Key key, this.controller, this.scrollCon})
      : opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.0,
              0.2,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        rotate = Tween<double>(begin: 0.0, end: 300.0).animate(CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.5,
              1.0,
              curve: Curves.fastOutSlowIn,
            ))),
        movement = EdgeInsetsTween(
          begin:
              EdgeInsets.only(bottom: 0.0, left: 0.0, right: 10.0, top: 100.0),
          end:
              EdgeInsets.only(bottom: 0.0, left: 5.0, top: 200.0, right: 200.0),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.1,
              0.9,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        width = Tween<double>(begin: 0.0, end: 300.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.1,
              0.6,
              curve: Curves.easeOut,
            ),
          ),
        ),
        height = Tween<double>(begin: 500.0, end: 500.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.5,
              0.9,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        radius = IntTween(
          begin: 0,
          end: 10,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.6,
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
  final Animation<EdgeInsets> movement;

  final Animation<int> radius;
  final Animation<Color> color;
  final Animation<double> rotate;

  final ScrollController scrollCon;
  final int JokeoftheDay = math.Random().nextInt(9);

  bool start = false;
  bool end = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          _startScrollAnime(JokeoftheDay * rotate.value);
          return Container(
              alignment: Alignment.center,
              //transform:  Matrix4.identity()..rotateZ(rotate.value),
              child: Opacity(
                  opacity: opacity.value,
                  child: Column(children: [
                    ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: 100.0,
                          maxWidth: 400.0,
                        ),
                        
                        child: Container(
                           width: width.value,
                            height: 50.0,
                            child: Card(
                               
                              color: color.value,
                                child: Center( child: 
                                RichText(
                              text: TextSpan(
                                text: 'Joke of the Day ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ))))),
                    Expanded(
                      child: NotificationListener<ScrollStartNotification>(
                          onNotification: (_) => _scrollingStarted(),
                          child: NotificationListener<ScrollEndNotification>(
                            onNotification: (_) => _scrollingEnded(),
                              child: ListView(
                            scrollDirection: Axis.horizontal,
                            controller: scrollCon,
                            //shrinkWrap: true,
                            //reverse: true,
                            padding: EdgeInsets.all(20.0),
                            children: new List<Widget>.generate(10, (index) {
                              return new GridTile(
                                  child: Card(
                                child: Image.network(
                                   generate_url(!end ? math.Random().nextInt(9) : index),
                                  width: 400.0,
                                  height: 500.0,
                                  fit: BoxFit.contain,
                                ),
                              ));
                            }),
                          ))),
                    )
                  ])));
        });
  }

  bool _scrollingStarted() {
    setState(() {
      start = true;
    });
    return false;
  }


  
  bool _scrollingEnded() {
    setState(() {
      end = true;
    });
    return false;
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
