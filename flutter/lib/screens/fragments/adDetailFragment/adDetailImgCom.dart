import 'package:flutter/material.dart';

class AdDetailImgComponent extends StatelessWidget{
  late final String _imageUrl;
  late final Function() _movePreviousButtonTapped;

  AdDetailImgComponent(this._imageUrl, this._movePreviousButtonTapped);

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Image.network(
          _imageUrl,
          width: size.width,
        ),
        Align(
          alignment: Alignment.centerRight,
          child:  Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(1024),
            ),
            child: IconButton(
              onPressed: () => { 
                Navigator.of(context).pop(),
              }, 
              icon: const Icon(Icons.close)
            ),
          )
        )
      ],
    );
  }
}