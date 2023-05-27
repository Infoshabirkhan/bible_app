import 'dart:async';

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


  StreamSubscription? firebaseStream;

  getTaskInfo({bool? isSortAscending = false})async{
    emit(BibleTaskLoading());
  var book =   await SharedPrefs.getDefaultBook();
    if(book!.bookId =='bible'){
      getDefaultBook(isSortAscending: isSortAscending);
  }else{
      getNewBook(isSortAscending: isSortAscending);
     }
  }



  /// function will get default book
  getDefaultBook({bool? isSortAscending = false})async{
  try {
    Stream<List<TaskModel>>? list = await BibleTaskRepo.getTask(isSortAscending: isSortAscending);
    if(list != null){
      firebaseStream = list.listen((data) {


        if(data.isNotEmpty){
          if(isSortAscending!){
                data.sort((a,b)=> a.totalChapters.compareTo(b.totalChapters));

              }else{
            data.sort((a,b)=> a.id.compareTo(b.id));

              }
          emit(BibleTaskLoaded( model: data));

        }else{
          emit(BibleTaskLoaded( model: []));
        }
      });
    }
  } on Exception catch (e) {
    emit(BibleTaskError());
    // TODO
  }
}

  /// function will only get user added book
  getNewBook({bool? isSortAscending = false})async{
    try {
      Stream<List<TaskModel>>? list  = await BibleTaskRepo.getNewBooks();
      if(list != null){

        print('here is comppig');
        firebaseStream = list.listen((myData) {

          if(isSortAscending!){
            myData.sort((a,b)=> a.totalChapters.compareTo(b.totalChapters));

          }else{
            myData.sort((a,b)=> a.id.compareTo(b.id));

          }
          emit(BibleTaskLoaded(model: myData));
        });
      }else{
        emit(BibleTaskLoaded(model: []));

      }

    } on Exception catch (e) {
      emit(BibleTaskError());
      // TODO
    }






  }

  addNew({required TaskModel model}) async {
 //   emit(BibleTaskAddingEntry());

await     BibleTaskRepo.addNew(model: model);
//emit(BibleTaskDataAdded());

  }


  update({required TaskModel model}) async {
   // emit(BibleTaskLoading());

    await     BibleTaskRepo.update(model: model);

   // emit( BibleTaskDataAdded());

  }
}



//  getTaskInfo({bool? isSortAscending = false})async{
//
//
//     emit(BibleTaskLoading());
//
//     // if(await InternetConnectivity.isNotConnected()){
//     //
//     //   await Future.delayed(const Duration(seconds: 1));
//     //
//     //   emit(BibleTaskNoInternet());
//     //
//     //
//     //   return;
//     // }
//
//
//
//
//
//   var book =   await SharedPrefs.getDefaultBook();
//
//   print('=============== ${book!.bookId},${book.bookName}  ');
//     List<TaskModel>? list = [];
//   if(book.bookId =='bible'){
//       list = await BibleTaskRepo.getTask(isSortAscending: isSortAscending);
//
//   }else{
//      TaskModel data = await BibleTaskRepo.getNewBooks();
//
//      list.add(data);
//   }
//
//
//
//     if(list !=null){
//       emit(BibleTaskLoaded(model:  list));
//       }
//
//
//   }