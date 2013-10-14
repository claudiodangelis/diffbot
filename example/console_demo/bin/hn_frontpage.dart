import 'package:diffbot/diffbot_console.dart';

void main() {
  Client client = new Client("7bcff9646ab24ac43267113204379e22");
  client.getFrontpage("https://news.ycombinator.com/").then((Frontpage fp) {
    print(fp.title);
    print("");
    for(var i=0; i<fp.items.length; i++) {
      print(fp.items[i].title);
      print(fp.items[i].link);
      print("");
    }
  });

}