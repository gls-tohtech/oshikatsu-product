import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProjectListItemImgComponent extends StatelessWidget{
  late final String _imageUrl;

  ProjectListItemImgComponent(this._imageUrl);

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Card(
      elevation: 8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: _imageUrl != ""
          ? Image.network(
            _imageUrl,
            width: size.width * 0.48,
          )
          : SizedBox(
            width: size.width * 0.48,
            height: size.height * 0.14,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.2, vertical: size.height * 0.05),
              child: const CircularProgressIndicator(),
            )
          )
      ),
    );
  }
}