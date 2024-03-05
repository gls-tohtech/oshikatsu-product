import 'package:flutter/material.dart';
import 'package:oshikatsu_product/models/projects/project.dart';
import 'package:oshikatsu_product/providers/projectProvider.dart';
import 'package:oshikatsu_product/screens/fragments/projectDetailFragment/projectDetailFragment.dart';
import 'package:oshikatsu_product/widgets/standardPadding.dart';
import 'projectListItemGoalCom.dart';
import 'projectListItemImgCom.dart';
import 'projectListItemNumbersCom.dart';
import 'projectListItemHashtagCom.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProjectListItem extends ConsumerStatefulWidget {
  late final String _projectId;

  ProjectListItem({required String projectId}){
    _projectId = projectId;
  }

  @override
  _ProjectListItemState createState() => _ProjectListItemState(_projectId);
}

class _ProjectListItemState extends ConsumerState<ProjectListItem> {
  late final String _projectId;

  _ProjectListItemState(String projectId){
    _projectId = projectId;
  }

  @override
  Widget build(BuildContext context) {
    final streamProv = ref.watch(projectStreamProvider(_projectId));
    return streamProv.when(
        data: (Project project){
          return buildProjectListItem(context, project);
        }, error:((error, stackTrace) {
          return Text("error = \n${error.toString()}");
        }), 
        loading: () => Container()
      );
  }

  Widget buildProjectListItem(BuildContext context, Project project){
    final Size size = MediaQuery.of(context).size;
    return IntrinsicHeight(
      child: Card(
        color: Color.fromARGB(255, 255, 255, 255),
        elevation: 4,
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
                  ProjectListItemImgComponent(project.thumbnailUrl,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
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
              StandartPaddingComponent()
            ],
          ),
        ),
      ),
    );
  }
}