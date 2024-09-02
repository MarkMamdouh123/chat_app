import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scholar_chat/constants.dart';

import '../widgets/chat_bubble.dart';

class ChatView extends StatelessWidget {
  static const String routeName = "chat_view";
  String? val;
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessageCollection);
  TextEditingController? controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
      body: FutureBuilder<QuerySnapshot>(
          future: messages.get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              for (int i = 0; i < snapshot.data!.docs.length; i++)
                print(snapshot.data!.docs[i]['message']);
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return ChatBubble(
                          alignment: Alignment.centerLeft,
                          color: kPrimaryColor,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: TextField(
                      controller: controller,
                      onSubmitted: (value) {
                        val = value;
                      },
                      decoration: InputDecoration(
                        hintText: "Enter your text",
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.send,
                            color: kPrimaryColor,
                          ),
                          onPressed: () {
                            messages.add({'message': val});
                            controller!.clear();
                          },
                        ),
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
              return CircularProgressIndicator();
            }
          }),
    );
  }
}
