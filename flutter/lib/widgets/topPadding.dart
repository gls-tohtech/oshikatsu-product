import 'package:flutter/widgets.dart';

class TopPaddingComponent extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.03,
    );
  }
}