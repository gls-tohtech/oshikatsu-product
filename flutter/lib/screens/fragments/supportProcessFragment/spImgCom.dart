import 'package:flutter/material.dart';

class SPImgComponent extends StatelessWidget {
  late final String _imageUrl;

  SPImgComponent({
    required String imageUrl
  }){
    _imageUrl = imageUrl;
  }

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return ClipRRect( 
      borderRadius: BorderRadius.circular(16),
      child: Image.network(
        _imageUrl,
        width : size.width * 0.9,
      ),
    );
  }
}