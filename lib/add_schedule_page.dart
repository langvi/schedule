import 'package:flutter/material.dart';
import 'package:thoikhoabieu/time_picker.dart';

import 'base/colors.dart';

class AddSchedule extends StatefulWidget {
  AddSchedule({Key key}) : super(key: key);

  @override
  _AddScheduleState createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {
  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerContent = TextEditingController();
  final FocusNode _textFocus = FocusNode();
  bool _isAlarm = false;
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
          child: TimePicker(),
        ))
      ],
    );
  }

  Widget _buildAppBar() {
    return Container(
      height: 160,
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
                      onPressed: () {}))
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
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: TextFormField(
        controller: controllerTitle,
        focusNode: _textFocus,
        style: TextStyle(color: AppColors.colorTextAppBar),
        decoration: const InputDecoration(
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
    );
  }
}
