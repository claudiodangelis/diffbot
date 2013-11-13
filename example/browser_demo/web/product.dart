import 'dart:html';
import 'package:diffbot/diffbot_browser.dart';

ParagraphElement title = querySelector('#title');
ParagraphElement price = querySelector('#price');
ParagraphElement url = querySelector('#url');
DivElement images = querySelector('#images');
InputElement input = querySelector('#input');
ButtonElement btn = querySelector('#btn');
ImageElement loading = querySelector('#loading');

void main() {
  loading.src = 'ajax-loader.gif';
  Client client = new Client("7bcff9646ab24ac43267113204379e22");
  client.getProduct("http://www.amazon.com/Yamaha-S90XS-Synthesizer-Balanced-Hammer-Weighted/dp/B002NCW7G8")
  .then((Product prod) {
    displayResults(prod);
  });

  AnchorElement try1 = querySelector('#try1');
  try1.onClick.listen((e) {
    loading.src = 'ajax-loader.gif';
    client.getProduct(try1.text).then((Product prod) {
      displayResults(prod);
    });
  });
  
  AnchorElement try2 = querySelector('#try2');
  try2.onClick.listen((e) {
    loading.src = 'ajax-loader.gif';
    client.getProduct(try2.text).then((Product prod) {
      displayResults(prod);
    });
  });
  
  
  btn.onClick.listen((e) {
    if(input.value != "") {
      loading.src = 'ajax-loader.gif';
      client.getProduct(input.value).then((Product prod) {
        displayResults(prod);
      });
    }
  });
}


void displayResults(Product prod) {
  images.children.clear();
  loading.src='';
  url.text = prod.url;
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
}