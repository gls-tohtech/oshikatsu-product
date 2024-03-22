import 'package:flutter/material.dart';
import 'package:oshikatsu_product/widgets/radiusText.dart';
import 'package:oshikatsu_product/widgets/termOfService.dart';

class CheckTerm extends StatefulWidget {
  const CheckTerm({super.key});

  @override
  _CheckTermState createState() => _CheckTermState();
}

class _CheckTermState extends State<CheckTerm> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TermOfServiceComponent(),
            SizedBox(height: size.height * 0.1,),
            RadiusTextComponent(
              "アカウントを作成する",
              widthRatio: 0.7,
              textTapped: () {
                
              },
            )
          ],
        ),
      ),
    );
  }
}