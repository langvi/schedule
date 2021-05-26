import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:thoikhoabieu/base/styles.dart';
import 'package:thoikhoabieu/database/note.dart';
import 'package:thoikhoabieu/features/note/note_page.dart';
import 'package:thoikhoabieu/utils/appbar_zero_height.dart';
import 'package:thoikhoabieu/utils/convert_value.dart';
import 'package:thoikhoabieu/utils/navigator.dart';

import '../../base/colors.dart';

class DetailNotePage extends StatefulWidget {
  final int keyHero;
  final Note note;
  final Function onRefresh;
  DetailNotePage(
      {Key? key,
      required this.keyHero,
      required this.note,
      required this.onRefresh})
      : super(key: key);

  @override
  _DetailNotePageState createState() => _DetailNotePageState();
}

class _DetailNotePageState extends State<DetailNotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AnonymousAppBar(
        color: Colors.black,
      ),
      body: Hero(
        tag: widget.keyHero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppBar(),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: _buildBody(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
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
          InkWell(
            onTap: () {
              navToScreenWithTransition(
                  context: context,
                  toPage: NotePage(
                    note: widget.note,
                  ),
                  callback: () {
                    widget.onRefresh();
                  });
            },
            highlightColor: Colors.white,
            focusColor: AppColors.mainColor,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8)),
              child: Icon(
                Feather.edit,
                color: Theme.of(context).primaryColor,
                size: 20,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.note.title,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).primaryColor)),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                changeFormatDate(widget.note.dateTime),
                style: BaseStyles.textTimeWhite,
              ),
            ),
            Text(widget.note.content,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).primaryColor)),
          ],
        ),
      ),
    );
  }
}
