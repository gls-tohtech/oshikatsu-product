import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:oshikatsu_product/widgets/standardPadding.dart';

class SubmitSucecssPopupComponent extends StatelessWidget{
  final String imageUrl;
  final Function() closePopup;

  SubmitSucecssPopupComponent({required this.imageUrl, required this.closePopup});

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(
            color: Color.fromARGB(200, 0, 0, 0)
          ),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.25, horizontal: size.width * 0.05),
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)
              ),
              elevation: 8,
              child: Column(
                children: [
                  imageUrl != ""
                    ? ClipRRect(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                      child: Image.network(imageUrl),
                    )
                    : Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1
                      )
                    ),
                    height: size.height * 0.15,
                    width: double.infinity,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          Icon(
                          Icons.check,
                          size: 50,
                        ),
                      ],
                    )
                  ),
                  StandartPaddingComponent(),
                  const Text(
                    "投稿が完了しました!",
                    style: TextStyle(fontSize: 25),
                  ),
                  StandartPaddingComponent(),
                  const Text("この投稿をシェアしませんか?"),
                  StandartPaddingComponent(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {}, 
                        icon: const Icon(Icons.copy)
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}