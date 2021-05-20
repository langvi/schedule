part of 'note_cubit.dart';

@immutable
abstract class NoteState {}

class NoteInitial extends NoteState {}

class SaveNoteSuccess extends NoteState {}

class Error extends NoteState {}
