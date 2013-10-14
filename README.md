#Diffbot
A Dart client library for **Diffbot** APIs.

_Q: What is diffbot?_  
_A: Diffbot is "a visual learning robot that identifies and extracts the important parts of any web page"_

## Supported APIs:
See [Diffbot documentation](http://diffbot.com/products/automatic/)

- **Article API**: The Article API is used to extract clean article text from news article web pages.
- **Frontpage API**: The Frontpage API takes in a multifaceted “homepage” and returns individual page elements.
- **Product API**: The Product API analyzes a shopping or e-commerce product page and returns information on the product.

## Usage

It works both in the browser and in the console.  
**Browser usage:**

	import 'package:diffbot/diffbot_browser.dart';
	main() {
	  var client = new Client('YOUR_TOKEN');
	  client.getArticle('http://www.aweso.me/blog/post').then((Article article)
	    doSomethingWithMy(article);
	    // you can use article's title, date, author, metadata, etc:
	    // article.title
	    // article.date
	  );
	}
    

**Console usage:**

	import 'package:diffbot/diffbot_console.dart';
	main() {
	  var client = new Client('YOUR_TOKEN');
	  client.getFrontpage('http://yourfavorite.newspaper.com').then((Frontpage fp) {
	    // see documentation
	});
	}

## Status

[![Build Status](https://drone.io/github.com/claudiodangelis/diffbot/status.png)](https://drone.io/github.com/claudiodangelis/diffbot/latest)


## Examples

See `example/` directory.


## Documentation

Documentation can be found at [http://claudiodangelis.com/docs/diffbot](http://claudiodangelis.com/docs/diffbot).

## License

BSD 2-Clause License. See _LICENSE_.

## Authors

- [Claudio d'Angelis](http://claudiodangelis.com/+)
- _You?_

