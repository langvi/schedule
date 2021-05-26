import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:thoikhoabieu/base/consts.dart';
import 'package:thoikhoabieu/main.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  void changeMode(int value) {
    typeMode = value;
    prefs!.setInt(AppConst.keyMode, value);
    emit(ChangeModeSuccess());
  }
}
