library article;

class Article {
  final Map<String,dynamic> _data;

  Article(this._data);

  /// Plain-text of the extracted article.
  String get text => _data["text"];

  /// Title of extracted article
  String get title => _data["title"];

  /// Article author
  String get author => _data["author"];

  /// Submitted URL
  String get url => _data["url"];

  /// Returned if the resolving URL is different from the submitted URL (e.g.,
  /// link shortening services)
  String get resolved_url => _data["resolved_url"];

  /// Page favicon
  String get icon => _data["icon"];

  /// HTML of the extracted article (returned in place of [text] if the [html]
  /// parameter is used)
  String get html => _data["html"];

  /// Summary text (returned if summary parameter is used)
  String get summary => _data["summary"];

  /// Article date, normalized in most cases to GMT.
  DateTime get date => _data["date"];

  /// Number of pages automatically concatenated to form the [text] response (By
  /// default, Diffbot will automatically concatenate multiple-page articles)
  int get numPages => _data["numPages"];

  /// Array of media items (images or videos), if detected and extracted
  List<Map<String,dynamic>> get media => _data["media"];

  /// Array of tags (returned if tags parameter is used)
  List<String> get tags => _data["tags"];

  /// If the meta parameter is used, will return an object containing the page's
  /// metatag names and values, if found. Includes nested objects for OpenGraph
  /// (og), Twitter (twitter) and schema.org (microdata) tags.
  Map<String,dynamic> get meta => _data["meta"];
}