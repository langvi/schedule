import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:note_app/base/consts.dart';
import 'package:note_app/database/note.dart';

import '../../../main.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(NoteInitial());
  void saveNote(Note note) async {
    try {
      await databaseApp.insert(note.toJson());
      prefs!.setInt(AppConst.keyId, note.id + 1);
      print('Insert success...');
      emit(SaveNoteSuccess());
    } catch (e) {
      print(e);
      emit(Error());
    }
  }

  void updateNote(Note note) async {
    try {
      var result = await databaseApp.update(note);
      print('result = $result');
      print('Update success...');
      emit(SaveNoteSuccess());
    } catch (e) {
      print(e);
      emit(Error());
    }
  }
}
