import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'detail_note_state.dart';

class DetailNoteCubit extends Cubit<DetailNoteState> {
  DetailNoteCubit() : super(DetailNoteInitial());
}
