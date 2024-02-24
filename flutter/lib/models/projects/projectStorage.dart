import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

const PROJECT_IMAGE_STORAGE = "PROJECT_IMAGE_STORAGE";

class ProjectImageUploader{
    Future<String?> uploadImageAndFetchUrl() async {
    final _ProjectStorageController storageController = _ProjectStorageController();
    final File? pickedImageFile = await _pickImageFromLocal();

    if(pickedImageFile == null) return null;

    String imageUrl = await storageController.uploadAndFetchImageUrl(imageFile: pickedImageFile);
    return imageUrl;
  }
  

  Future<File?> _pickImageFromLocal() async {
    final pickerFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickerFile == null) return null;

    File file = File(pickerFile.path);

    return file;
  }
}

class _ProjectStorageController{
  final FirebaseStorage _STORAGE = FirebaseStorage.instance;

  Future<String> uploadAndFetchImageUrl({required File imageFile}) async {
    String uniqueId = imageFile.hashCode.toString();
    String fileName = "$uniqueId-$imageFile".replaceAll(RegExp("/"), "").replaceAll(RegExp("'"), "");

    String filePath = "$PROJECT_IMAGE_STORAGE/$fileName";

    try{
      await _STORAGE.ref(filePath).putFile(imageFile);
    }
    catch(e){
      print(e);
    }

    String imageUrl = await _fetchImageUrlFromFireStorage(path: fileName);
    return imageUrl;
  } 

  Future<String> _fetchImageUrlFromFireStorage({required String path}) async {
    Reference imageRef = _STORAGE.ref().child(PROJECT_IMAGE_STORAGE).child(path);
    String imageUrl = await imageRef.getDownloadURL();

    return imageUrl;
  }
}