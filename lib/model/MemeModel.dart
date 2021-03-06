import 'package:flutter/widgets.dart';

/**
 * simple data class to store information about a meme.
 */
class MemeModel{

  int id;
  String title;
  String url;

  List<String> tag;
  List<String> quote;

  MemeModel(this.id, this.title, this.url);

  void addQuote(String quote){
    this.quote.add(quote);
  }

  void addTag(String tag){
    this.tag.add(tag);
  }

  MemeModel.fromJson(Map<String, dynamic> parsedJson){
    id = parsedJson['id'];
    title = parsedJson['title'];
    url = parsedJson['url'];
  }

}
