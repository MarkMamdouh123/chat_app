import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/views/chat_view.dart';
import 'package:scholar_chat/views/register_view.dart';
import 'package:scholar_chat/widgets/custom_text_field_widget.dart';

import '../constants.dart';
import '../helper/show_snack_bar.dart';
import '../widgets/custom_button.dart';

class LoginView extends StatefulWidget {
  static const String routeName = "login_view";

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String? email;

  String? password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    child: Image(
                      image: AssetImage("assets/images/scholar.png"),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "Chat App",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontFamily: "pacifico"),
                  ),
                ),
                Text(
                  "LOGIN",
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextFormFieldWidget(
                  hintText: "Email",
                  onChange: (message) {
                    email = message;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextFormFieldWidget(
                  hintText: "Password",
                  onChange: (message) {
                    password = message;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                  buttonText: "LOGIN",
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        await loginUser();
                        showSnackBar(context, message: "Login Successfully");
                        Navigator.pushNamed(context, ChatView.routeName);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'invalid-credential') {
                          showSnackBar(context,
                              message: "Wrong password or email");
                        } else if (e.code == 'user-not-found') {
                          showSnackBar(context, message: "user-not-found");
                        } else if (e.code == 'wrong-password') {
                          showSnackBar(context, message: "Wrong password only");
                        }
                      }
                    }
                    setState(() {
                      isLoading = false;
                    });
                  },
                ),
                Row(
                  children: [
                    Text(
                      "Don't Have An Account?   ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterView.routeName);
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
