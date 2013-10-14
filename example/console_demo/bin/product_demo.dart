import 'package:diffbot/diffbot_console.dart';

void main() {
  Client client = new Client("7bcff9646ab24ac43267113204379e22");
  client.getProduct("http://www.amazon.com/Yamaha-S90XS-Synthesizer-Balanced-Hammer-Weighted/dp/B002NCW7G8")
  .then((Product prod){
    prod.products.forEach((v){
      print(v.title);
      print(v.offerPrice);
    });
    print(prod.url);
  }, onError: (ClientException e){
    print(e.toString());
  });
}