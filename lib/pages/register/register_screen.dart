import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/pages/login/login_screen.dart';
import 'package:news_app/pages/register/dialog_utils.dart';

import '../../model/validation.dart';
import 'custom_form_field.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "register";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var firstNameController = TextEditingController();

  var lastNameController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var confirmpasswordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      alignment: Alignment.topCenter,
      decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage("assets/images/pattern.png"),
            fit: BoxFit.fill,
          )),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff39A552),
          title: Text("Register",
              style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Image(image: AssetImage("assets/images/logo.png")),
                  SizedBox(
                    height: height * 0.07,
                  ),
                  CustomFormField(
                    controller: firstNameController,
                    Validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return "Please Enter First Name";
                      }
                      return null;
                    },
                    title: "First Name",
                    textInputType: TextInputType.name,
                  ),
                  CustomFormField(
                    controller: lastNameController,
                    Validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return "Please Enter Last Name";
                      }
                      return null;
                    },
                    title: "Last Name",
                    textInputType: TextInputType.name,
                  ),
                  CustomFormField(
                    controller: emailController,
                    Validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return "Please Enter E-mail Address";
                      }
                      if (!Validation.isvalid(text)) {
                        return "please enter a valid email";
                      }
                    },
                    title: "E-mail Address",
                    textInputType: TextInputType.emailAddress,
                  ),
                  CustomFormField(
                    controller: passwordController,
                    Validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return "Please Enter password";
                      }
                      if (text.length < 8)
                        return "password at lest 8 character";
                    },
                    title: "Password",
                    textInputType: TextInputType.text,
                    isSecure: true,
                  ),
                  CustomFormField(
                    controller: confirmpasswordController,
                    Validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return "Please confirm password";
                      }
                      if (passwordController.text != text)
                        return "password doesn't match";
                    },
                    title: "Confirm Password",
                    textInputType: TextInputType.text,
                    isSecure: true,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff39A552),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 100),
                    ),
                    onPressed: () {
                      register();
                    },
                    child: Text(
                      "Register",
                      style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, LoginScreen.routeName);
                      },
                      child: Text("Already have account "))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  FirebaseAuth authservice = FirebaseAuth.instance;

  void register() async {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    DialogUtils.ShowLoadingDialog(context, 'Loading...');
    // await Future.delayed(Duration(seconds: 3));
    try {
      var reslut = await authservice.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      DialogUtils.hideDialog(context);
      DialogUtils.ShowMessage(context, 'Sucesse');
      Navigator.pushNamed(context, LoginScreen.routeName);
    } on FirebaseAuthException catch (e) {
      DialogUtils.hideDialog(context);
      String errorMessage = 'Something went wrong..';
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      }
      DialogUtils.ShowMessage(context, errorMessage, postActionName: 'ok');
    } catch (e) {
      DialogUtils.hideDialog(context);
      String errorMessage = 'Something went wrong..';
      DialogUtils.ShowMessage(
        context,
        errorMessage,
        postActionName: 'cansel',
        nagActionName: 'try again',
        nagAction: () {
          register();
        },
      );
    }
  }
}
