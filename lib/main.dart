import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thoikhoabieu/database/sql_lite.dart';
import 'package:thoikhoabieu/features/home/home_page.dart';
import 'package:intl/date_symbol_data_local.dart';

SqlLiteHelper databaseApp = SqlLiteHelper.instance;
SharedPreferences? prefs;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // init database
  await databaseApp.database;
  prefs = await SharedPreferences.getInstance();

  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ghi chú',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage());
  }
}
