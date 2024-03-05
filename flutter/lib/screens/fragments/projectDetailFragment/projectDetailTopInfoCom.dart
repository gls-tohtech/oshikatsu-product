import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oshikatsu_product/widgets/hashtags.dart';

class ProjectDetailTopInfoComponent extends StatelessWidget{
  late final String _title;
  late final List<String> _hashtags;
  late final int _targetMoneyAmount;
  late final int _totalMoneyAmount;
  late final int _aiderNumbers;
  late final int _createrNumbers;
  late final Timestamp _deadLine;


  ProjectDetailTopInfoComponent({
    required String title,
    required List<String> hashtagList,
    required int targetMoneyAmount,
    required int totalMoneyAmount,
    required int aiderNumbers,
    required int createrNumbers,
    required Timestamp deadLine,
  }){
    _title = title;
    _hashtags = hashtagList;
    _targetMoneyAmount = targetMoneyAmount;
    _totalMoneyAmount = totalMoneyAmount;
    _aiderNumbers = aiderNumbers;
    _createrNumbers = createrNumbers;
    _deadLine = deadLine;
  }

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        buildTitle(context),
        Padding(padding: EdgeInsets.symmetric(vertical: size.height * 0.005)),
        buildGoalProgress(context),
        Padding(padding: EdgeInsets.symmetric(vertical: size.height * 0.005)),
        buildShowMoneyInfo(context),
        Padding(padding: EdgeInsets.symmetric(vertical: size.height * 0.005)),
        buildNumbers(context),
        Padding(padding: EdgeInsets.symmetric(vertical: size.height * 0.005)),
        HashtagsComponent(hashtags: _hashtags),
        Padding(padding: EdgeInsets.symmetric(vertical: size.height * 0.005)),
        buildDeadLine(context),
      ],
    );
  }

  Widget buildTitle(BuildContext context){
    return Text(
      _title,
      textScaler: const TextScaler.linear(2),
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget buildGoalProgress(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.95,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "達成度",
            textScaler: TextScaler.linear(1.2),
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: size.height * 0.015,
              valueIndicatorColor: Colors.orange,
		          activeTrackColor: const Color.fromARGB(255, 174, 0, 255), // アクティブなトラックの色
              inactiveTrackColor: const Color.fromARGB(255, 189, 189, 189), // 非アクティブなトラックの色

              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0.0),

              trackShape: const CustomSliderTrackShape(),
              overlayShape: SliderComponentShape.noOverlay,   
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: size.height * 0.012),
              child: Slider(
                value: _totalMoneyAmount.toDouble(),
                onChanged: ((value) => { null }),
                min: 0,
                max: _targetMoneyAmount.toDouble(),
              ),
            )
          )
        ],
      )
    );
  }

  Widget buildShowMoneyInfo(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          children: [
            Padding(padding: EdgeInsets.symmetric(horizontal: size.width * 0.015)),
            SizedBox(
              width: size.width * 0.3,
              child: const Text("目標金額"),
            ),
            SizedBox(
              width: size.width * 0.2,
              child: Text(
                "$_targetMoneyAmount",
                textAlign: TextAlign.right,
              ),
            ),
            const Text("    円")
          ],
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: size.height * 0.005)),
        Row(
          children: [
            Padding(padding: EdgeInsets.symmetric(horizontal: size.width * 0.015)),
            SizedBox(
              width: size.width * 0.3,
              child: const Text("現在の応援金額"),
            ),
            SizedBox(
              width: size.width * 0.2,
              child: Text(
                "$_totalMoneyAmount",
                textAlign: TextAlign.right,
              ),
            ),
            const Text("    円")
          ],
        ),
      ],
    );
  }

  Widget buildNumbers(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          children: [
            Padding(padding: EdgeInsets.symmetric(horizontal: size.width * 0.015)),
            SizedBox(
              width: size.width * 0.3,
              child: const Text("画像応援"),
            ),
            SizedBox(
              width: size.width * 0.2,
              child: Text(
                "$_aiderNumbers",
                textAlign: TextAlign.right,
              ),
            ),
            const Text("    人")
          ],
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: size.height * 0.005)),
        Row(
          children: [
            Padding(padding: EdgeInsets.symmetric(horizontal: size.width * 0.015)),
            SizedBox(
              width: size.width * 0.3,
              child: const Text("クリエイター"),
            ),
            SizedBox(
              width: size.width * 0.2,
              child: Text(
                "$_createrNumbers",
                textAlign: TextAlign.right,
              ),
            ),
            const Text("    人")
          ],
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
      ],
    );
  }

  Widget buildDeadLine(BuildContext context){
    return Row(
      children: [
        const Icon(Icons.schedule),
        Text("残り ${calcDaysRemaining(_deadLine.toDate())} 日")
      ],
    );
  }

  int calcDaysRemaining(DateTime deadline){
    DateTime now = DateTime.now();
    Duration difference = deadline.difference(now);
    int days = difference.inDays;
    return days;
  }
}

class CustomSliderTrackShape extends RoundedRectSliderTrackShape {
  const CustomSliderTrackShape();

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

  //Widget buildGoalProgress(BuildContext context){
  //   return Column(
  //     children: [

  //     ],
  //   );
  // }