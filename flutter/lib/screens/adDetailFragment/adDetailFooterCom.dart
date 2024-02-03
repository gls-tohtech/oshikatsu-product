import 'package:flutter/material.dart';

class AdDetailFooterComponent extends StatelessWidget{
  late final Function() _bookmarkTapped;
  late final Function() _moveSupportUIButtonTapped;

  AdDetailFooterComponent({
    required Function() bookmarkTapped,
    required Function() moveSupportUIButtonTapped
  }){
    _bookmarkTapped = bookmarkTapped;
    _moveSupportUIButtonTapped = moveSupportUIButtonTapped;
  }

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        Padding(padding: EdgeInsets.symmetric(horizontal: size.width * 0.01)),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(256),
          ),
          child: Padding(
            padding: EdgeInsets.all(size.width * 0.01),
            child: InkWell(
              borderRadius: BorderRadius.circular(256),
              onTap: _bookmarkTapped,
              child: const Icon(Icons.bookmark),
            )
          )
        ),
        Padding(padding: EdgeInsets.symmetric(horizontal: size.width * 0.04)),
        Container(
          width: size.width * 0.72,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(256),
          ),
          child: Padding(
            padding: EdgeInsets.all(size.width * 0.01),
            child: InkWell(
              borderRadius: BorderRadius.circular(256),
              onTap: _moveSupportUIButtonTapped,
              child: const Align(
                alignment: Alignment.center,
                child: Text(
                  "応援手続きへ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            ),
          )
        ),
      ],
    );
  }
}