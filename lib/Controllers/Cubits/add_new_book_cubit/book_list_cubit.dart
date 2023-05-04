import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


class BookListCubit extends Cubit<int> {
  BookListCubit(super.initialState);

  getLength({required index}){
    emit(index);
  }
}
