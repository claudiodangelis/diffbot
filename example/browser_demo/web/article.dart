import 'dart:async';
import 'dart:html';
import 'package:diffbot/diffbot_browser.dart';

SpanElement title = query('#title');
SpanElement date = query('#date');
SpanElement author = query('#author');
DivElement content  = query('#content');
InputElement input = query('#input');
ButtonElement btn = query('#btn');
void main() {
  Client client = new Client("7bcff9646ab24ac43267113204379e22");
  client.getArticle("http://techcrunch.com/2013/09/29/generation-touch-will-redraw-consumer-tech/",
  html:true)
  .then((Article article) {
    displayResults(article);
  }, onError:(ClientException e){
    content.text = e.toString();
  });

  btn.onClick.listen((e) {
    if(input.value != "") {
      client.getArticle(input.value,html:true).then((Article article) {
        displayResults(article);
      }, onError:(ClientException e){
        content.text = e.toString();
      });
    }
  });
}

void displayResults(Article article) {
    final NodeValidatorBuilder _validator = new NodeValidatorBuilder.common()
    ..allowElement('a',attributes: ['href'])
    ..allowElement('img', attributes:['src']);
  
    title.text = article.title;
    author.text = article.author;
    date.text = article.date.toString();
    content.setInnerHtml(article.html, validator: _validator);
}