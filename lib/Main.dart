import 'package:flutter/material.dart';
import 'package:memage/ui/LandigPage.dart';
import 'package:memage/ui/SecondScreen.dart';
import 'package:memage/Model/MemeModel.dart';

void main() => runApp(new MainApp());

class MainApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Memage',
      theme: new ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: new LandingPage(),
    );
  }
}




