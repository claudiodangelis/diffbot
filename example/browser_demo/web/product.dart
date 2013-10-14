import 'dart:html';
import 'package:diffbot/diffbot_browser.dart';

void main() {
  ParagraphElement title = query('#title');
  ParagraphElement price = query('#price');
  ParagraphElement url = query('#url');
  DivElement images = query('#images');
  Client client = new Client("7bcff9646ab24ac43267113204379e22");
  client.getProduct("http://www.amazon.com/Yamaha-S90XS-Synthesizer-Balanced-Hammer-Weighted/dp/B002NCW7G8")
  .then((Product prod) {
    title.text = prod.products[0].title;
    price.text = prod.products[0].offerPrice;
    prod.products[0].media.forEach((ProductMedia prodMedia) {
      if(prodMedia.type == 'image') {
        images.children.add(
            new ImageElement()
            ..src = prodMedia.link
        );
      }
    });
  });
}