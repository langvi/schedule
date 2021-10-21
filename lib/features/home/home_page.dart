import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_app/base/app_cubit/cubit/app_cubit.dart';
import 'package:note_app/base/styles.dart';
import 'package:note_app/database/note.dart';
import 'package:note_app/features/detail_note/detail_note_page.dart';
import 'package:note_app/features/home/cubit/home_cubit.dart';
import 'package:note_app/features/note/note_page.dart';
import 'package:note_app/features/search/search_delegate.dart';
import 'package:note_app/main.dart';
import 'package:note_app/utils/convert_value.dart';
import 'package:note_app/utils/navigator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:note_app/utils/popup_menu.dart';
import 'package:note_app/utils/type_load.dart';
import '../../base/colors.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeCubit _homeCubit;
  List<Note> notes = [];
  int count = 0;
  final _refreshController = RefreshController();
  bool _hasLoadmore = true;
  @override
  void initState() {
    _homeCubit = HomeCubit();
    _homeCubit.getNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _homeCubit,
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is GetNotesSuccess) {
            if (state.notes.length < PAGE_SIZE) {
              _hasLoadmore = false;
            } else {
              _homeCubit.pageIndex++;
            }
            if (state.typeLoad == TypeLoad.loading) {
              notes.addAll(state.notes);
            } else {
              notes = state.notes;
            }
          } else if (state is DeleteSuccess) {
            notes.removeAt(state.indexRemove);
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            appBar: AppBar(
              backgroundColor:
                  typeMode == 0 ? AppColors.mainColor : Colors.black,
              // backgroundColor: Theme.of(context).backgroundColor,
              brightness: Brightness.dark,
              title: Text(
                'Ghi chú',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              actions: [
                IconButton(
                    icon: Icon(Icons.search),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      // _homeCubit.getSuggestNote('');
                      showSearch(
                          context: context,
                          delegate: CustomDelegate(cubit: _homeCubit));
                    }),
                buildPopupMenu((value) {
                  if (value != typeMode) {
                    BlocProvider.of<AppCubit>(context).changeMode(value);
                  }
                }, context)
                // IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
              ],
            ),
            body: _buildBody(),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                navToScreenWithTransition(
                    context: context,
                    toPage: NotePage(),
                    callback: () {
                      print('refresh');
                      _homeCubit.getNotes();
                    });
              },
              backgroundColor: AppColors.mainColor,
              child: Icon(
                Icons.add,
                color: Theme.of(context).primaryColor,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody() {
    if (notes.isEmpty) {
      return Center(
        child: Text(
          'Trống...',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      );
    }
    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: false,
      enablePullUp: _hasLoadmore,
      onLoading: () {
        _homeCubit.getNotes(typeLoad: TypeLoad.loading);
      },
      child: StaggeredGridView.countBuilder(
        shrinkWrap: true,
        padding: EdgeInsets.all(15),
        itemCount: notes.length,
        crossAxisCount: 4,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemBuilder: (context, index) {
          return _buildItemNote(index.isEven ? 9 : 2, index);
        },
        staggeredTileBuilder: (index) {
          return StaggeredTile.count(
              2, notes[index].content.length > 25 ? 2 : 1);
        },
      ),
    );
  }

  Widget _buildItemNote(int maxLine, int index) {
    Color colorItem;
    if (count > 4) {
      count = 0;
    }
    switch (count) {
      case 0:
        colorItem = AppColors.mainColor;
        break;
      case 1:
        colorItem = AppColors.colorNote1;
        break;
      case 2:
        colorItem = AppColors.colorNote2;
        break;
      case 3:
        colorItem = AppColors.colorNote3;
        break;
      default:
        colorItem = AppColors.colorNote4;
    }
    count++;
    return Hero(
      tag: index,
      flightShuttleBuilder: (flightContext, animation, flightDirection,
          fromHeroContext, toHeroContext) {
        return AnimatedBuilder(
          animation: animation,
          builder: (context, value) {
            return Container(
              color: Color.lerp(
                  AppColors.mainColor,
                  Theme.of(context).backgroundColor.withOpacity(0.5),
                  animation.value),
            );
          },
        );
      },
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailNotePage(
                      keyHero: index,
                      note: notes[index],
                      onRefresh: () {
                        print('refresh update');
                        _homeCubit.getNotes();
                      },
                    )),
          );
        },
        onLongPress: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return ListTile(
                onTap: () {
                  _homeCubit.removeNote(notes[index].id, index);
                },
                leading: Icon(Icons.delete),
                title: Text('Xóa ghi chú'),
              );
            },
          );
        },
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: colorItem, borderRadius: BorderRadius.circular(5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Expanded(
              //     child:
              //         _buildTextNote(notes[index].title, notes[index].content, maxLine: )),
              Text(
                notes[index].title,
                style: BaseStyles.textActive,
                overflow: TextOverflow.ellipsis,
              ),
              Expanded(
                child: Text(
                  notes[index].content,
                  maxLines: notes[index].content.length > 25 ? 6 : 2,
                  style: BaseStyles.textContentBlack,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                changeFormatDate(notes[index].dateTime),
                style: BaseStyles.textTime,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextNote(String title, String content, {int maxLine = 2}) {
    return RichText(
        overflow: TextOverflow.ellipsis,
        maxLines: maxLine,
        text: TextSpan(text: title, style: BaseStyles.textActive, children: [
          TextSpan(text: '\n$content', style: BaseStyles.textContentBlack)
        ]));
  }
}
