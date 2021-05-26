import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thoikhoabieu/base/app_cubit/cubit/app_cubit.dart';
import 'package:thoikhoabieu/base/consts.dart';
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

int typeMode = 0; // 0 <=> light mode, 1 <=> dark mode

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppCubit _appCubit;
  @override
  void initState() {
    _appCubit = AppCubit();
    typeMode = prefs!.getInt(AppConst.keyMode) ?? 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppCubit>(
      create: (context) => _appCubit,
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Ghi chú',
              theme: ThemeData(
                  primarySwatch: Colors.blue,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  primaryColor: typeMode == 0 ? Colors.black : Colors.white,
                  backgroundColor: typeMode == 1 ? Colors.black : Colors.white),
              home: HomePage());
        },
      ),
    );
  }
}
