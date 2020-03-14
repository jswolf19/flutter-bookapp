import 'package:http/http.dart' as http;
import 'book.dart';

class CalilConnection {
  final String systemId;
  final String _appKey;

  CalilConnection({String appKey, this.systemId}) : _appKey = appKey;

  void check(Book book) async {
    _firstRequest(book.isbn);
  }

  void _firstRequest(String isbn) async {
    final url = 'https://api.calil.jp/check?appkey=$_appKey'
                '&isbn=$isbn&systemid=$systemId&format=json&callback=no';
    final response = await http.get(url);
    print(response.body);
  }
}