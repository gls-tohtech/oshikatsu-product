import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:oshikatsu_product/settings/tables.dart';
import 'package:oshikatsu_product/utils/imagePicker.dart';

class UserIconManager{
  final _STORAGE  = FirebaseStorage.instance;

  Future<File?> pickImageFromLocal() async {
    final File? pickedImageFile = await ImagePickerManager().pickImageFromLocal();

    if(pickedImageFile == null) return null;

    return pickedImageFile;
  }

  Future<String> uploadAndFetchImageUrl({required File imageFile}) async {
    String uniqueId = imageFile.hashCode.toString();
    String fileName = "$uniqueId-$imageFile".replaceAll(RegExp("/"), "").replaceAll(RegExp("'"), "");

    String filePath = "$USER_ICON_IMAGE/$fileName";

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
    Reference imageRef = _STORAGE.ref().child(USER_ICON_IMAGE).child(path);
    String imageUrl = await imageRef.getDownloadURL();

    return imageUrl;
  }
}
