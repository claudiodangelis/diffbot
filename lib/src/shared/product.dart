library product;

class Product {
  final Map<String, dynamic> _data;
  
  Product(this._data);
  
  /// URL submitted. Returned by default
  String get url => _data["url"];
  
  /// Returned if the resolving URL is different from the submitted URL (e.g.,
  /// link shortening services). Returned by default.
  String get resolved_url => _data["resolved_url"];
  
  /// Returns the full contents of page meta tags, including sub-arrays for
  /// OpenGraph tags, Twitter Card metadata, schema.org microdata, and -- if
  /// available -- oEmbed metadata. Returned with fields.
  get meta => _data["meta"];
  
  /// If available, an array of link URLs and link text from page breadcrumbs.
  /// Returned by default.
  String get breadcrumb => _data["breadcrumb"];
  
  List<ProductItem> get products => _data["products"];
}

class ProductItem {
  final Map<String, dynamic> _data;
  
  ProductItem(this._data);
  
  /// Name of the product. Returned by default.
  String get title => _data["title"];
  
  /// Description, if available, of the product. Returned by default.
  String get description => _data["description"];
  
  /// Experimental Brand, if available, of the product. Returned with fields.
  String get brand => _data["brand"];
  
  /// Array of media items (images or videos) of the product. Returned by
  /// default.
  List<ProductMedia> get media => _data["media"];
  
  ///  offer or actual/'final' price of the product. Returned by default.
  String get offerPrice => _data["offerPrice"];
  
  /// Regular or original price of the product, if available. Returned by
  /// default.
  String get regularPrice => _data["regularPrice"];
  
  /// Discount or amount saved, if available. Returned by default.
  String get saveAmount => _data["saveAmount"];
  
  /// Shipping price, if available. Returned by default.
  String get shippingAmount => _data["shippingAmount"];
  
  /// A Diffbot-determined unique product ID. If upc, isbn, mpn or sku are
  /// identified on the page, productId will select from these values in the
  /// above order. Otherwise Diffbot will attempt to derive the best unique
  /// value for the product. Returned by default.
  String get productId => _data["productId"];
  
  /// Universal Product Code (UPC/EAN), if available. Returned by default.
  String get upc => _data["upc"];
  
  /// GTIN prefix code, typically the country of origin as identified by
  /// UPC/ISBN. Returned by default.
  String get prefixCode => _data["prefixCode"];
  
  /// If available, the two-character ISO country code where the product was
  /// produced. Returned by default.
  String get productOrigin => _data["productOrigin"];
  
  /// International Standard Book Number (ISBN), if available. Returned by
  /// default.
  String get isbn => _data["isbn"];
  
  /// Stock Keeping Unit -- store/vendor inventory number -- if available.
  /// Returned with fields.
  String get sku => _data["sku"];
  
  /// Manufacturer's Product Number, if available. Returned with fields.
  String get mpn => _data["mpn"];
  
  String toString() => this.title;
  
}

class ProductMedia {
  final Map<String, dynamic> _data;
  ProductMedia(this._data);
  
  /// Type of media identified (image or video).
  String get type => _data["type"];
  
  /// Direct (fully resolved) link to image or video content.
  String get link => _data["link"];
  
  /// Image height, in pixels.
  String get heigth => _data["heigth"];
  
  /// Image width, in pixels.
  String get width => _data["width"];
  
  /// Diffbot-determined best caption for the image.
  String get caption => _data["caption"];
  
  /// Only images. Returns "True" if image is identified as primary in terms of
  /// size or positioning.
  //TODO: Replace String with bool
  String get primary => _data["primary"];
  
  /// Full document Xpath to the media item.
  String get xpath => _data["xpath"];
}