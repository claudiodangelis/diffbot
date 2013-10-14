part of diffbot_console;

class Client extends BaseClient {
  final String token;
  Client(this.token);

  Future<Article> getArticle (String url, {bool meta:false, bool html:false,
    bool dontStripAds:false, int timeout, bool tags:false,bool comments:false,
    bool summary:false}) {

    Map params = {"meta":meta, "html":html, "dontStripAds":dontStripAds,
                  "timeout":timeout, "tags":tags, "comments":comments,
                  "summary":summary};
    String _queryString = getQueryString(params);
    String requestUrl = Uri.encodeFull(articleEndpoint + "?token=" + token +
        "&url=" + url + _queryString);
    
    Map data = {};
    Completer<Article> completer = new Completer();
    new HttpClient().getUrl(Uri.parse(requestUrl))
      .then((HttpClientRequest req) {
        req.headers.add("User-Agent", "Diffbot Dart Client");
        req.close().then((HttpClientResponse resp){
          StringBuffer _responseBuffer = new StringBuffer();
          resp.transform(new Utf8Decoder()).listen((_data) {
            _responseBuffer.write(_data);
          }).onDone((){
            data = JSON.decode(_responseBuffer.toString());
            _responseBuffer.clear();
            // Process date
            if(data["error"] == null) {
              data["date"] = getDate(data["date"]);
              completer.complete(new Article(data));                        
            } else {
              completer.completeError(new ClientException(data["error"]));
            }
          });
        });
      });
    return completer.future;
  }
  
  Future<Frontpage> getFrontpage(String url, {int timeout}) {
    String _queryString = '';
    if(timeout != null) {
      _queryString = '&timeout=' + timeout.toString();
    }
    String requestUrl = Uri.encodeFull(frontpageEndpoint + "?token=" + token +
        "&url=" + url + _queryString + "&format=json");
    
    Map _data = {};
    Map data = {};
    Completer<Frontpage> completer = new Completer();
    new HttpClient().getUrl(Uri.parse(requestUrl))
      .then((HttpClientRequest req) {
        req.headers.add("User-Agent", "Diffbot Dart Client");
        req.close().then((HttpClientResponse resp) {
          StringBuffer _responseBuffer = new StringBuffer();
          resp.transform(new Utf8Decoder()).listen((_incomingData) {
            _responseBuffer.write(_incomingData);
          }).onDone((){
            _data = JSON.decode(_responseBuffer.toString());
            _responseBuffer.clear();
            // Processing frontpage info:
            data["title"] =
                _data["childNodes"][0]["childNodes"][0]["childNodes"][0];
            
            data["sourceType"] =
                _data["childNodes"][0]["childNodes"][1]["childNodes"][0];
            
            data["sourceURL"] =
                _data["childNodes"][0]["childNodes"][2]["childNodes"][0];
            
            data["icon"] =
                _data["childNodes"][0]["childNodes"][3]["childNodes"][0];
            
            data["numItems"] = int.parse(
                _data["childNodes"][0]["childNodes"][4]["childNodes"][0]);
            
            // Processing items:
            // Creating a list: 
            data["items"] = [];
            var _tmpFpItem = {}; // A temporary frontpage item
            
            for(var i = 1; i < _data["childNodes"].length; i++) {
              _tmpFpItem["title"] =
                  _data["childNodes"][i]["childNodes"][0]["childNodes"][0];
              
              _tmpFpItem["link"] =
                  _data["childNodes"][i]["childNodes"][1]["childNodes"][0];
              
              _tmpFpItem["pubDate"] = 
                  getDate(
                      _data["childNodes"][i]["childNodes"][2]["childNodes"][0]);
              
              _tmpFpItem["textSummary"] =
                  _data["childNodes"][i]["childNodes"][3]["childNodes"][0];
              
              try {
                _tmpFpItem["description"] =
                    _data["childNodes"][i]["childNodes"][4]["childNodes"][0];
              
              } catch(e) {
                _tmpFpItem["description"] = null;
              }
              
              _tmpFpItem["id"] = _data["childNodes"][i]["id"];
              _tmpFpItem["sp"] = _data["childNodes"][i]["sp"];
              _tmpFpItem["fresh"] = _data["childNodes"][i]["fresh"];
              _tmpFpItem["sr"] = _data["childNodes"][i]["sr"];
              _tmpFpItem["type"] = _data["childNodes"][i]["type"];
              _tmpFpItem["xroot"] = _data["childNodes"][i]["xroot"];
              
              data["items"].add(new FpItem(_tmpFpItem));
              _tmpFpItem = {};
            }
            
            // Complete:
            completer.complete(new Frontpage(data));
          });
        });
      });
    return completer.future;
  }
  
  Future<Product> getProduct(String url, {int timeout}) {
    String _queryString = '';
    if(timeout != null) {
      _queryString = '&timeout=' + timeout.toString();
    }
    String requestUrl = Uri.encodeFull(productEndpoint + "?token=" + token +
        "&url=" + url + _queryString);
    Map _data = {};
    Map data = {};
    Completer<Product> completer = new Completer();
    new HttpClient().getUrl(Uri.parse(requestUrl))
      .then((HttpClientRequest req) {
        req.headers.add("User-Agent", "Diffbot Dart Client");
        req.close().then((HttpClientResponse resp) {
          StringBuffer _responseBuffer = new StringBuffer();
          resp.transform(new Utf8Decoder()).listen((_incomingData) {
            _responseBuffer.write(_incomingData);
          }).onDone((){
            Map _data = JSON.decode(_responseBuffer.toString());
            if(_data["error"] == null) {
              // Global response
              data["type"] = _data["type"];
              data["url"] = _data["url"];
              data["resovled_url"] = _data["resolved_url"];
              data["breadcrumb"] = _data["breadcrumb"];
              data["products"] = [];
              
              /* 
               * Product response, a note from diffbot documentation:
               * (ref: http://diffbot.com/products/automatic/product)
               * 
               * The Product API returns product details in the products array.
               * Currently extracted data will only be returned from a **single
               * product**. In the future the API will return information from
               * multiple products, if multiple items are available on the same
               * page.
               * 
               * */
              
              Map _prod = {};
              
              _prod["title"] = _data["products"][0]["title"];
              _prod["descrption"] = _data["products"][0]["description"];
              _prod["brand"] = _data["products"][0]["brand"];
              _prod["offerPrice"] = _data["products"][0]["offerPrice"];
              _prod["regularPrice"] = _data["products"][0]["regularPrice"];
              _prod["saveAmount"] = _data["products"][0]["saveAmount"];
              _prod["shippingAmount"] = _data["products"][0]["shippingAmount"];
              _prod["productId"] = _data["products"][0]["productId"];
              _prod["upc"] = _data["products"][0]["upc"];
              _prod["prefixCode"] = _data["products"][0]["prefixCode"];
              _prod["productOrigin"] = _data["products"][0]["productOrigin"];
              _prod["isbn"] = _data["products"][0]["isbn"];
              _prod["sku"] = _data["products"][0]["sku"];
              _prod["mpn"] = _data["products"][0]["mpn"];
              
              // Product media
              List<ProductMedia> _prodMedia = [];
              
              for(var i=0;i<_data["products"][0]["media"].length; i++) {
                _prodMedia.add(
                    new ProductMedia(_data["products"][0]["media"][i]));
              }
              
              _prod["media"] = _prodMedia;
              data["products"].add(new ProductItem(_prod));

              completer.complete(new Product(data));
            } else {
              completer.completeError(new ClientException(_data["error"]));
            }
          });
        });
      });
    return completer.future;
  }
}