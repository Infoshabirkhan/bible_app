part of 'chapter_cubit.dart';

@immutable
abstract class ChapterState {}

class ChapterInitial extends ChapterState {}
class ChapterNoInternet extends ChapterState {}
class ChapterLoading extends ChapterState {}
class ChapterLoaded extends ChapterState {
  final ChapterModel model;

  ChapterLoaded({required this.model});
}
class ChapterError extends ChapterState {}
