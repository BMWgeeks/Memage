import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:memage/MemeModel.dart';

/**
 * MemeItemList stores the values received in its constructor for the
 * member variables, which then can be used during its function.
 */
class MemeItemList extends StatelessWidget{

  final List<MemeModel> items;

  MemeItemList({this.items});

  List <Meme> addItem(Meme meme){
    this.items.add(meme);
    return this.items;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
  }
}


class _MemeItemState extends State<MemeItemList>{

  Meme item;

  _MemeItemState(this.item);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Memage"),
        ),
        body: new Container(
          padding: const EdgeInsets.all(8.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              new Expanded(
                child: new ListView(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                children: widget.items.map((Meme meme) {
                  return MemeItemList(meme); // TODO
                }).toList(),
              )),
              ]
              ),
          ),
      );
  }


}