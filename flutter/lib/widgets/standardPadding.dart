import 'package:flutter/widgets.dart';

class StandartPaddingComponent extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: size.height * 0.005
      ),
    );
  }
}