part of 'add_new_book_cubit.dart';

@immutable
abstract class AddNewBookState {}

class AddNewBookInitial extends AddNewBookState {}
class AddNewBookLoading extends AddNewBookState {}
class AddNewBookLoaded extends AddNewBookState {
  final List<ChapterModel> list ;

  AddNewBookLoaded({required this.list});
}
class AddNewBookDone extends AddNewBookState {}
class AddNewBookError extends AddNewBookState {
  final String error;

  AddNewBookError({required this.error});
}
