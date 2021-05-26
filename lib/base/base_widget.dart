import 'package:flutter/material.dart';

class BaseWidget {
  static Widget appBar(BuildContext context, Widget action) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10)),
            child: Icon(
              Icons.arrow_back,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        action
      ],
    );
  }
}
