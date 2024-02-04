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
        // IconButton(
        //   onPressed: _movePreviousButtonTapped, 
        //   icon: const Icon(Icons.skip_previous)
        // ),
        Image.network(
          _imageUrl,
          width: size.width,
        )
      ],
    );
  }
}