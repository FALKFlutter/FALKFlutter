import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frontend/colors/FalkColors.dart';
import 'package:frontend/functions/EmailAuth.dart';
import 'package:frontend/screens/screens.dart';
import 'package:frontend/widgets/widgets.dart';

class EmailRegister extends StatefulWidget {
  @override
  EmailRegisterForm createState() => EmailRegisterForm();
}

class EmailRegisterForm extends State<EmailRegister> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  bool isLoading = false;
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
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
                      'assets/img/heartbg.jpg',
                    ),
                    fit: BoxFit.cover,
                    colorFilter:
                        ColorFilter.mode(Colors.black87, BlendMode.darken))),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: FALKTextBox(
                nameController,
                size.width * 0.85,
                'Name',
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
                      new EmailAuth.regAuth(nameController.text,
                              emailController.text, passwordController.text)
                          .register()
                          .whenComplete(() => setState(() {
                                isLoading = false;
                              }));
                    },
                    child: Text(
                      'Register',
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
              SizedBox(height: size.height * 0.01,),
                  TextButton(onPressed: (){
                    Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context) => EmailSignUp()));
                  },child: Text('Login with your email', style: TextStyle(fontFamily: 'Poppins', color: Colors.white),)),
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
