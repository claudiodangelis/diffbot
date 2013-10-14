library utils;

String getQueryString(map) {
  String _queryString = '';
  map.forEach((k,v) {
    //TODO: raise error on non-int values
    // `timeout` is the only non-bool parameter
    if(k == "timeout") {
      if(v != null) {
        _queryString += "&timeout=" + v.toString();
      }
    } else {
      if(v != null && v) {
        _queryString += "&" + k;
      }
    }
  });

  return _queryString;
}

DateTime getDate(String date) {
  // Accepted: 1969-07-20 20:18:00
  // Returned: Wed, 16 May 2012 18:00:00 GMT
  // Indices:     0  1   2    3        4   5
  
  // Check if returned string is in the expected form
  // (diffbot might return relative datetimes, e.g. "posted 1 hour ago")
  RegExp reg = new  RegExp('^(Mon|Tue|Wed|Thu|Fri|Sat|Sun), [0-9]{1,2} '
      '(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) '
      '[0-9]{4} [0-9]{2}:[0-9]{2}:[0-9]{2} GMT\$');

  if (!reg.hasMatch(date)) return null; //TODO: this is a temporary solution
  
  var _months = {"Jan":"1","Feb":"2","Mar":"3","Apr":"4","May":"5","Jun":"6",
                "Jul":"7","Aug":"8","Sep":"9","Oct":"10","Nov":"11","Dec":"12"};
  List<String> _dateParts = date.split(" ");
  
  String _y = _dateParts[3];                               // Year
  String _m = formatNo(int.parse(_months[_dateParts[2]])); // Month
  String _d = formatNo(int.parse(_dateParts[1]));          // Day
  String _t = _dateParts[4];                               // Time
  
  return DateTime.parse(_y + "-" + _m + "-" + _d + " " + _t);
}

String formatNo(int n) => n < 10 ? "0" + n.toString() : n.toString();

String getProductFieldQuery(Map params) {
  String _query = '&fields=products(';
  bool everyFalse = true;
  params.forEach((k,v) {
    if(v) {
      everyFalse = false;
      _query += k + ',';
    }
  });
  if(everyFalse) _query += "*";
  
  _query += ")";
  
  return _query.replaceAll(",)",")");
}