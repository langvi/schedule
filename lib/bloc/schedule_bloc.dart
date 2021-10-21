import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:note_app/old/schedule_detail.dart';
import 'package:note_app/old/test_db.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc(this._helper) : super(ScheduleInitial());
  final DatabaseHelper _helper;
  @override
  Stream<ScheduleState> mapEventToState(
    ScheduleEvent event,
  ) async* {
    if (event is LoadData) {
      yield* _loadData(event);
    }
  }

  Stream<ScheduleState> _loadData(LoadData event) async* {
    yield ScheduleInitial();
    yield ScheduleLoadDing();
    // final allRows = await _helper.queryAllRows(1);
    LichHoc lichHoc = LichHoc(timeHour: '', type: '');
    // allRows.forEach((row) {
    //   row.values.forEach((element) {
    //     print(element);
    //   });
    // });
    yield ScheduleSuccess(lichHoc);
  }
}
