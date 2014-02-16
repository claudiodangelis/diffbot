library frontpage_test;

import 'package:diffbot/diffbot_console.dart';
import 'package:unittest/unittest.dart';

final List<String> frontpages = [
  'http://news.ycombinator.com'
  ];

main(client) {
  test('Frontpage API', () {
    client.getFrontpage(frontpages[0],timeout:50000).then(expectAsync1((Frontpage fp) {
      expect(true, fp.title == 'Hacker News');
      expect(true, fp.numItems <= 30);
    }));
  });
}