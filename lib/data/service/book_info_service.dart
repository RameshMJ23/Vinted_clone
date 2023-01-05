import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as Http;
import 'package:vintedclone/data/model/book_info_model.dart';

class BookInfoService{

  static Future<BookInfoModel?> getBookInfo(String isbNumber) async{

     final String bookInfoUrl = "https://openlibrary.org/api/books?bibkeys=ISBN:$isbNumber&jscmd=details&format=json";

     try{

       Http.Response response = await Http.get(
         Uri.parse(bookInfoUrl)
       );

       if(response.statusCode == 200){
          var responseJson = jsonDecode(response.body);

          var detailsArray = responseJson["ISBN:$isbNumber"]['details'];

          String bookTitle = detailsArray['title'];

          var authorName = (detailsArray['authors'] as List).first["name"];

          log("===============From bookInfo service $authorName $bookTitle");
          return BookInfoModel(authorName: authorName, bookName: bookTitle);
       }else{
         return null;
       }
     }catch(e){
        log(e.toString());
        return null;
     }
  }
}