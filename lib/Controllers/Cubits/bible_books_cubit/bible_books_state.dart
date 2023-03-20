part of 'bible_books_cubit.dart';

@immutable
abstract class BibleBooksState {}

class BibleBooksInitial extends BibleBooksState {}
class BibleBooksLoading extends BibleBooksState {}
class BibleBooksLoaded extends BibleBooksState {
  final List<BibleBooksModel> model;

  BibleBooksLoaded({required this.model});
}
class BibleBooksError extends BibleBooksState {}
