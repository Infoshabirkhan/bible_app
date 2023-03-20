part of 'bible_task_cubit.dart';

@immutable
abstract class BibleTaskState {}

class BibleTaskInitial extends BibleTaskState {}
class BibleTaskLoading extends BibleTaskState {}
class BibleTaskAddingEntry extends BibleTaskState {}
class BibleTaskDataAdded extends BibleTaskState {}
class BibleTaskLoaded extends BibleTaskState {

  final List<TaskModel> model;

  BibleTaskLoaded({required this.model});
}
class BibleTaskError extends BibleTaskState {}
