import 'package:oshikatsu_product/models/projects/project.dart';
import 'package:oshikatsu_product/models/projects/projectStorage.dart';
import 'package:oshikatsu_product/models/projects/projectStore.dart';

class ProjectController{
  final ProjectRegistry _registry = ProjectRegistry();
  final ProjectDataFetcher _fetcher = ProjectDataFetcher();
  final ProjectImageUploader _uploader = ProjectImageUploader();

  Future<String> pickImageAndUpload() async {
    final String imageUrl = await _uploader.uploadImageAndFetchUrl() ?? "";
    return imageUrl;
  }

  Future<void> addToStorage({required Project newProjectDataArg}) async {
    _registry.add(newProjectData: newProjectDataArg);
  }

  Future<void> updateTotalMoneyAmount({required Project existedProjectInfo, required String aiderName, required int additionalMoney}) async {
    List<String> donaters = existedProjectInfo.dbProcessedMap[ProjectTableColumn.DONATERS.name].split(",");;
    if (!donaters.contains(aiderName)) donaters.add(aiderName);
    
    final Project newProjectInfo = Project(
      createdAt: existedProjectInfo.createdAt,
      createdBy: existedProjectInfo.createdBy,
      admins: existedProjectInfo.admins,
      members: existedProjectInfo.members,
      donaters: existedProjectInfo.donaters,
      title: existedProjectInfo.title,
      discription: existedProjectInfo.discription,
      deadline: existedProjectInfo.deadline,
      hashtags: existedProjectInfo.hashtags,
      thumbnailUrl: existedProjectInfo.thumbnailUrl,
      moneyGoal: existedProjectInfo.moneyGoal,
      moneyDonated: existedProjectInfo.moneyDonated
    );

    _registry.update(newProjectData: newProjectInfo);
  }

  Future<void> fetchFromStorage({required String projectId}) async {
    _fetcher.fetch(targetProjectId: projectId);
  }
}