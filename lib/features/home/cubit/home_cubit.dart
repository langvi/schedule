import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:thoikhoabieu/database/note.dart';
import 'package:thoikhoabieu/utils/type_load.dart';

import '../../../main.dart';

part 'home_state.dart';

const int PAGE_SIZE = 15;

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  int pageSize = PAGE_SIZE;
  int pageIndex = 0;
  void getNotes({TypeLoad typeLoad = TypeLoad.first}) async {
    var records = await databaseApp.queryRecordByPage(pageIndex, pageSize);
    List<Note> notes = List<Note>.generate(records.length, (index) {
      return Note.fromMap(records[index]);
    });
    print('get data success...');
    emit(GetNotesSuccess(notes, typeLoad));
  }

  void removeNote(int id, int index) async {
    print('start delete');
    await databaseApp.delete(id);
    emit(DeleteSuccess(index));
    print('delete succeess');
  }

  Stream<List<Note>> getSuggestNote(String keyword) async* {
    if (keyword.isEmpty) {
      yield [];
    } else {
      var data = await databaseApp.queryByString(keyword);
      if (data.isNotEmpty) {
        List<Note> result = List<Note>.generate(
            data.length, (index) => Note.fromMap(data[index]));
        yield result;
      } else {
        yield [];
      }
    }
  }
}
