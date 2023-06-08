import 'dart:async';

import 'package:bible_app/Models/Repo/chapter_notes_repo.dart';
import 'package:bible_app/Models/models/task_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'chapter_notes_state.dart';

class ChapterNotesCubit extends Cubit<ChapterNotesState> {
  ChapterNotesCubit() : super(ChapterNotesInitial());


  StreamSubscription? firebaseStream;
  getNotes({required String bookId})async{
    emit(ChapterNotesLoading());


    try {
      var response = await ChapterNotesRepo.getChapterNotes(bookId: bookId);


      if(response !=null){
        firebaseStream = response.listen((event) {

          emit(ChapterNotesLoaded(notes: event.notes));
        });
      }else{
        emit(ChapterNotesError(error: '',),);

      }
    } on Exception catch (e) {
      emit(ChapterNotesError(error: e.toString(),),);
      // TODO
    }

  }
}
