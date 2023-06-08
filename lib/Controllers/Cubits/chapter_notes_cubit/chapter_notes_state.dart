part of 'chapter_notes_cubit.dart';

@immutable
abstract class ChapterNotesState {}

class ChapterNotesInitial extends ChapterNotesState {}
class ChapterNotesLoading extends ChapterNotesState {}
class ChapterNotesLoaded extends ChapterNotesState {
  final List<Note> notes;

  ChapterNotesLoaded({required this.notes});
}
class ChapterNotesError extends ChapterNotesState {
  final String error;

  ChapterNotesError({required this.error});
}
