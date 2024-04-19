import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oshikatsu_product/models/projects/project.dart';
import 'package:oshikatsu_product/providers/projectProvider.dart';
import 'package:oshikatsu_product/widgets/userProfileLabel.dart';

class SwipeUI extends ConsumerStatefulWidget {
  const SwipeUI({super.key});

  @override
  SwipeUIContentsState createState() => SwipeUIContentsState();
}

class SwipeUIContentsState extends ConsumerState<SwipeUI> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final streamProv = ref.watch(projectsStreamProvider);
    return Scaffold(
      body: streamProv.when(
        data: (List<Project> projects){
          return SwipeUIContents(projects: projects);
        }, error:((error, stackTrace) {
          return Text("エラーが発生しました");
        }), 
        loading: () => const CircularProgressIndicator()
      )
    );
  }
}

class SwipeUIContents extends StatefulWidget {
  final List<Project> projects;

  const SwipeUIContents({required this.projects});

  @override
  _SwipeUIContentsState createState() => _SwipeUIContentsState();
}

class _SwipeUIContentsState extends State<SwipeUIContents> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: PageView.builder(
        itemCount: widget.projects.length,
        scrollDirection: Axis.vertical, // 縦方向にスワイプ
        itemBuilder: (context, index) {
          Project project = widget.projects[index];
          return Container(
              color: Colors.grey,
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                    child: project.thumbnailUrl != ""
                    ? Image.network(
                      project.thumbnailUrl, 
                      fit: BoxFit.fitWidth
                    )
                    : Image.network(
                      "https://firebasestorage.googleapis.com/v0/b/oshikatsu-dev-8bb0d.appspot.com/o/PROJECT_IMAGE_STORAGE%2Fimage%20(1).png?alt=media&token=df4deb2e-66b4-4dbc-87b7-9d29cfa4236c",
                      fit: BoxFit.fitWidth
                    ),
                  ),
                  project.thumbnailUrl != ""
                    ? Image.network(
                      project.thumbnailUrl, 
                      fit: BoxFit.fitWidth
                    )
                    : Image.network(
                      "https://firebasestorage.googleapis.com/v0/b/oshikatsu-dev-8bb0d.appspot.com/o/PROJECT_IMAGE_STORAGE%2Fimage%20(1).png?alt=media&token=df4deb2e-66b4-4dbc-87b7-9d29cfa4236c",
                      fit: BoxFit.fitWidth
                    ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      height: 120,
                      width: size.width,
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            style: const TextStyle(
                              fontWeight: FontWeight.bold, 
                              fontSize: 16,
                              color: Colors.white
                            ),
                            overflow: TextOverflow.ellipsis,
                            project.title,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            child: Row(
                              children: [
                                const Text(
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Colors.white
                                  ),
                                  "オーナー",
                                ),
                                const SizedBox(width: 20),
                                FittedBox(
                                  fit:BoxFit.none,
                                  child: UserProfileLabelComponent(
                                    userRef: project.createdBy, 
                                    widthRatio: 0.5
                                  )
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ));
        },
      ),
    );
  }
}


// class Post {
//   String imageUrl;
//   String avatarUrl;
//   String avatarName;
//   String projectName;
//   String description;

//   Post({required this.imageUrl, required this.avatarUrl, required this.avatarName, required this.projectName, required this.description});
// }


// // https://kotonohaworks.com/free-icons/user/