part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class DeleteSuccess extends HomeState {
  final int indexRemove;

  DeleteSuccess(this.indexRemove);
}

class GetNotesSuccess extends HomeState {
  final TypeLoad typeLoad;
  final List<Note> notes;

  GetNotesSuccess(this.notes, this.typeLoad);
}

class Error extends HomeState {}
