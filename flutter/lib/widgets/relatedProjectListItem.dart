import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oshikatsu_product/controllers/UserController.dart';
import 'package:oshikatsu_product/controllers/roomController.dart';
import 'package:oshikatsu_product/models/projects/project.dart';
import 'package:oshikatsu_product/providers/projectProvider.dart';
import 'package:oshikatsu_product/widgets/projectListItemComponent/projectListItemCom.dart';
import 'package:oshikatsu_product/widgets/radiusText.dart';

class RelatedProjectListItem extends ConsumerStatefulWidget {
  final DocumentReference projectRef;
  const RelatedProjectListItem({super.key, required this.projectRef});

  @override
  RelatedProjectListItemState createState() => RelatedProjectListItemState();
}

class RelatedProjectListItemState extends ConsumerState<RelatedProjectListItem> {

  bool isRoomIdNonNull(Project project){
    if(project.roomID == null) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final streamProv = ref.watch(projectStreamProviderFromRef(widget.projectRef));

    return streamProv.when(
      data: (Project project){
        return Column(
          children: [
            ProjectListItemContent(project: project, isShowRoomEnterBtn: true),
            SizedBox(height: size.height * 0.01,)
          ],
        );
      }, error:((error, stackTrace) {
        return Text("error = \n${error.toString()}");
      }), 
      loading: () => Container()
    );
  }
}