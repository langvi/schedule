import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:note_app/base/colors.dart';

class TimePicker extends StatefulWidget {
  TimePicker({Key? key}) : super(key: key);

  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  String currentTime = '';
  @override
  void initState() {
    super.initState();
    _setCurrentTime();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 150,
      decoration: BoxDecoration(
        color: AppColors.colorButton,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: _buildTimePicker(),
    );
  }

  Widget _buildTimePicker() {
    return FlatButton(
        onPressed: () {
          DatePicker.showDateTimePicker(context,
              showTitleActions: true, onChanged: (date) {}, onConfirm: (date) {
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
        ));
  }

  void _setCurrentTime() {
    DateTime dateTime = DateTime.now();
    DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm');
    currentTime = formatter.format(dateTime);
  }
}
