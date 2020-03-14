import 'dart:convert';
import 'package:http/http.dart' as http;
import 'book.dart';

class CalilConnection {
  final String systemId;
  final String _appKey;

  final Duration _pollInterval;

  CalilConnection({String appKey, this.systemId})
      : _appKey = appKey,
        _pollInterval = Duration(seconds: 2);

  void check(Book book) async {
    Map result = await _firstRequest(book.isbn);
    while(result["continue"] == 1) {
      print("retry");
      await Future.delayed(_pollInterval);
      result = await _continueRequest(result["session"]);
    }
    print("finish");
  }

  Future<Map> _firstRequest(String isbn) async {
    return _getResponse('appkey=$_appKey&isbn=$isbn&systemid=$systemId');
  }

  Future<Map> _continueRequest(String session) async {
    return _getResponse('session=$session');
  }

  Future<Map> _getResponse(String query) async {
    http.Response response = await http.get('https://api.calil.jp/check?$query'
                                            '&format=json&callback=no');
    print(response.body);
    return json.decode(response.body);
  }
}