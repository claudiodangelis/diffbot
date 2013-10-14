//TODO: documentation
library base_client;

import 'dart:async';
import 'article.dart';
import 'frontpage.dart';
import 'product.dart';

abstract class BaseClient {
  String token;
  final String articleEndpoint = "http://www.diffbot.com/api/article";
  final String frontpageEndpoint = "http://www.diffbot.com/api/frontpage";
  final String productEndpoint = "http://api.diffbot.com/v2/product";
   
  /// The Article API is used to extract clean article text from news article
  /// web pages.
  Future<Article> getArticle(String url, {bool meta:false,
    bool html:false, bool dontStripAds:false, int timeout, bool tags:false,
    bool comments:false, bool summary:false});
  
  /// The Frontpage API takes in a multifaceted “homepage” and returns
  /// individual page elements.  
  Future<Frontpage> getFrontpage(String url, {int timeout});
  
  //TODO: `meta`
  //TODO: `fields`
  /// The Product API analyzes a shopping or e-commerce product page and returns
  /// information on the product.
  Future<Product> getProduct(String url, {int timeout});
  
  //TODO: Custom API
  //TODO: Crawlbot API
  //TODO: Batch Requests
}