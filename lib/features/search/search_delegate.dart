import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:thoikhoabieu/base/colors.dart';
import 'package:thoikhoabieu/database/note.dart';
import 'package:thoikhoabieu/features/home/cubit/home_cubit.dart';
import 'package:thoikhoabieu/features/note/note_page.dart';
import 'package:thoikhoabieu/main.dart';
import 'package:thoikhoabieu/utils/navigator.dart';

class CustomDelegate extends SearchDelegate {
  final Function(String)? onSearch;
  CustomDelegate({this.onSearch, required this.cubit});
  List<Note> suggests = [];
  late HomeCubit cubit;
  @override
  String? get searchFieldLabel => 'Tìm kiếm...';
  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
        primaryColor: Theme.of(context).backgroundColor,
        // backgroundColor: Colors.white,
        brightness: typeMode == 0 ? Brightness.light : Brightness.dark);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.search,
          color: Theme.of(context).primaryColor,
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
      icon: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildListNote();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder<List<Note>>(
        stream: cubit.getSuggestNote(query),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            suggests = snapshot.data!;
          }
          return _buildListNote();
        });
  }

  Widget _buildListNote() {
    return ListView.builder(
      itemCount: suggests.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            navToScreenWithTransition(
                context: context,
                toPage: NotePage(
                  note: suggests[index],
                ));
          },
          tileColor: AppColors.colorNote1,
          leading: Icon(Feather.edit),
          title: Text(suggests[index].title),
        );
      },
    );
  }
}
