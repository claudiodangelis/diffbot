library frontpage;

class Frontpage {
  final Map _data;
  Frontpage(this._data);
  
  /// DMLID of the URL
  int get id => _data["id"];
  
  /// Extracted title of the page
  String get title => _data["title"];
  
  /// The type of the source
  String get sourceType => _data["sourceType"];
  
  /// the URL this was extracted from
  String get sourceURL => _data["sourceURL"];
  
  /// A link to a small icon/favicon representing the page
  String get icon => _data["icon"];
  
  /// The number of items in this DML document
  int get numItems => _data["numItems"];
  
  /// The number of spam items
  int get numSpamItems => _data["numSpamItems"];
  
  /// Frontpage items
  List<FpItem> get items => _data["items"];
}

// Frontpage item
class FpItem {
  final Map _item;
  FpItem(this._item);
  
  /// Unique hashcode/id of item
  int get id => _item["id"];
  
  /// Title of item
  String get title => _item["title"];
  
  /// innerHTML content of item
  String get description => _item["description"];
  
  /// XPATH of where item was found on the page
  String get xroot => _item["xroot"];
  
  /// Timestamp when item was detected on page
  DateTime get pubDate => _item["pubDate"];
  
  /// Extracted permalink (if applicable) of item
  String get link => _item["link"];
  
  /// Extracted type of the item, whether the item represents an image,
  /// permalink, story (image+summary), or html chunk.
  String get type => _item["type"];
  
  /// Extracted image from item
  String get img => _item["img"];
  
  /// A plain-text summary of the item
  String get textSummary => _item["textSummary"];
  
  /// Spam score - the probability that the item is spam/ad
  double get sp => _item["sp"];
  
  /// Static rank - the quality score of the item on a 1 to 5 scale
  double get sr => _item["sr"];
  
  /// Fresh score - the percentage of the item that has changed compared to the
  /// previous crawl
  double get fresh => _item["fresh"];
}