import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerManager{
  Future<File?> pickImageFromLocal() async {
    try{
      final pickerFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(pickerFile == null) return null;

      File file = File(pickerFile.path);

      return file;
    }
    catch(e){
      return null;
    }
  }
}