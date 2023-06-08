import 'dart:async';

import 'package:bible_app/Models/Repo/add_new_book_repo.dart';
import 'package:bible_app/Models/Repo/user_book_repo.dart';
import 'package:bible_app/Models/models/book_model.dart';
import 'package:bible_app/Models/models/chapter_model.dart';
import 'package:bible_app/Models/models/task_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'add_new_book_state.dart';

class AddNewBookCubit extends Cubit<AddNewBookState> {
  AddNewBookCubit() : super(AddNewBookInitial());

  StreamSubscription? firebaseStream;
  addBook()async{

    emit(AddNewBookLoading());
    try {
      var response = await UserBookRepo.addNewBook();
      if(response == true){
        emit(AddNewBookDone());
      }else{
        emit(AddNewBookError(error:  'Something went wrong'));
      }
    } on FirebaseException catch (e) {
      emit(AddNewBookError(error:  e.message?? e.code));

      // TODO
    }
  }


  getBook()async{


    emit(AddNewBookLoading());
    try {
      Stream<List<ChapterModel>>? response = await AddNewBookRepo.getBooks();

      if(response != null){

        firebaseStream = response.listen((data) {

          if(data.isNotEmpty){
            for(var item in data){
              print(item.documentId);
            }
            emit(AddNewBookLoaded(list: data));
          }else{
            emit(AddNewBookLoaded(list: []));

          }

        });
      }


    } on FirebaseException catch (e) {
      emit(AddNewBookError(error: e.message?? e.code));

      // TODO
    }
  }


//  getBook()async{
//
//
//     emit(AddNewBookLoading());
//     try {
//       var response = await AddNewBookRepo.getBooks();
//
//       if(response != null){
//         emit(AddNewBookLoaded(list: response));
//       }else{
//         emit(AddNewBookError(error: 'Something went wrong'));
//       }
//     } on FirebaseException catch (e) {
//       emit(AddNewBookError(error: e.message?? e.code));
//
//       // TODO
//     }
//   }

}
