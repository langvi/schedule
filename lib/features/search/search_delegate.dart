import 'package:flutter/material.dart';

class CustomDelegate extends SearchDelegate {
  final Function(String)? onSearch;
  CustomDelegate({this.onSearch});
  @override
  String? get searchFieldLabel => 'Tìm kiếm...';
  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
        primaryColor: Colors.black,
        backgroundColor: Colors.black,
        brightness: Brightness.dark);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.search,
          color: Colors.white,
        ),
        onPressed: () {
          if (onSearch != null) {
            onSearch!(query);
          }
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
