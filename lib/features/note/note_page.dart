import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thoikhoabieu/base/base_widget.dart';
import 'package:thoikhoabieu/base/consts.dart';
import 'package:thoikhoabieu/base/styles.dart';
import 'package:thoikhoabieu/database/note.dart';
import 'package:thoikhoabieu/features/note/cubit/note_cubit.dart';
import 'package:thoikhoabieu/utils/appbar_zero_height.dart';
import 'package:thoikhoabieu/utils/convert_value.dart';

import '../../main.dart';

class NotePage extends StatefulWidget {
  final Note? note;
  NotePage({Key? key, this.note}) : super(key: key);

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  final _titleFocus = FocusNode();
  final _contentFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool _isShowSave = false;
  late NoteCubit _noteCubit;
  @override
  void initState() {
    String title = '';
    String content = '';
    if (widget.note != null) {
      title = widget.note!.title;
      content = widget.note!.content;
    }
    _titleController = TextEditingController(text: title);
    _contentController = TextEditingController(text: content);
    _titleFocus.requestFocus();
    _noteCubit = NoteCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NoteCubit>(
      create: (context) => _noteCubit,
      child: BlocConsumer<NoteCubit, NoteState>(
        listener: (context, state) {
          if (state is SaveNoteSuccess) {
            if (widget.note != null) {
              Navigator.pop(context);
            }
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AnonymousAppBar(
              color: Colors.black,
            ),
            backgroundColor: Theme.of(context).backgroundColor,
            body: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: BaseWidget.appBar(context, _buildAction()),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: _buildBody(),
                ))
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAction() {
    return Visibility(
      visible: _isShowSave,
      child: InkWell(
        onTap: () {
          if (widget.note != null) {
            print('start update note...');
            Note currentNote = Note(
                id: widget.note!.id,
                title: _titleController.text.trim(),
                content: _contentController.text,
                dateTime: widget.note!.dateTime);

            _noteCubit.updateNote(currentNote);
          } else {
            int id = prefs!.getInt(AppConst.keyId) ?? 1;
            print('max ID in database = $id');
            _noteCubit.saveNote(Note(
                id: id,
                title: _titleController.text.trim(),
                content: _contentController.text,
                dateTime: convertDateToString(DateTime.now())));
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Text(
              'Lưu',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).primaryColor),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildInputTitle(),
          const SizedBox(
            height: 10,
          ),
          Expanded(child: _buildInputContent())
        ],
      ),
    );
  }

  Widget _buildInputTitle() {
    return TextFormField(
      controller: _titleController,
      focusNode: _titleFocus,
      onChanged: (value) {
        _isShowSave = value.trim().isNotEmpty;
        setState(() {});
      },
      textInputAction: TextInputAction.next,
      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 18),
      decoration: InputDecoration(
          hintText: 'Tiêu đề',
          hintStyle: TextStyle(color: Colors.grey, fontSize: 18)),
    );
  }

  Widget _buildInputContent() {
    return TextFormField(
      controller: _contentController,
      focusNode: _contentFocus,
      keyboardType: TextInputType.multiline,
      maxLines: 100,
      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 14),
      decoration: InputDecoration(
          hintText: 'Hãy viết gì đó...',
          hintStyle: TextStyle(color: Colors.grey, fontSize: 14)),
    );
  }
}
