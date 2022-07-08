import 'package:book_list/book.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class BookService extends ChangeNotifier {
  int totalItems = 0;
  List<Book> bookList = [];

  void getBookList(String search) async {
    bookList = [];
    String url = "https://www.googleapis.com/books/v1/volumes?q=$search";
    Response result = await Dio().get(url);

    var data = result.data;
    totalItems = data["totalItems"];

    var itemsList = data["items"];
    var itemsMap = {};

    for (var i = 0; i < itemsList.length; i++) {
      itemsMap = itemsList[i];
      // print(itemsMap["volumeInfo"]["imageLinks"]);

      Book book = Book(
        itemsMap["volumeInfo"]["title"],
        itemsMap["volumeInfo"]["description"],
        itemsMap["volumeInfo"]["imageLinks"] != null
            ? itemsMap["volumeInfo"]["imageLinks"]["smallThumbnail"]
            : "https://i.ibb.co/2ypYwdr/no-photo.png",
        itemsMap["volumeInfo"]["imageLinks"] != null
            ? itemsMap["volumeInfo"]["imageLinks"]["thumbnail"]
            : "https://i.ibb.co/2ypYwdr/no-photo.png",
      );
      bookList.add(book);
    }
    notifyListeners();
  }
}
