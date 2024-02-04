import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdDetailTopInfoComponent extends StatelessWidget{
  late final String _title;
  late final List<String> _hashtags;
  late final int _targetMoneyAmount;
  late final int _totalMoneyAmount;
  late final int _aiderNumbers;
  late final int _createrNumbers;
  late final Timestamp _deadLine;


  AdDetailTopInfoComponent({
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
        buildHashtagListWidget(context),
        Padding(padding: EdgeInsets.symmetric(vertical: size.height * 0.005)),
        buildDeadLine(context),
      ],
    );
  }

  Widget buildTitle(BuildContext context){
    return Text(
      _title,
      textScaler: TextScaler.linear(2),
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
            textScaler: const TextScaler.linear(1.2),
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
              child: Text("$_targetMoneyAmount"),
            ),
            const Text("円")
          ],
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: size.height * 0.005)),
        Row(
          children: [
            Padding(padding: EdgeInsets.symmetric(horizontal: size.width * 0.015)),
            SizedBox(
              width: size.width * 0.3,
              child: Text("現在の応援金額"),
            ),
            SizedBox(
              width: size.width * 0.2,
              child: Text("$_totalMoneyAmount"),
            ),
            const Text("円")
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
              child: Text("画像応援"),
            ),
            SizedBox(
              width: size.width * 0.2,
              child: Text("$_aiderNumbers"),
            ),
            const Text("人")
          ],
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: size.height * 0.005)),
        Row(
          children: [
            Padding(padding: EdgeInsets.symmetric(horizontal: size.width * 0.015)),
            SizedBox(
              width: size.width * 0.3,
              child: Text("クリエイター"),
            ),
            SizedBox(
              width: size.width * 0.2,
              child: Text("$_createrNumbers"),
            ),
            const Text("人")
          ],
        ),
        const Padding(padding: const EdgeInsets.symmetric(vertical: 4)),
      ],
    );
  }

  Widget buildHashtagListWidget(BuildContext context){
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for(String hashtag in _hashtags) hashtagWidget(hashtag),
        ],
      );
  }

  Widget hashtagWidget(String hashtagArg){
    return Flexible(
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Row(
              children: [
                const Icon(Icons.tag),
                Flexible(child: Text(hashtagArg),)
              ],
            ),
          )
        ),
      )
    );
  }

  Widget buildDeadLine(BuildContext context){
    return Row(
      children: [
        const Icon(Icons.schedule),
        Text("残り ${_deadLine.toDate().day} 日")
      ],
    );
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