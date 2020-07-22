import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class TimePicker extends StatefulWidget {
  TimePicker({Key key}) : super(key: key);

  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: _buildTimePicker(),
    );
  }

  Widget _buildTimePicker() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Giờ',
                style: TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text('Phút',
                  style: TextStyle(color: Colors.blue, fontSize: 18,fontWeight: FontWeight.bold)),
            )
          ],
        ),
        TimePickerSpinner(
          is24HourMode: true,
          normalTextStyle: TextStyle(fontSize: 16, color: Colors.grey),
          highlightedTextStyle: TextStyle(fontSize: 18, color: Colors.black),
          spacing: 20,
          isForce2Digits: true,
          onTimeChange: (time) {
            setState(() {
              // _dateTime = time;
            });
          },
        ),
      ],
    );
  }
}
