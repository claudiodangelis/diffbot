library article_test;

import 'package:diffbot/diffbot_console.dart';
import 'package:unittest/unittest.dart';

final List<String> articles = [
  "https://www.dartlang.org/articles/dart-unit-tests",
  "http://techcrunch.com/2013/06/19/googles-dart-sdk-and-editor-hit-beta-with-improved-performance-smarter-code-completion-and-more",
  "http://www.claudiodangelis.com/2013/how-i-shutdown-my-raspberrypi",
  "http://www.nytimes.com/2013/10/13/opinion/sunday/londons-great-exodus.html"
  ];

main(client) {
  test('Article API', () {
    client.getArticle(articles[0],tags:true,timeout:50000).then(expectAsync1((Article article){
      expect(true, article.title == "Unit Testing with Dart");
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
      expect(true, article.date.day == 12);
      expect(true, article.date.month == 10);
      expect(true, article.date.year == 2013);
    }));
  });
}