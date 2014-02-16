library product_test;

import 'package:unittest/unittest.dart';
import 'package:diffbot/diffbot_console.dart';

final List<String> products_urls = [
  'http://www.amazon.com/Yamaha-S90XS-Synthesizer-Balanced-Hammer-Weighted/dp/B002NCW7G8',
  'http://www.overstock.com/Home-Garden/iRobot-650-Roomba-Vacuuming-Robot/7886009/product.html'
  ];

main(client) {
  test('Product API', () {
    client.getProduct(products_urls[0],timeout:50000).then(expectAsync1((Product prod) {
      expect(true, prod.products.length == 1);
      expect(true, prod.products[0].title == 'Yamaha S90XS Synthesizer; 88-Note Balanced Hammer-Weighted Action');
      expect(true, prod.products[0].offerPrice == '\$2,399.99');
    }));
    client.getProduct(products_urls[1],timeout:50000).then(expectAsync1((Product prod) {
      expect(true, prod.products.length == 1);
      expect(true, prod.products[0].title == 'iRobot 650 Roomba Vacuuming Robot');
      expect(true, prod.products[0].offerPrice == '\$399.99');
      expect(true, prod.products[0].productId == 'iRobot Roomba 650');
      expect(true, prod.products[0].media.length == 5);
      expect(true, prod.products[0].media[0].link == 'http://ak1.ostkcdn.com//images/products/3982939/iTouchless-Automatic-Remote-Control-Robotic-Vacuum-P12013752.jpg');
    }));
  });
}