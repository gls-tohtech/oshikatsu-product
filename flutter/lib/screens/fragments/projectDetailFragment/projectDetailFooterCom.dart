import 'package:flutter/material.dart';
import 'package:oshikatsu_product/models/projects/project.dart';
import 'package:oshikatsu_product/screens/fragments/supportProcessFragment/supportProcessFragment.dart';

class ProjectDetailFooterComponent extends StatelessWidget{
  late final Function() _bookmarkTapped;

  late final Project _project;

  ProjectDetailFooterComponent({
    required Project project,
    required Function() bookmarkTapped,
  }){
    _project = project;
    _bookmarkTapped = bookmarkTapped;
  }

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        Padding(padding: EdgeInsets.symmetric(horizontal: size.width * 0.01)),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(256),
          ),
          child: Padding(
            padding: EdgeInsets.all(size.width * 0.01),
            child: InkWell(
              borderRadius: BorderRadius.circular(256),
              onTap: _bookmarkTapped,
              child: const Icon(Icons.bookmark),
            )
          )
        ),
        Padding(padding: EdgeInsets.symmetric(horizontal: size.width * 0.04)),
        Container(
          width: size.width * 0.72,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(256),
          ),
          child: Container(
            width: size.width * 0.5,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(256),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(256),
              onTap: () => {
                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  return SupportProcessFragment(project: _project);
                })),
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: size.height * 0.005),
                child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "応援手続きへ",
                    textScaler: TextScaler.linear(1),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              )
            ),
          ),
        ),
      ],
    );
  }
}