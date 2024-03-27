import 'package:flutter/widgets.dart';

class VerticalPaddingWidget extends StatelessWidget{
  final Widget child;
  final double paddingFactor;
  
  const VerticalPaddingWidget({required this.child, this.paddingFactor = 1});

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.03 * paddingFactor),
      child: child,
    );
  }
}