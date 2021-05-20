import 'package:flutter/material.dart';
import 'package:thoikhoabieu/base/base_widget.dart';
import 'package:thoikhoabieu/base/styles.dart';
import 'package:thoikhoabieu/utils/appbar_zero_height.dart';

class NotePage extends StatefulWidget {
  NotePage({Key? key}) : super(key: key);

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  final _titleFocus = FocusNode();
  final _contentFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _titleController = TextEditingController();
    _contentController = TextEditingController();
    _titleFocus.requestFocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AnonymousAppBar(
        color: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
  }

  Widget _buildAction() {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            'Lưu',
            style: BaseStyles.textActiveWhite,
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
      textInputAction: TextInputAction.next,
      style: TextStyle(color: Colors.grey, fontSize: 18),
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
      style: TextStyle(color: Colors.grey, fontSize: 14),
      decoration: InputDecoration(
          hintText: 'Hãy viết gì đó...',
          hintStyle: TextStyle(color: Colors.grey, fontSize: 14)),
    );
  }
}
