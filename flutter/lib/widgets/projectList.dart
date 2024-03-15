import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oshikatsu_product/models/projects/project.dart';
import 'package:oshikatsu_product/providers/projectProvider.dart';
import 'package:oshikatsu_product/widgets/projectListItemComponent/projectListItemCom.dart';
import 'package:oshikatsu_product/widgets/standardPadding.dart';

class ProjectList extends ConsumerStatefulWidget {
  const ProjectList({super.key});

  @override
  _ProjectListState createState() => _ProjectListState();
}

class _ProjectListState extends ConsumerState<ProjectList> {
  @override
  Widget build(BuildContext context) {
    final streamProv = ref.watch(projectsStreamProvider);
    return Scaffold(
      body: streamProv.when(
        data: (List<Project> ad){
          return SingleChildScrollView(
            child: Column(
              children: [
                for(Project item in ad) Column(
                  children: [
                    StandartPaddingComponent(),
                    ProjectListItem(projectId: item.projectId, isShowRoomEnterBtn: true),
                  ],
                )
              ],
            ),
          );
        }, error:((error, stackTrace) {
          return ;
        }), 
        loading: () => Container(),
      )
    );
  }
}

class ProjectRecommender{

}