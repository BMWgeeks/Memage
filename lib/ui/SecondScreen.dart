import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:convert';

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyHomePage();
  }
}

void main() => runApp(MyHomePage());

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File _image;
  List<String> images = [];
  bool loading = false;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      // if image is null then user has not selected the image in that case progress bar 
      // won't show up else the image is selected the progress bar will show up
      if (_image != null) {
        loading = true;
      }
      upload(_image, "https://memage.herokuapp.com/upload_image");
    });
  }

  Future getCamImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
      if (_image != null) {
        loading = true;
      }
      upload(_image, "https://memage.herokuapp.com/upload_image");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Memage",
        theme: ThemeData(primarySwatch: Colors.purple),
        home: Scaffold(
          appBar: AppBar(
            title: Text('Memage'),
          ),
          floatingActionButton: Column(
            children: [
              Container(
                margin: EdgeInsets.all(15.0),
                child: FloatingActionButton(
                  onPressed: getImage,
                  tooltip: 'Pick Image from gallery',
                  child: Icon(Icons.photo_album),
                ),
              ),
              Container(
                margin: EdgeInsets.all(15.0),
                child: FloatingActionButton(
                  onPressed: getCamImage,
                  tooltip: 'tak pic from cam',
                  child: Icon(Icons.photo_camera),
                ),
              ),
            ],
             mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
          ),
          body: loading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: images.length,
                  itemBuilder: (context, int index) {
                    return buildImage(images[index]);
                  },
                ),
        ));
  }

  ///the link in which the api is setup is here given
  ///below....
// https://memage.herokuapp.com/upload_image

  upload(File imageFile, var uploadURL) async {
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();

    var uri = Uri.parse(uploadURL);

    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('image', stream, length,
        filename: basename(imageFile.path));
    //contentType: new MediaType('image', 'png'));

    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
      setState(() {
        images.add(value);
        loading = false;
      });
    });
  }

  Widget buildImage(String image) {
    return Container(
      margin: EdgeInsets.all(20.0),
      padding: EdgeInsets.all(20.0),
      child: Image.network(image),
      decoration: BoxDecoration(border: Border.all(color: Colors.deepPurple)),
    );
  }
}
