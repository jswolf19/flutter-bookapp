import 'dart:convert';
import 'package:http/http.dart' as http;
import 'book.dart';

class GoogleBookConnection {

  Future<List<Book>> requestSearchBooks(String title) async {
    final response = await http.get('https://www.googleapis.com/books/v1/volumes/?q=$title');
    final body = response.body;
    Map result = json.decode(body);
    List items = result["items"];

    List<Book> books = List();
    for(int i = 0; i < items.length; i++) {
      Map item = items[i];
      print(item["volumeInfo"]["title"]);
      try {
        List identifiers = item["volumeInfo"]["industryIdentifiers"];
        books.add(Book(
            title: item["volumeInfo"]["title"],
            imageUrl: item["volumeInfo"]["imageLinks"]["thumbnail"],
            isbn: identifiers.firstWhere((i) => i["type"] == "ISBN_13")["identifier"]
        ));
      } catch(error) {
        print(error);
      }
    }
    return books;
  }
}
