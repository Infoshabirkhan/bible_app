import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../Models/Repo/bible_book_repo.dart';
import '../../../Models/models/bible_books.dart';

part 'bible_books_state.dart';

class BibleBooksCubit extends Cubit<BibleBooksState> {
  BibleBooksCubit() : super(BibleBooksInitial());

  getBooks() async {

    emit(BibleBooksLoading());

    var data = await BibleBookRepo.getBooks();


    emit(BibleBooksLoaded(model: data));
  }
}
