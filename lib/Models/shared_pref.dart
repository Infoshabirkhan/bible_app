

import 'package:bible_app/Models/models/default_book_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? prefs;

  static setDefaultBook(DefaultBookModel defaultBookModel)async{
    prefs=await SharedPreferences.getInstance();
    await prefs?.setString("default_book", defaultBookModelToJson(defaultBookModel));
  }

  static Future<DefaultBookModel?> getDefaultBook()async{
    prefs=await SharedPreferences.getInstance();
    String book=prefs?.getString("default_book")??"";
    if(book.isNotEmpty){
      return defaultBookModelFromJson(book);
    }
    else{
      return null;
    }
  }
}