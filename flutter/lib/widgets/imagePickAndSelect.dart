import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';
import 'package:oshikatsu_product/models/users/userIcon.dart';
import 'package:oshikatsu_product/settings/appColors.dart';
import 'package:oshikatsu_product/utils/pictureBoundaryConverter.dart';
import 'package:oshikatsu_product/utils/showDialog.dart';
import 'package:oshikatsu_product/widgets/verticalPadding.dart';

class ImagePickAndselectWidget extends StatefulWidget {
  final Function(ImageProvider?) closeFragmentCallback;

  const ImagePickAndselectWidget({super.key, required this.closeFragmentCallback});

  @override
  _ImagePickAndselectWidgetState createState() => _ImagePickAndselectWidgetState();
}

class _ImagePickAndselectWidgetState extends State<ImagePickAndselectWidget> {
  final _globalKey = GlobalKey();
  final _converter = PictureBinaryConverter();
  final _manager = UserIconManager();

  String _selectedPath = "";
  ImageProvider? _editedImage;
  Matrix4 transform = Matrix4.identity();

  void _initValue(){
    setState(() {
      transform = Matrix4.identity();
    });
  }

  void _setImage() async {
    final File? selectedFile = await _manager.pickImageFromLocal();
    if(selectedFile == null) {
      showWarnDialog(context, "画像の取得に失敗しました。");
      return;
    }

    setState(() {
      _selectedPath = selectedFile.path;
    });
  }

  Future<ImageProvider> _captureImage() async {
    RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    String imageDataBinary = await _converter.convertBoundaryToImageBase64(boundary);
    ImageProvider image = _converter.convertBase64ToImage(imageDataBinary);
    return image;
 }

  Widget _buildPicture(){
    return MatrixGestureDetector(
      onMatrixUpdate: (matrix, translationDeltaMatrix, scaleDeltaMatrix, rotationDeltaMatrix) {
        setState(() {
          transform = matrix;
        });
      },
      child: Transform(
        transform: transform,
        child: _selectedPath != ""
          ? Image.file(File(_selectedPath))
          : const SizedBox(height: 10,width: 10,),
      ),
    );
  }

  Widget _buildButton(IconData iconData, Function() onPressed){
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16)
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Icon(
            iconData,
            size: 40,
            color: AppColors().primaryColor
          ),
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsetsDirectional.only(top: size.height * 0.1),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.1),
          child: Column(
            children: [
              const Text(
                "画像を選択して、アイコンを決定する。",
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
              VerticalPaddingWidget(
                paddingFactor: 0.6,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1000)
                    ),
                    elevation: 16,
                    child: SizedBox(
                      width: 300,
                      height: 289,
                      child: RepaintBoundary(
                          key: _globalKey,
                          child: ClipRRect(
                          borderRadius: BorderRadius.circular(1000),
                          child: _buildPicture(),
                        ),
                      ),
                    )
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildButton(Icons.arrow_back, () => widget.closeFragmentCallback(null)),
                  _buildButton(Icons.file_download, () async {
                    _setImage();
                    _initValue();
                  }),
                  _buildButton(Icons.restart_alt, () => _initValue() ),
                  _buildButton(Icons.check, () async {
                    _editedImage = await _captureImage();
                    if(_editedImage == null) return;
                    widget.closeFragmentCallback(_editedImage!);
                  }),
                ],
              )
            ],
          )
        ),
      ),
    );
  }
}