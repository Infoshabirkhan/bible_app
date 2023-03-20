import 'package:bible_app/Models/Repo/bible_task_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../Models/models/task_model.dart';

part 'bible_task_state.dart';

class BibleTaskCubit extends Cubit<BibleTaskState> {
  BibleTaskCubit() : super(BibleTaskInitial());



  getTaskInfo()async{


    emit(BibleTaskLoading());

    var list = await BibleTaskRepo.getTask();


    if(list !=null){
      emit(BibleTaskLoaded(model:  list));
      }


  }


  addNew({required TaskModel model}) async {
    emit(BibleTaskAddingEntry());

await     BibleTaskRepo.addNew(model: model);
emit(BibleTaskDataAdded());

  }


  update({required TaskModel model}) async {
    emit(BibleTaskLoading());

    await     BibleTaskRepo.update(model: model);

    emit( BibleTaskDataAdded());

  }
}
