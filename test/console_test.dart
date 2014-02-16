import 'package:diffbot/diffbot_console.dart';
import 'console/product_test.dart' as product_test;
import 'console/frontpage_test.dart' as frontpage_test;
import 'console/article_test.dart' as article_test;

final String token = '7bcff9646ab24ac43267113204379e22';

var client = new Client(token);

void main() {
  article_test.main(client);
  frontpage_test.main(client);
  product_test.main(client);
}