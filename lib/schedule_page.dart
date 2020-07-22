import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thoikhoabieu/bloc/schedule_bloc.dart';
import 'package:thoikhoabieu/schedule_detail.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:thoikhoabieu/test_db.dart';

import 'add_schedule_page.dart';
import 'base/colors.dart';
import 'event_note.dart';

class Schedule extends StatefulWidget {
  Schedule({Key key}) : super(key: key);

  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> with TickerProviderStateMixin {
  Map<DateTime, List> _events;
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;
  LichHoc lich;
  String homNay;
  String dayOfWeek;
  String name = '';
  ScheduleBloc bloc;
  final dbHelper = DatabaseHelper.instance;
  @override
  void initState() {
    super.initState();
    // bloc = BlocProvider.of<ScheduleBloc>(context);
    bloc = ScheduleBloc(dbHelper);
    bloc.add(LoadData());
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    homNay = formatter.format(now);
    final _selectedDay = DateTime.now();
    dayOfWeek = convertToVN(now);
    // _query(1);
    lich = LichHoc(timeHour: '', type: 'd');
    _events = {
      _selectedDay.subtract(Duration(days: 30)): [
        'Event A0',
        'Event B0',
        'Event C0'
      ],
      _selectedDay.subtract(Duration(days: 27)): ['Event A1'],
    };
    _selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: AppColors.colorAppBar,
          title: Text('Ghi chú'),
        ),
        body: BlocProvider<ScheduleBloc>(
            create: (context) => bloc,
            child: BlocConsumer<ScheduleBloc, ScheduleState>(
                listener: (context, state) {
              if (state is ScheduleLoadDing) {
                print('loading');
              }
              if (state is ScheduleSuccess) {
                lich = state.lichHoc;
              }
            }, builder: (context, state) {
              return Column(
                children: <Widget>[
                  // _buildTitle(homNay),
                  // _buildSchedule(lich),
                  _buildCalendar(),

                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddSchedule()),
                      );
                    },
                    color: Colors.blue,
                    iconSize: 30,
                  ),
                  _buildEvent()
                ],
              );
            })));
  }

  Widget _buildTitle(String dateNow) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Thời khóa biểu',
            style: TextStyle(
                fontSize: 20,
                color: Colors.green,
                fontWeight: FontWeight.bold)),
        Text(dayOfWeek),
        Text(dateNow)
      ],
    );
  }

  Widget _buildSchedule(LichHoc lichHoc) {
    return Column(
      children: <Widget>[
        Text(lichHoc.timeHour),
        Text(lichHoc.type + ': Đại số')
      ],
    );
  }

  Widget _buildCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      events: _events,
      locale: 'vi_VN',
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
        selectedColor: Colors.deepOrange[400],
        todayColor: Colors.deepOrange[200],
        markersColor: Colors.brown[700],
        outsideDaysVisible: false,
      ),

      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        formatButtonTextStyle:
            TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: Colors.deepOrange[400],
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      onDaySelected: _onDaySelected,

      // onVisibleDaysChanged: _onVisibleDaysChanged,
      // onCalendarCreated: _onCalendarCreated,
    );
  }

  Widget _buildEvent() {
    String content =
        'The more humble you act, the further away some happiness will be from you';
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: EdgeInsets.all(10.0),
        height: 120,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), 
          ),
        ], borderRadius: BorderRadius.circular(20.0), color: Colors.green[200]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Title',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Text(content),
            Text('20/12/2022')
          ],
        ),
      ),
    );
  }

  void _onDaySelected(DateTime day, List events) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    setState(() {
      dayOfWeek = convertToVN(day);
      homNay = formatter.format(day);
      _selectedEvents = events;
    });
  }

  String convertToVN(DateTime day) {
    DateFormat dayOfWeek = DateFormat('EEEE');
    String dayVN = dayOfWeek.format(day);
    switch (dayVN) {
      case 'Monday':
        return 'Thứ hai';
      case 'Tuesday':
        return 'Thứ ba';
      case 'Wednesday':
        return 'Thứ tư';
      case 'Thursday':
        return 'Thứ năm';
      case 'Friday':
        return 'Thứ sáu';
      case 'Saturday':
        return 'Thứ bảy';
      case 'Sunday':
        return 'Chủ nhật';
      default:
        return '';
    }
  }

  void _insert(String nameTask, String dateTime, {String note = ''}) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnTask: nameTask,
      DatabaseHelper.columnNote: note,
      DatabaseHelper.columnDateTime: dateTime
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
  }

  void _query(int id) async {
    final allRows = await dbHelper.queryAllRows(id);
    print('query all rows:');
    allRows.forEach((row) {
      name = row.values.toString();
    });
    print(name);
  }

  void _update() async {
    // row to update
    Map<String, dynamic> row = {
      DatabaseHelper.columnId: 1,
      DatabaseHelper.columnTask: 'Mary',
      DatabaseHelper.columnNote: 32
    };
    final rowsAffected = await dbHelper.update(row);
    print('updated $rowsAffected row(s)');
  }

  void _delete() async {
    // Assuming that the number of rows is the id for the last row.
    final id = await dbHelper.queryRowCount();
    final rowsDeleted = await dbHelper.delete(id);
    print('deleted $rowsDeleted row(s): row $id');
  }
  // void _changeName()async{
  //    final db = await dbHelper.renameColumn();
  // }
}
