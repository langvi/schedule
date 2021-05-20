part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class GetNotesSuccess extends HomeState {
  final List<Note> notes;

  GetNotesSuccess(this.notes);
}

class Error extends HomeState {}
