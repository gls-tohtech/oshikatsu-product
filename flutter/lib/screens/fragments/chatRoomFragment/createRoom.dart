import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:oshikatsu_product/controllers/UserController.dart';
import 'package:oshikatsu_product/controllers/roomController.dart';
import 'package:oshikatsu_product/screens/fragments/chatRoomFragment/chat.dart';

const colors = [
  Color(0xffff6767),
  Color(0xff66e0da),
  Color(0xfff5a2d9),
  Color(0xfff0c722),
  Color(0xff6a85e5),
  Color(0xfffd9a6f),
  Color(0xff92db6e),
  Color(0xff73b8e5),
  Color(0xfffd7590),
  Color(0xffc78ae5),
];

Color getUserAvatarNameColor(types.User user) {
  final index = user.id.hashCode % colors.length;
  return colors[index];
}

String getUserName(types.User user) =>
    '${user.firstName ?? ''} ${user.lastName ?? ''}'.trim();

class CreateRoomFragment extends StatefulWidget {
  const CreateRoomFragment({super.key});

  @override
  State<CreateRoomFragment> createState() => _CreateRoomFragmentState();
}

class _CreateRoomFragmentState extends State<CreateRoomFragment> {
  FocusNode? _focusNode;
  TextEditingController? _roomNameController;
  bool _creating = false;

  final UserController _userController = UserController();
  final RoomController _roomController = RoomController();

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _roomNameController = TextEditingController();
  }

  Widget _buildAvatar(types.User user) {
    final color = getUserAvatarNameColor(user);
    final hasImage = user.imageUrl != null;
    final name = getUserName(user);

    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: CircleAvatar(
        backgroundColor: hasImage ? Colors.transparent : color,
        backgroundImage: hasImage ? NetworkImage(user.imageUrl!) : null,
        radius: 20,
        child: !hasImage
            ? Text(
                name.isEmpty ? '' : name[0].toUpperCase(),
                style: const TextStyle(color: Colors.white),
              )
            : null,
      ),
    );
  }

  void _createRoom() async {
    FocusScope.of(context).unfocus();

    setState(() {
      _creating = true;
    });

    try {
      if(_userController.uid == null) return;
      final types.User user = types.User(id: _userController.uid!);

      final roomName = _roomNameController!.text;
      await _roomController.createGroupRoom(roomName, [_userController.uid!]);

      if (!mounted) return;
      Navigator.of(context).pop();
    } catch (e) {
      setState(() {
        _creating = false;
      });

      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
          content: Text(
            e.toString(),
          ),
          title: const Text('Error'),
        ),
      );
    }
  }

  @override
  void dispose() {
    _focusNode?.dispose();
    _roomNameController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          title: const Text('Create Room'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 80, left: 24, right: 24),
            child: Column(
              children: [
                TextField(
                  autocorrect: false,
                  autofocus: true,
                  controller: _roomNameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    labelText: 'Room Name',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.cancel),
                      onPressed: () => _roomNameController?.clear(),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onEditingComplete: () {
                    _focusNode?.requestFocus();
                  },
                  readOnly: _creating,
                  textCapitalization: TextCapitalization.none,
                  textInputAction: TextInputAction.next,
                ),
                TextButton(
                  onPressed: _creating ? null : _createRoom,
                  child: const Text('Create Room'),
                ),
              ],
            ),
          ),
        ),
      );
}
