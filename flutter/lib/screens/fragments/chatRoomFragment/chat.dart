import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:oshikatsu_product/controllers/chatController.dart';
import 'package:oshikatsu_product/utils/convertRefFromUser.dart';
import 'package:oshikatsu_product/utils/duplidatesRemover.dart';
import 'package:oshikatsu_product/widgets/standardPadding.dart';
import 'package:oshikatsu_product/widgets/userProfileLabel.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    required this.room,
  });

  final types.Room room;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool _isAttachmentUploading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final ChatController _chatController = ChatController();

  void _openDrawer() => _scaffoldKey.currentState!.openDrawer();
  void _closeDrawer() => _scaffoldKey.currentState!.closeDrawer();

  void _handleAtachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: SizedBox(
          height: 144,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleImageSelection();
                },
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Photo'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleFileSelection();
                },
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('File'),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Cancel'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleFileSelection() async {
    _setAttachmentUploading(true);
    _chatController.handleFileSelection(widget.room);
    _setAttachmentUploading(false);
  }

  void _handleImageSelection() async {
    _setAttachmentUploading(true);
    _chatController.handleImageSelection(widget.room);
    _setAttachmentUploading(false);
  }

  void _handleMessageTap(BuildContext _, types.Message message) async {
    _chatController.handleMessageTap(_, message, widget.room);
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    _chatController.handlePreviewDataFetched(message, previewData, widget.room);
  }

  void _handleSendPressed(types.PartialText message) {
    _chatController.handleSendPressed(message, widget.room);
  }

  void _setAttachmentUploading(bool uploading) {
    setState(() {
      _isAttachmentUploading = uploading;
    });
  }

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    final List<types.User> users = widget.room.users.removeDuplicates as List<types.User>;
    final List<DocumentReference> usersRef = users.convertRefFromUser();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: Text(widget.room.name ?? "chat"),
        actions: [
          IconButton(
            onPressed: _openDrawer,
            icon: const Icon(Icons.menu)
          )
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          }, 
          icon: const Icon(Icons.arrow_back)
        ),
      ),
      body: StreamBuilder<types.Room>(
        initialData: widget.room,
        stream: FirebaseChatCore.instance.room(widget.room.id),
        builder: (context, snapshot) => StreamBuilder<List<types.Message>>(
          initialData: const [],
          stream: FirebaseChatCore.instance.messages(snapshot.data!),
          builder: (context, snapshot) => Chat(
            isAttachmentUploading: _isAttachmentUploading,
            messages: snapshot.data ?? [],
            onAttachmentPressed: _handleAtachmentPressed,
            onMessageTap: _handleMessageTap,
            onPreviewDataFetched: _handlePreviewDataFetched,
            onSendPressed: _handleSendPressed,
            user: types.User(
              id: FirebaseChatCore.instance.firebaseUser?.uid ?? '',
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            StandartPaddingComponent(),
            Icon(
              Icons.settings,
              size: size.width * 0.2,
            ),
            StandartPaddingComponent(),
            const Text(
              "メニュー",
              style: TextStyle(fontSize: 32),
            ),
            StandartPaddingComponent(),
            buildDrawerItem(
              () { }, 
              Icons.person, 
              "メンバ一覧"
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: size.height * 0.005),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for(DocumentReference userRef in usersRef) UserProfileLabelComponent(
                      userRef: userRef, 
                      widthRatio: 0.7
                    ),
                  ],
                )
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDrawerItem(Function() onPressed, IconData iconData, String rowText){
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(size.width * 0.01),
      child: InkWell(
        onTap: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 50,
            ),
            const SizedBox(
              width: 8,
            ),
            Flexible(
              child: Text(
                rowText,
                style: const TextStyle(fontSize: 20),
              )
            )
          ],
        ),
      ),
    );
  }
}