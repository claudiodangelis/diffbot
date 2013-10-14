part of diffbot_browser;

class Client extends BaseClient {
  final String token;
  Client(this.token);

  Future<Article> getArticle (String url, {bool meta:false, bool html:false, 
    bool dontStripAds:false, int timeout, bool tags:false,bool comments:false,
    bool summary:false}) {

    Completer<Article> completer = new Completer();
    Map params = { "meta":meta, "html":html, "dontStripAds":dontStripAds, 
                   "timeout":timeout, "tags":tags, "comments":comments,
                   "summary":summary};

    String _queryString = getQueryString(params);
    String requestUrl = Uri.encodeFull(articleEndpoint + "?token=" + token +
        "&url=" + url + _queryString + "&callback=handler");
    
    js.context["handler"] = new js.Callback.once((js.Proxy _data) {
      Map data = {};

      if(_data["error"] == null) {
        // Builds a Dart native object
        data["text"] = _data["text"];
        data["title"] = _data["title"];
        data["author"] = _data["author"];
        data["url"] = _data["url"];
        data["resovled_url"] = _data["resolved_url"];
        data["icon"] = _data["icon"];
        data["html"] = _data["html"];
        data["summary"] = _data["summary"];
        data["numPages"] = _data["numPages"];

        // Process tags
        if(tags) {
          List<String> _tags = [];
          for(var i = 0; i < _data["tags"].length; i++) {
            _tags.add(_data["tags"][i]);
          }
          data["tags"] = _tags;
        }

        // Process media
        data["media"] = [];
        for(var i = 0; i < _data["media"].length; i++) {
          Map<String, String> _media = {};
          new JsObjectToMapAdapter.fromProxy(_data["media"][i]).forEach((k,v) {
            _media[k.toString()] = v.toString();
          });
          data["media"].add(_media);
        }

        //Process meta
        if(meta) {
          data["meta"] = {};
          Map<String,String> _microdata = {};
          new JsObjectToMapAdapter.fromProxy(_data["meta"]).forEach((k,v) {
            if(k == "microdata") {
              new JsObjectToMapAdapter.fromProxy(v).forEach((k1,v1) {
                _microdata[k1] = v1;
              });
            } else {
              data["meta"][k] = v;
            }
            data["meta"]["microdata"] = _microdata;
          });
        }

        //Process date
        data["date"] = getDate(_data["date"]);
        // returns the article
        completer.complete(new Article(data));
      } else {
        // throws error msg
        completer.completeError(new ClientException(_data["error"]));
      }
    });

    ScriptElement scriptTag = new Element.tag('script');
    scriptTag.src = requestUrl;
    document.body.children.add(scriptTag);
    scriptTag.remove();
    return completer.future;
  }
  
  Future<Frontpage> getFrontpage(String url, {int timeout}) {
    Completer<Frontpage> completer = new Completer();

    String _queryString = '';
    if(timeout != null) {
      _queryString = '&timeout=' + timeout.toString();
    }
    String requestUrl = Uri.encodeFull(frontpageEndpoint + "?token=" + token +
        "&url=" + url + _queryString + "&format=json&callback=handler");
    
    js.context["handler"] = new js.Callback.once((js.Proxy _data) {
      Map data = {}; //Native dart map
      data["title"] = _data["childNodes"][0]["childNodes"][0]["childNodes"][0];
      data["sourceType"] =
          _data["childNodes"][0]["childNodes"][1]["childNodes"][0];
      
      data["sourceURL"] =
          _data["childNodes"][0]["childNodes"][2]["childNodes"][0];
      
      data["icon"] = _data["childNodes"][0]["childNodes"][3]["childNodes"][0];
      data["numItems"] =
          int.parse(_data["childNodes"][0]["childNodes"][4]["childNodes"][0]);

      // initializing empty list for FpItems
      data["items"] = [];
      var _tmpFpItem = {}; // A temporary Frontpage Item
      
      for(var i = 1; i < _data["childNodes"].length; i++) {
        _tmpFpItem["title"] =
            _data["childNodes"][i]["childNodes"][0]["childNodes"][0];
        
        _tmpFpItem["link"] =
            _data["childNodes"][i]["childNodes"][1]["childNodes"][0];
        
        _tmpFpItem["pubDate"] =
            getDate(_data["childNodes"][i]["childNodes"][2]["childNodes"][0]);
        
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
        //TODO: error handling
      }
      completer.complete(new Frontpage(data));
    });
    
    ScriptElement scriptTag = new Element.tag('script');
    scriptTag.src = requestUrl;
    document.body.children.add(scriptTag);
    scriptTag.remove();
    return completer.future;
  }
  
  Future<Product> getProduct(String url, {int timeout}) {
    Completer<Product> completer = new Completer();
    String _queryString = '';
    if(timeout != null) {
      _queryString = '&timeout=' + timeout.toString();
    }
    String requestUrl = Uri.encodeFull(productEndpoint + "?token=" + token +
        "&url=" + url + _queryString + "&callback=handler");
    Map data = {}; //Global
    Map dataProd = {}; // Product
    js.context["handler"] = new js.Callback.once((js.Proxy _data) {
      // Global response
      data.addAll({
        "type":_data["type"], "url":_data["url"],
        "resolved_url":_data["resolved_url"],"breadcrumbs":_data["breadcrumbs"],
        "products":[]
      });
      
      // Product response
      for(var i=0; i<_data["products"].length; i++) {
        // Cycle thru all products
        // Product media
        List<ProductMedia> _prodMediaList = [];
        for(var j=0; j<_data["products"][i]["media"].length; j++) {
          Map _prodMedia = {};
          new JsObjectToMapAdapter.fromProxy(_data["products"][i]["media"][j])
          .forEach((k,v) {
            _prodMedia[k.toString()] = v.toString();
          });
          _prodMediaList.add(new ProductMedia(_prodMedia));
        }
        Map _tmpProd = {
          "title":_data["products"][i]["title"],
          "description":_data["products"][i]["description"],
          "brand":_data["products"][i]["brand"],
          "offerPrice":_data["products"][i]["offerPrice"],
          "regularPrice":_data["products"][i]["regularPrice"],
          "saveAmount":_data["products"][i]["saveAmount"],
          "shippingAmount":_data["products"][i]["shippingAmount"],
          "productId":_data["products"][i]["productId"],
          "upc":_data["products"][i]["upc"],
          "prefixCode":_data["products"][i]["prefixCode"],
          "productOrigin":_data["products"][i]["productOrigin"],
          "isbn":_data["products"][i]["isbn"],
          "sku":_data["products"][i]["sku"],
          "mpn":_data["products"][i]["mpn"],
          "media": _prodMediaList
        };
        data["products"].add(new ProductItem(_tmpProd));
      }
      /* 
       * WARNING: in case of error (e.g. url not found, invalid token, etc.)
       * Diffbot's Product APIs **do not** return any error code nor messages:
       * 
       * {
       *   "type": "product",
       *   "products": [
       *     {
       *       "title": "404 Not Found",
       *       "offerPrice": "404",
       *       "availability": false
       *     }
       *   ],
       *  "url": "http://www.fake-non-existing-url.com"
       * }
       * 
       */
      completer.complete(new Product(data));
    });
    
    ScriptElement scriptTag = new Element.tag('script');
    scriptTag.src = requestUrl;
    document.body.children.add(scriptTag);
    scriptTag.remove();
    return completer.future;
  }
}