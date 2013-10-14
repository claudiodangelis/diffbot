import 'dart:async';
import 'package:diffbot/diffbot_console.dart';

void main() {
  Client client = new Client("7bcff9646ab24ac43267113204379e22");
  client.getArticle(
      "https://www.dartlang.org/articles/dart-unit-tests/"
      , tags:true, summary:true)
    .then((Article article){
      print(article.title);
      print(article.date);
      print(article.summary);
    }, onError: (ClientException e){
      print(e.toString());
    });
}