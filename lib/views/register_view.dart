import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/constants.dart';

import '../helper/show_snack_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field_widget.dart';

class RegisterView extends StatefulWidget {
  static const String routeName = "register_view";

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
                  "Register",
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
                  buttonText: "Register",
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        await registerUser();

                        showSnackBar(context,
                            message: "Email Created Successfully");
                        Navigator.pop(context);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnackBar(context, message: "Weak password");
                        } else if (e.code == 'email-already-in-use') {
                          showSnackBar(context,
                              message: "email-already-in-use");
                        }
                      } catch (e) {
                        showSnackBar(context, message: "ERROR");
                      }
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                ),
                Row(
                  children: [
                    Text(
                      "Already Have An Account?   ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Login",
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

  Future<void> registerUser() async {
    UserCredential userCreditintials = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
