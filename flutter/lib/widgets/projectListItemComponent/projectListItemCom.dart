import 'package:flutter/material.dart';
import 'package:oshikatsu_product/controllers/roomController.dart';
import 'package:oshikatsu_product/models/projects/project.dart';
import 'package:oshikatsu_product/providers/projectProvider.dart';
import 'package:oshikatsu_product/screens/fragments/projectDetailFragment/projectDetailFragment.dart';
import 'package:oshikatsu_product/widgets/radiusText.dart';
import 'package:oshikatsu_product/widgets/standardPadding.dart';
import 'projectListItemGoalCom.dart';
import 'projectListItemImgCom.dart';
import 'projectListItemNumbersCom.dart';
import 'projectListItemHashtagCom.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProjectListItem extends ConsumerStatefulWidget {
  final String projectId;
  final bool isShowRoomEnterBtn;

  ProjectListItem({required this.projectId, required this.isShowRoomEnterBtn});

  @override
  _ProjectListItemState createState() => _ProjectListItemState();
}

class _ProjectListItemState extends ConsumerState<ProjectListItem> {
  @override
  Widget build(BuildContext context) {
    final streamProv = ref.watch(projectStreamProvider(widget.projectId));
    return streamProv.when(
      data: (Project project){
        return ProjectListItemContent(project: project, isShowRoomEnterBtn: false,);
      }, error:((error, stackTrace) {
        return Text("error = \n${error.toString()}");
      }), 
      loading: () => Container()
    );
  }
}

class ProjectListItemContent extends StatelessWidget{
  final Project project;
  final bool isShowRoomEnterBtn;

  ProjectListItemContent({required this.project, required this.isShowRoomEnterBtn});

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return IntrinsicHeight(
      child: Card(
        color: const Color.fromARGB(255, 255, 255, 255),
        elevation: 2,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return ProjectDetailFragment(
                project: project,
                bookmarkTapped: (){},
              );
            }));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StandartPaddingComponent(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal:size.width * 0.018),
                child: Text(
                  project.title,
                  textScaler: const TextScaler.linear(1.5),
                ),
              ),
              ProjectListItemHashtagListComponent(project.hashtags),
              Padding(padding: EdgeInsets.all(size.height * 0.01)),
              Row(
                children: [
                  ProjectListItemImgComponent(project.thumbnailUrl),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProjectListItemGoalComponent(
                          project.moneyGoal,
                          project.moneyDonated
                        ),
                        ProjectListItemNumberesConponent(
                          project.donaters.length,
                          project.members.length
                        )
                      ],
                    ),
                  )
                ],
              ),
              StandartPaddingComponent(),
              if(isShowRoomEnterBtn && project.roomID != null) Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RadiusTextComponent(
                        "共同制作部屋に入る",
                        widthRatio: 0.7,
                        textTapped: () {
                          final roomController = RoomController();
                          roomController.enterChatRoom(project.roomID!, context);
                        },
                      ),
                      SizedBox(width: size.width * 0.05),
                    ],
                  ),
                  StandartPaddingComponent()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}