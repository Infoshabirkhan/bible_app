import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


class BottomNavigationCubit extends Cubit<int> {
  BottomNavigationCubit(super.initialState);

  getNext({required index}) =>
    emit(index);

}
