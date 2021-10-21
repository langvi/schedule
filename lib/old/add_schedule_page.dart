import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:note_app/old/test_db.dart';
import '../base/colors.dart';
import 'event_note.dart';

class AddSchedule extends StatefulWidget {
  AddSchedule({Key? key}) : super(key: key);

  @override
  _AddScheduleState createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {
  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerContent = TextEditingController();
  final FocusNode _textFocus = FocusNode();
  String currentTime = '';
  bool _isAlarm = false;
  late Event _event;
  bool _isValidate = true;
  final _formKey = GlobalKey<FormState>();
  final dbHelper = DatabaseHelper.instance;
  @override
  void initState() {
    super.initState();
    DateTime dateTime = DateTime.now();
    DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm');
    currentTime = formatter.format(dateTime);
    // _event = Event();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildAppBar(),
            SizedBox(
              height: 20,
            ),
            _buildTimePicker(),
            _buildNote(),
            Divider(
              height: 1,
              indent: 10,
              endIndent: 10,
              thickness: 1,
            ),
            _buildAlarm(),
            Divider(
              height: 1,
              thickness: 1,
              indent: 10,
              endIndent: 10,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTimePicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Chọn thời gian',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: _buildDateTimePicker(),
        ))
      ],
    );
  }

  Widget _buildAppBar() {
    return Container(
      height: 180,
      decoration: BoxDecoration(
          color: AppColors.colorAppBar,
          borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 6.0),
                  child: IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      })),
              Padding(
                  padding: const EdgeInsets.only(top: 10.0, right: 6.0),
                  child: IconButton(
                      icon: Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          FocusScope.of(context).unfocus();
                          _addContent();
                          _insert(_event.title, _event.dateTime,
                              note: _event.content);
                          Navigator.pop(context);
                        } else {
                          // FocusScope.of(context).previousFocus();
                        }
                      }))
            ],
          ),
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  'Tiêu đề',
                  style:
                      TextStyle(fontSize: 20, color: AppColors.colorTextAppBar),
                ),
              )),
          _buildInputText()
        ],
      ),
    );
  }

  Widget _buildNote() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Ghi chú',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: controllerContent,
            maxLines: 8,
            decoration: InputDecoration(
                hintText: 'Hãy nhập gì đó',
                fillColor: Colors.grey[200],
                filled: true,
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(15.0))),
          )
        ],
      ),
    );
  }

  Widget _buildAlarm() {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Icon(Icons.notifications_active, color: AppColors.colorAppBar),
        ),
        Expanded(
          child: Text(
            'Nhắc nhở',
            style: TextStyle(fontSize: 16),
          ),
        ),
        Switch(
            value: _isAlarm,
            onChanged: (v) {
              setState(() {
                _isAlarm = v;
              });
            })
      ],
    );
  }

  Widget _buildInputText() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: TextFormField(
          controller: controllerTitle,
          focusNode: _textFocus,
          style: TextStyle(color: AppColors.colorTextAppBar),
          validator: (value) {
            if (controllerTitle.text.isEmpty) {
              return 'Hãy nhập vào tiêu đề';
            } else {
              return null;
            }
          },
          decoration: const InputDecoration(
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange),
            ),
            errorStyle: TextStyle(color: Colors.orange, fontSize: 14),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange),
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.backGroundTextField),
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            hintText: 'Nhập tiêu đề',
            fillColor: AppColors.backGroundTextField,
            filled: true,
            hintStyle: TextStyle(color: Colors.white),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.blue)),
          ),
        ),
      ),
    );
  }

  Widget _buildDateTimePicker() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.colorButton,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: FlatButton(
          onPressed: () {
            DatePicker.showDateTimePicker(context,
                showTitleActions: true,
                onChanged: (date) {}, onConfirm: (date) {
              DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm');
              setState(() {
                currentTime = formatter.format(date);
              });
            }, currentTime: DateTime.now(), locale: LocaleType.vi);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                currentTime,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Icon(
                Icons.today,
                color: Colors.white,
              )
            ],
          )),
    );
  }

  void _addContent() {
    String title = controllerTitle.text;
    String note = controllerContent.text;
    _event = Event(title: title, content: note, dateTime: currentTime);
    print(_event.content);
    print(_event.dateTime);
    print(_event.title);
  }

  void _insert(String? nameTask, String? dateTime, {String? note = ''}) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnTask: nameTask,
      DatabaseHelper.columnNote: note,
      DatabaseHelper.columnDateTime: dateTime
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
  }
}
