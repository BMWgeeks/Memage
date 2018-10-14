import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:flutter/scheduler.dart';

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

  bool navigation = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    animationController = AnimationController(
        duration: Duration(milliseconds: 2000), 
        vsync: this
        );

         print(" this ");
    animationController.addStatusListener((status)
      {
        if(status == AnimationStatus.completed)
        {
          navigation = true;
          print(" this is happending navigation ");
           Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) => LandingPage())
            );
        }




      });

    _animeController = AnimationController(
      duration: Duration( milliseconds: 3000), 
      vsync: this
      );
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
              child: AnimationThing(
                controller: animationController,
                scrollCon: new ScrollController(),

              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AnimationThing extends StatelessWidget {



  AnimationThing({Key key, this.controller , this.scrollCon})
      : opacity = Tween<double>(
        begin: 0.0, 
        end: 1.0)
      .animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.0,
              0.2,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        rotate = Tween<double>(
          begin: 40.0, 
          end: 500.0)
          .animate(CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.1,
              0.9,
              curve: Curves.fastOutSlowIn,
            ))),
        movement = EdgeInsetsTween(
          begin: EdgeInsets.only(
            bottom: 0.0, 
            left: 0.0, 
            right: 10.0 , 
            top : 100.0 ),
          end: EdgeInsets.only(
            bottom: 0.0, 
            left: 5.0 , 
            top : 200.0, 
            right: 200.0),
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
        width = Tween<double>(begin: 40.0, end: 500.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.1,
              0.5,
              curve: Curves.easeOut,
            ),
          ),
        ),
        height = Tween<double>(begin: 40.0, end: 500.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.5,
              0.6,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        radius = BorderRadiusTween(
          begin: BorderRadius.circular(0.0),
          end: BorderRadius.circular(100.0),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.9,
              1.0,
              curve: Curves.ease,
            ),
          ),
        ),
        color = ColorTween(begin: Colors.red[100], end: Colors.deepPurple[300])
            .animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 1.0, curve: Curves.elasticInOut),
          ),
        ),
        super(key: key);

  final Animation<double> controller;
  final Animation<double> opacity;
  final Animation<double> width;
  final Animation<double> height;
  final Animation<EdgeInsets> movement;

  final Animation<BorderRadius> radius;
  final Animation<Color> color;
  final Animation<double> rotate;

  final ScrollController scrollCon;
  
 

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnimatedBuilder ( 
      animation : controller, 
      builder : (BuildContext context , Widget child)
      {
          _startScrollAnime(9*rotate.value);
            return Container(
              alignment: Alignment.center,
              //transform:  Matrix4.identity()..rotateZ(rotate.value),
              child: Opacity(
                 
                opacity: opacity.value,
                child: ListView(
                  
                  scrollDirection: Axis.horizontal,
                  controller: scrollCon,
                  children:  new List<Widget>.generate(10, (index) {

                 
            return new GridTile(
              
              child: new Card(
                  
//                child: Image.network("image.url"),
                child: Image.network(generate_url(index) , width: width.value, height: height.value),
              
              
              ),
            );
          }),
          )
          )
           );
           }
    );
  }


  
  void _goToElement(double index){
    scrollCon.animateTo(((index)), // 100 is the height of container and index of 6th element is 5
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeOut);
  }


   Future _startScrollAnime(double index) async {
    try {
      await _goToElement(index);
      
    
    } on TickerCanceled {
      print(" error with auto scroll animation");
    }
  }

  String generate_url(int counter){
    String url = "http://alchemyzons.com/images/funny_image/$counter"+"_resized.jpg";
    return url;
  }
}

  // Container(
  //     //  padding: movement.value,
  //       //transform: Matrix4.identity()..rotateZ(rotate.value),
  //       alignment: Alignment.center,
  //       child: Opacity(
  //           opacity: opacity.value,
  //           child: Container(
  //             child:Image.network("http://alchemyzons.com/images/funny_image/1"+"_resized.jpg", fit: BoxFit.cover,),
  //             width: width.value,
  //             height: height.value,
  //             decoration: BoxDecoration(
  //               color: color.value,
  //               border: Border.all(
  //                 color: Colors.deepPurple[300],
  //                 width: 2.0,
        
  //               ),
  //             borderRadius: radius.value,
  //             ),
  //           )
  //         )
  //         ),