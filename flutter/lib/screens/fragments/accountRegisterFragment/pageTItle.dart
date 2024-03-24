import 'package:flutter/widgets.dart';

class RegisterPageTitleWidget extends StatelessWidget{
  final String title;

  const RegisterPageTitleWidget({required this.title});

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return FittedBox(
      child: Padding(
        padding: EdgeInsets.all(size.width * 0.02),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}