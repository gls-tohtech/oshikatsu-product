import 'package:flutter/material.dart';

class ProjectDetailImgComponent extends StatelessWidget{
  late final String _imageUrl;
  late final Function() _movePreviousButtonTapped;

  ProjectDetailImgComponent(this._imageUrl, this._movePreviousButtonTapped);

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        _imageUrl != ""
          ? Image.network(
            _imageUrl,
            width: size.width,
            errorBuilder: (c, o, s) {
              print("error = $c $o $s");
              return SizedBox(
                width: size.width,
                height: size.height * 0.2,
                child: const Center(
                  child: Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                ),
              );
            },
          )
          : Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.grey,
                width: 1
              )
            ),
            height: 180,
            width: double.infinity,
            child: const Icon(
              Icons.image,
              size: 100,
            ),
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