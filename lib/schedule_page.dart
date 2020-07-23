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
  var _events;
  List _selectedEvents;
  List<Map<String, dynamic>> listEvents;
  AnimationController _animationController;
  CalendarController _calendarController;
  LichHoc lich;
  String homNay;
  String dayOfWeek;
  String name = '';
  String contentNote = '';
  bool _isShowNote = false;
  ScheduleBloc bloc;
  final _selectedDay = DateTime.now();
  final dbHelper = DatabaseHelper.instance;
  @override
  void initState() {
    super.initState();
    bloc = ScheduleBloc(dbHelper);
    bloc.add(LoadData());
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    homNay = formatter.format(now);
    dayOfWeek = convertToVN(now);
    lich = LichHoc(timeHour: '', type: 'd');
    _setEvent();
    _calendarController = CalendarController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
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
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    // _buildTitle(homNay),
                    // _buildSchedule(lich),
                    _buildCalendar(),
                    _buildButton(),
                    _buildEventList()
                    // _buildEvent(contentNote)
                    // _buildEventList()
                    // RaisedButton(
                    //   onPressed: () {
                    //     dbHelper.queryTest();
                    //     // _update();
                    //     // _query(1);
                    //   },
                    //   child: Text('OK'),
                    // ),
                    // IconButton(
                    //   icon: Icon(Icons.add),
                    //   onPressed: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => AddSchedule()),
                    //     );
                    //   },
                    //   color: Colors.blue,
                    //   iconSize: 30,
                    // ),
                    // _buildEvent()
                  ],
                ),
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
      startingDayOfWeek: StartingDayOfWeek.sunday,
      calendarStyle: CalendarStyle(
        selectedColor: Colors.deepOrange[400],
        todayColor: Colors.deepOrange[200],
        markersColor: Colors.blue,
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
    );
  }

  Widget _buildButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Container(
          padding: EdgeInsets.all(6.0),
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.orange),
          child: IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              listEvents = await dbHelper.queryTest();
              listEvents.forEach((element) {
                element.values.forEach((value) {
                  print(value);
                });
              });
              // print(_selectedEvents.toString());
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => AddSchedule()),
              // );
            },
            color: Colors.white,
          )),
    );
  }

  Widget _buildEvent(String content) {
    return Visibility(
      visible: _isShowNote,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          padding: EdgeInsets.all(10.0),
          height: 100,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.8),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.green[200]),
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
      ),
    );
  }

  Widget _buildEventList() {
    return ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: _selectedEvents.length,
        itemBuilder: (context, index) {
          var title = _selectedEvents[index];
          return ListTile(
            title: _buildEvent(title),
          );
        });
  }

  void _onDaySelected(DateTime day, List events) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    setState(() {
      dayOfWeek = convertToVN(day);
      homNay = formatter.format(day);
      _selectedEvents = events;
      if (_selectedEvents.isNotEmpty) {
        _isShowNote = true;
        contentNote = _selectedEvents.elementAt(0).toString();
      } else {
        _isShowNote = false;
      }
    });
    // print(_selectedEvents.toString());
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

  void _setEvent() async {
    listEvents = await dbHelper.queryTest();
    listEvents.forEach((element) {});
    // String date = '2020-07-24';
    // DateTime dt = DateTime.parse(date);
    // _events = {
    //   _selectedDay: ['Hoc', 'Di', 'sdsds', 'dsdsdsds', 'dsds'],
    //   dt: ['Code'],
    // };
    // _selectedEvents = _events[_selectedDay] ?? [];
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
      DatabaseHelper.columnId: 2,
      DatabaseHelper.columnTask: 'Code',
      DatabaseHelper.columnNote: 'flutter is cross flatform',
      DatabaseHelper.columnDateTime: '07-07-2020 10:54'
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
