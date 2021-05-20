import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:thoikhoabieu/base/styles.dart';
import 'package:thoikhoabieu/features/detail_note/detail_note_page.dart';
import 'package:thoikhoabieu/features/note/note_page.dart';
import 'package:thoikhoabieu/features/search/search_delegate.dart';
import 'package:thoikhoabieu/utils/navigator.dart';

import '../../base/colors.dart';
import '../../base/colors.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _strTest =
      'A StaggeredGridView needs to know how to display each tile, and what widget is associated with a tile.';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        brightness: Brightness.dark,
        title: Text('Ghi chú'),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: CustomDelegate());
              })
        ],
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navToScreenWithTransition(context: context, toPage: NotePage());
        },
        backgroundColor: AppColors.mainColor,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody() {
    return StaggeredGridView.countBuilder(
      shrinkWrap: true,
      padding: EdgeInsets.all(15),
      itemCount: 8,
      crossAxisCount: 4,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      itemBuilder: (context, index) {
        return _buildItemNote(index.isEven ? 9 : 2, index);
      },
      staggeredTileBuilder: (index) {
        return StaggeredTile.count(2, index.isEven ? 2 : 1);
      },
    );
  }

  Widget _buildItemNote(int maxLine, int index) {
    return Hero(
      tag: index,
      flightShuttleBuilder: (flightContext, animation, flightDirection,
          fromHeroContext, toHeroContext) {
        return AnimatedBuilder(
          animation: animation,
          builder: (context, value) {
            return Container(
              color: Color.lerp(
                  AppColors.mainColor, Colors.black87, animation.value),
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
                    )),
          );
          // navToScreenWithTransition(
          //     context: context,
          //     toPage: DetailNotePage(
          //       keyHero: index,
          //     ));
        },
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: AppColors.mainColor,
              borderRadius: BorderRadius.circular(5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  _strTest,
                  overflow: TextOverflow.ellipsis,
                  maxLines: maxLine,
                  style: BaseStyles.textActive,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '20/10/2021',
                style: BaseStyles.textTime,
              )
            ],
          ),
        ),
      ),
    );
  }
}
