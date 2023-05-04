import 'package:bible_app/Models/Repo/bible_task_repo.dart';
import 'package:bible_app/Models/shared_pref.dart';
import 'package:bloc/bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';

import '../../../Models/models/task_model.dart';
import '../../../Models/utils/internet_connectivity.dart';

part 'bible_task_state.dart';

class BibleTaskCubit extends Cubit<BibleTaskState> {
  BibleTaskCubit() : super(BibleTaskInitial());



  getTaskInfo({bool? isSortAscending = false})async{


    emit(BibleTaskLoading());

    // if(await InternetConnectivity.isNotConnected()){
    //
    //   await Future.delayed(const Duration(seconds: 1));
    //
    //   emit(BibleTaskNoInternet());
    //
    //
    //   return;
    // }





  var book =   await SharedPrefs.getDefaultBook();

  print('=============== ${book!.bookId},${book.bookName}  ');
    List<TaskModel>? list = [];
  if(book!.bookId =='bible'){
      list = await BibleTaskRepo.getTask(isSortAscending: isSortAscending);

  }else{
     TaskModel data = await BibleTaskRepo.getNewBooks();

     list.add(data);
  }



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
