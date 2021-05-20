import 'package:flutter/material.dart';

/// app bar không hiển thị, dùng để set màu cho status bar
class AnonymousAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Color color;
  AnonymousAppBar({Key? key, required this.color}) : super(key: key);

  @override
  _AnonymousAppBarState createState() => _AnonymousAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(0);
}

class _AnonymousAppBarState extends State<AnonymousAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      brightness: Brightness.dark,
      elevation: 0,
      backgroundColor: widget.color,
    );
  }
}
