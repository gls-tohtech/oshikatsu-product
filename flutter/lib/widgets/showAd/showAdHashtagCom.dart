import 'package:flutter/material.dart';

class ShowAdHashtagListComponents extends StatelessWidget{
  late final List<String> _hashtags;

  ShowAdHashtagListComponents(this._hashtags);

  @override
  Widget build(BuildContext context){
    return _HashtagListWidget(_hashtags);
  }

  Widget _HashtagListWidget(List<String> hashtagListArg){
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for(String hashtag in hashtagListArg) _HashtagWidget(hashtag),
        ],
      );
  }

  Widget _HashtagWidget(String hashtagArg){
    return Flexible(
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(16),
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
}