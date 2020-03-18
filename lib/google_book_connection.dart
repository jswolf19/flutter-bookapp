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
    for(int i = 0; i < (items?.length ?? 0); i++) {
      Map item = items[i];

      List identifiers = item["volumeInfo"]["industryIdentifiers"] ?? List();
      Map identifier = identifiers.firstWhere(
        (i) => i["type"] == "ISBN_13",
        orElse: () => null
      );

      String imageUrl;
      try {
        imageUrl = item["volumeInfo"]["imageLinks"]["thumbnail"];
      } catch(error) {
        print(item);
        print(error);
      }

      if(identifier != null) {
        books.add(Book(
            title: item["volumeInfo"]["title"],
            imageUrl: imageUrl,
            isbn: identifier["identifier"]
        ));
      }
    }
    return books;
  }
}
