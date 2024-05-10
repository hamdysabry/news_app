import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/pages/home_page.dart';
import 'package:news_app/pages/register/register_screen.dart';
import 'package:news_app/pages/splash.dart';

import '../../model/validation.dart';
import '../register/custom_form_field.dart';
import '../register/dialog_utils.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = "Login screen";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage("assets/images/pattern.png"),
            fit: BoxFit.fill,
          )),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff39A552),
          title: Text("Login",
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
                    height: height * 0.1,
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
                      Login();
                    },
                    child: Text(
                      "Login",
                      style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, RegisterScreen.routeName);
                      },
                      child: Text("Don't have account?"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  FirebaseAuth authservice = FirebaseAuth.instance;

  void Login() async {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    DialogUtils.ShowLoadingDialog(context, 'Loading...');
    // await Future.delayed(Duration(seconds: 3));
    try {
      var reslut = await authservice.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      DialogUtils.hideDialog(context);
      DialogUtils.ShowMessage(context, 'Sucessfull login');
      Navigator.pushReplacementNamed(context, homeScreen.routeName);
    } on FirebaseAuthException catch (e) {
      DialogUtils.hideDialog(context);
      String errorMessage = ' wrong email or password';
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
          Login();
        },
      );
    }
  }
}
