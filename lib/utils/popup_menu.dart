import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:thoikhoabieu/base/colors.dart';

Widget buildPopupMenu(Function(int) onSelected, BuildContext context) {
  return PopupMenuButton<int>(
      icon: Icon(
        Icons.more_vert,
        color: Theme.of(context).primaryColor,
      ),
      color: Theme.of(context).backgroundColor,
      onSelected: onSelected,
      itemBuilder: (context) {
        List<PopupMenuEntry<int>> list = [];
        list.add(
          PopupMenuItem(
            value: 0,
            child: Row(
              children: [
                Icon(
                  Feather.sun,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Light mode',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ],
            ),
          ),
        );
        list.add(
          PopupMenuDivider(
            height: 10,
          ),
        );
        list.add(
          PopupMenuItem(
            value: 1,
            child: Row(
              children: [
                Icon(
                  Entypo.moon,
                  color: AppColors.colorNote4,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Dark mode',
                  style: TextStyle(color: AppColors.colorNote4),
                ),
              ],
            ),
          ),
        );
        return list;
      });
}
