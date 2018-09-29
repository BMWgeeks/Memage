import 'package:flutter/material.dart';
import 'package:memage/Meme.dart';
import 'package:memage/MemeItemList.dart';

void main() => runApp(new MainApp());

class MainApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Memage',
      home: MemeItemList( items: [
        Meme(author: "Simon", image: Image.asset('dummy_image.jpeg')),
        Meme(author: "Simon", image: Image.asset('dummy_image.jpeg')),
        Meme(author: "Simon", image: Image.asset('dummy_image.jpeg')),
        Meme(author: "Simon", image: Image.asset('dummy_image.jpeg')),
        Meme(author: "Simon", image: Image.asset('dummy_image.jpeg')),
        Meme(author: "Simon", image: Image.asset('dummy_image.jpeg')),
        Meme(author: "Simon", image: Image.asset('dummy_image.jpeg')),
        Meme(author: "Simon", image: Image.asset('dummy_image.jpeg'))
      ]
      ),
    );
  }

}

