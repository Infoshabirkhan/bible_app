import 'package:bible_app/Models/models/default_book_model.dart';
import 'package:bible_app/Models/shared_pref.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


class DefaultBookCubit extends Cubit<DefaultBookModel?> {
  DefaultBookCubit() : super(null);



  getBook()async{
    var data=await SharedPrefs.getDefaultBook();
    emit(data);
  }
}
