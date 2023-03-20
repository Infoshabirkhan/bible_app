import 'package:bible_app/Models/Repo/chapter_task_repo.dart';
import 'package:bible_app/Models/models/chapter_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'chapter_state.dart';

class ChapterCubit extends Cubit<ChapterState> {
  ChapterCubit() : super(ChapterInitial());


  getChapter()async{

    emit(ChapterLoading());


    var response = await ChapterTaskRepo.getChapter();

    if(response ){
      emit(ChapterLoaded(model: ChapterModel.model));
    }else{
      emit(ChapterError());
    }
  }


  setChapter({required bool value})async{

    emit(ChapterLoading());

    var response = await ChapterTaskRepo.setChapter(isIncrement: value);



    emit(ChapterLoaded(model: ChapterModel.model));

  }
}
