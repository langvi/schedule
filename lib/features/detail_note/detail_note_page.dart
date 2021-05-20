import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:thoikhoabieu/base/styles.dart';
import 'package:thoikhoabieu/features/search/search_delegate.dart';
import 'package:thoikhoabieu/utils/appbar_zero_height.dart';

import '../../base/colors.dart';

class DetailNotePage extends StatefulWidget {
  final int keyHero;
  DetailNotePage({Key? key, required this.keyHero}) : super(key: key);

  @override
  _DetailNotePageState createState() => _DetailNotePageState();
}

class _DetailNotePageState extends State<DetailNotePage> {
  final _title = 'Ngày mai là thứ hai';
  final _content =
      '''Rất nhiều người khác cũng đang nuôi mộng làm giàu nhờ trade coin. Khi các quán cà phê, quán ăn quanh văn phòng của tôi vào mỗi sáng hay trưa nếu bạn vào đó, đều có thể bắt gặp ít nhất một thanh niên tay này cầm thìa xúc cơm, tay kia cầm điện thoại, đôi mắt thì dán chặt vào màn hình thị trường tiền ảo.

Trong khi thị trường tiền số đỏ lửa tối qua, dù đã lỗ nặng nhưng bạn tôi vẫn còn đặt câu hỏi: "Có nên bắt đáy Bitcoin?". Giá trị Bitcoin nhảy múa như thế, thì biết đâu là đỉnh, đâu là đáy để bắt?

Bitcoin sau khi tăng trưởng liên tục, thu hút nhiều người đổ tiền thật vào, sẽ "bùm" một phát, mất đi vài chục phần trăm giá trị và điều này diễn ra theo chu kỳ. Vậy tiền vào túi ai? Dĩ nhiên là vào các cá mập, các sàn giao dịch hay những "đại gia" như Elon Musk. Những cá con với hy vọng lướt sóng với cá mập kiểu theo đóm ăn tàn thì chỉ một số rất ít người kiếm được tiền. Mà thực ra, đó là tiền của người này chảy vào túi người khác mà thôi. Nếu bạn lời một 1.000 USD thì có người mất đi con số tương ứng chứ bản thân tiền số không tạo ra giá trị nào cả
  ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AnonymousAppBar(
        color: Colors.black,
      ),
      body: Hero(
        tag: widget.keyHero,
        child: Column(
          children: [
            _buildAppBar(),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: _buildBody(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            highlightColor: Colors.white,
            focusColor: AppColors.mainColor,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8)),
              child: Icon(
                Feather.edit,
                color: Colors.white,
                size: 20,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_title, style: BaseStyles.textTitle),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                '20/10/2021',
                style: BaseStyles.textTimeWhite,
              ),
            ),
            Text(_content + _content + _content, style: BaseStyles.textContent),
          ],
        ),
      ),
    );
  }
}
