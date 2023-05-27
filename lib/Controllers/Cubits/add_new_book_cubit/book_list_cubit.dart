import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';


class BookListCubit extends Cubit<List<TextEditingController>> {
  BookListCubit(super.initialState);

  getLength({required List<TextEditingController> index}){
    List<TextEditingController> list = List.from(index);
    emit(list);
  }
}
