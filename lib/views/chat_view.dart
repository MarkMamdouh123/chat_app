import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/models/message_model.dart';

import '../widgets/chat_bubble.dart';

class ChatView extends StatefulWidget {
  static const String routeName = "chat_view";

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  String? val;

  bool showSuffixIcon = false;

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessageCollection);

  TextEditingController? controller = TextEditingController();

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    String id = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              kLogoImagePath,
              height: 65,
            ),
            Text(
              "Chat",
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
          builder: (context, snapshot) {
            List<MessageModel> messageList = [];
            if (snapshot.hasData) {
              for (int i = 0; i < snapshot.data!.docs.length; i++)
                messageList.add(MessageModel.fromJson(snapshot.data!.docs[i]));
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: scrollController,
                      itemCount: messageList.length,
                      itemBuilder: (context, index) {
                        return messageList[index].id == id
                            ? ChatBubble(
                                id: id,
                                message: messageList[index],
                                alignment: Alignment.centerLeft,
                                color: kPrimaryColor,
                              )
                            : ChatBubble(
                                id: id,
                                message: messageList[index],
                                alignment: Alignment.centerRight,
                                color: Colors.cyan,
                              );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: TextField(
                      controller: controller,
                      onChanged: (value) {
                        val = value;
                        messageInputChanged();
                      },
                      decoration: InputDecoration(
                        hintText: "Enter your text",
                        suffixIcon: showSuffixIcon
                            ? IconButton(
                                icon: Icon(
                                  Icons.send,
                                  color: kPrimaryColor,
                                ),
                                onPressed: () {
                                  messages.add({
                                    kMessageDocument: val,
                                    kCreatedAt: DateTime.now(),
                                    'id': id
                                  });
                                  controller!.clear();
                                  messageInputChanged();
                                  val = "";

                                  scrollController.animateTo(0,
                                      duration: Duration(seconds: 1),
                                      curve: Curves.fastLinearToSlowEaseIn);
                                },
                              )
                            : SizedBox(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                      ),
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  void messageInputChanged() {
    if (controller!.text.isNotEmpty) {
      showSuffixIcon = true;
    } else {
      showSuffixIcon = false;
    }

    setState(() {});
  }
}
