import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:thoikhoabieu/database/note.dart';

import '../../../main.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  int pageSize = 10;
  int pageIndex = 0;
  void getNotes() async {
    var records = await databaseApp.queryRecordByPage(pageIndex, pageSize);
    List<Note> notes = List<Note>.generate(records.length, (index) {
      return Note.fromMap(records[index]);
    });
    print('get data success...');
    emit(GetNotesSuccess(notes));
  }
}
