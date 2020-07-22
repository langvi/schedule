part of 'schedule_bloc.dart';

@immutable
abstract class ScheduleState {}

class ScheduleInitial extends ScheduleState {}

class ScheduleLoadDing extends ScheduleState {}

class ScheduleSuccess extends ScheduleState {
  final LichHoc lichHoc;

  ScheduleSuccess(this.lichHoc);
}

class ScheduleFailure extends ScheduleState {}
