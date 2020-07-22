import 'package:flutter/material.dart';
import 'package:thoikhoabieu/time_picker.dart';

import 'base/colors.dart';

class AddSchedule extends StatefulWidget {
  AddSchedule({Key key}) : super(key: key);

  @override
  _AddScheduleState createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {
  TextEditingController controller = TextEditingController();
  final FocusNode _textFocus = FocusNode();
  bool isShow = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[_buildAppBar(), _buildBody()],
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Chọn thời gian',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        TimePicker()
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
                      onPressed: () {})),
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
    return Column(
      children: <Widget>[
        Text('Ghi chú'),
      ],
    );
  }

  Widget _buildInputText() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: TextFormField(
        controller: controller,
        focusNode: _textFocus,
        style: TextStyle(color: AppColors.colorTextAppBar),
        decoration: const InputDecoration(
          hintText: 'Nhập tiêu đề',
          fillColor: AppColors.backGroundTextField,
          filled: true,
          hintStyle: TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.backGroundTextField),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: Colors.blue)),
        ),
      ),
    );
  }
}
