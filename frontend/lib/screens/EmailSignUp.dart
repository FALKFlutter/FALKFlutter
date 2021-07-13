import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frontend/colors/FalkColors.dart';
import 'package:frontend/functions/EmailAuth.dart';
import 'package:frontend/widgets/widgets.dart';

class EmailSignUp extends StatefulWidget {
  @override
  EmailForm createState() => EmailForm();
}

class EmailForm extends State<EmailSignUp> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'assets/img/loginbackground.jpg',
                    ),
                    fit: BoxFit.cover,
                    colorFilter:
                        ColorFilter.mode(Colors.black54, BlendMode.darken))),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: FALKTextBox(
                emailController,
                size.width * 0.85,
                'Email',
                Icon(
                  Icons.email_outlined,
                  color: Colors.white,
                  size: 28,
                ),
                textAction: TextInputAction.next,
              )),
              SizedBox(
                height: size.height * 0.03,
              ),
              Center(
                  child: FALKTextBox(
                passwordController,
                size.width * 0.85,
                'Password',
                Icon(
                  Icons.lock_outline,
                  color: Colors.white,
                  size: 28,
                ),
              )),
              SizedBox(
                height: size.height * 0.03,
              ),
              Container(
                width: size.width * 0.8,
                child: TextButton(
                    onPressed: () {
                      setState(() {
                        isLoading = true;
                      });
                      new EmailAuth(
                              emailController.text, passwordController.text)
                          .login()
                          .whenComplete(() => setState(() {
                                isLoading = false;
                              }));
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'Poppins'),
                    ),
                    style: ButtonStyle(
                        overlayColor: MaterialStateProperty.resolveWith(
                            (_) => FalkColors.MAIN.withAlpha(180)),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.fromLTRB(30, 15, 30, 15)),
                        backgroundColor: MaterialStateProperty.resolveWith(
                            (_) => FalkColors.MAIN.withOpacity(0.8)),
                        foregroundColor: MaterialStateProperty.resolveWith(
                            (_) => Colors.black),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        )))),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Visibility(
                visible: isLoading,
                child: SpinKitCubeGrid(
                  duration: Duration(milliseconds: 500),
                  color: Colors.white,
                  size: 50.0,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
