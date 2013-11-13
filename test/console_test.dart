import 'package:diffbot/diffbot_console.dart';
import 'package:unittest/unittest.dart';

final String token = '7bcff9646ab24ac43267113204379e22';
final List<String> articles = [
  "https://www.dartlang.org/articles/dart-unit-tests",
  "http://techcrunch.com/2013/06/19/googles-dart-sdk-and-editor-hit-beta-with-improved-performance-smarter-code-completion-and-more",
  "http://www.claudiodangelis.com/2013/how-i-shutdown-my-raspberrypi",
  "http://www.nytimes.com/2013/10/13/opinion/sunday/londons-great-exodus.html"
  ];

final List<String> frontpages = [
  'http://news.ycombinator.com'
  ];

final List<String> products = [
  'http://www.amazon.com/Yamaha-S90XS-Synthesizer-Balanced-Hammer-Weighted/dp/B002NCW7G8',
  'http://www.overstock.com/Home-Garden/iRobot-650-Roomba-Vacuuming-Robot/7886009/product.html'
  ];

var client = new Client(token);

class SlowerConfiguration extends SimpleConfiguration {
  Duration timeout = const Duration(seconds: 300);
}

void main() {
  unittestConfiguration = new SlowerConfiguration();
  test('Article API', () {
    client.getArticle(articles[0],tags:true,timeout:50000).then(expectAsync1((Article article){
      expect(true, article.title == "Unit Testing with Dart");
      expect(true, article.tags.contains("Software testing"));
    }));
    
    client.getArticle(articles[1],timeout:50000).then(expectAsync1((Article article){
      expect(true, article.title == "Google’s Dart SDK and Editor Hit Beta With Improved Performance, Smarter Code Completion And More");
      expect(true, article.author == "Frederic Lardinois");
    }));
    
    client.getArticle(articles[2],timeout:50000).then(expectAsync1((Article article) {
      expect(true, article.title == "How I shutdown my Raspberry Pi");
    }));
    
    client.getArticle(articles[3],timeout:50000).then(expectAsync1((Article article) {
      expect(true, article.author == 'MICHAEL GOLDFARB');
      expect(true, article.date.toString() == '2013-10-12 08:00:00.000');
    }));
  });

  test('Frontpage API', () {
    client.getFrontpage(frontpages[0],timeout:50000).then(expectAsync1((Frontpage fp) {
      expect(true, fp.title == 'Hacker News');
    }));
  });
  
  test('Product API', () {
    client.getProduct(products[0],timeout:50000).then(expectAsync1((Product prod) {
      expect(true, prod.products[0].title == 'Yamaha S90XS Synthesizer, 88-Note Balanced Hammer-Weighted Action');
      expect(true, prod.products[0].offerPrice == '\$2,399.99');
    }));
    
    client.getProduct(products[1],timeout:50000).then(expectAsync1((Product prod) {
      expect(true, prod.products[0].title == 'iRobot 650 Roomba Vacuuming Robot');
      expect(true, prod.products[0].offerPrice == '\$399.99');
      expect(true, prod.products[0].productId == '15268099');
      expect(true, prod.products[0].media[0].link == 'http://ak1.ostkcdn.com/images/products/7886009/iRobot-650-Roomba-Vacuuming-Robot-cc8883ce-f6a0-44a7-836b-b55b4f9ce1ef_320.jpg');
    }));
  });
}