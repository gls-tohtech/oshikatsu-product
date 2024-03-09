import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HashtagsComponent extends StatelessWidget{
  late final List<String> _hashtags;

  HashtagsComponent({
    required List<String> hashtags
  }){
    _hashtags = hashtags;
  }

  Widget hashtagWidget(String hashtagArg){
    return Flexible(
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Row(
              children: [
                const Icon(Icons.tag),
                Flexible(child: Text(hashtagArg),)
              ],
            ),
          )
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        for(String hashtag in _hashtags) hashtagWidget(hashtag),
      ],
    );
  }
}