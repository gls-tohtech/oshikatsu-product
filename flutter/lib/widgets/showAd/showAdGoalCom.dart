import 'package:flutter/material.dart';

class ShowAdGaolComponent extends StatelessWidget{
  late final int _targetMoneyAmount;
  late final int _totalMoneyAmount;

  ShowAdGaolComponent(
    this._targetMoneyAmount,
    this._totalMoneyAmount
  );

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "達成度",
            textScaler: const TextScaler.linear(1.1),
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