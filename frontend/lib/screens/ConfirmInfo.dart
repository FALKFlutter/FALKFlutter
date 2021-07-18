import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frontend/colors/FalkColors.dart';
import 'package:frontend/functions/EmailAuth.dart';
import 'package:frontend/screens/screens.dart';
import 'package:frontend/widgets/FALKTextBox.dart';
import 'package:country_picker/country_picker.dart';

class ConfirmInfo extends StatefulWidget {
  final name;
  final email;
  final password;
  final provider;
  ConfirmInfo(this.name, this.email, this.password, this.provider,{Key? key})
      : super(key: key);

  @override
  _ConfirmInfoState createState() =>
      _ConfirmInfoState(this.name, this.email, this.password, this.provider);
}

class _ConfirmInfoState extends State<ConfirmInfo> {
  final name;
  final email;
  final password;
  final provider;
  late DateTime age;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String country = "Country";
  TextEditingController ageController = TextEditingController();
  bool _visible = true;
  _ConfirmInfoState(this.name, this.email, this.password, this.provider);
  @override
  Widget build(BuildContext context) {
    nameController.text = this.name;
    emailController.text = this.email;
    passwordController.text = this.password;
    Size size = MediaQuery.of(context).size;
    Future.delayed(Duration(milliseconds: 250), () {
      setState(() {
        _visible = false;
      });
    });
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
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.93), BlendMode.darken))),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: FALKTextBox(
                size.width * 0.85,
                'Name',
                Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 28,
                ),
                textAction: TextInputAction.next,
                valController: nameController,
              )),
              SizedBox(
                height: size.height * 0.03,
              ),
              Center(
                  child: FALKTextBox(
                size.width * 0.85,
                'Email',
                Icon(
                  Icons.email_outlined,
                  color: Colors.white,
                  size: 28,
                ),
                textAction: TextInputAction.next,
                valController: emailController,
              )),
              SizedBox(
                height: size.height * 0.03,
              ),
              Center(
                  child: FALKTextBox(
                size.width * 0.85,
                'Password',
                Icon(
                  Icons.lock_outline,
                  color: Colors.white,
                  size: 28,
                ),
                valController: passwordController,
              )),
              SizedBox(
                height: size.height * 0.03,
              ),
              AnimatedPadding(
                duration: Duration(seconds: 1),
                padding: _visible ? EdgeInsets.all(40) : EdgeInsets.all(0),
                curve: Curves.decelerate,
                child: FALKTextBox(
                    size.width * 0.85,
                    country,
                    Icon(
                      Icons.flag,
                      color: Colors.white,
                      size: 28,
                    ),
                    disabled: true, onClick: () {
                  showCountryPicker(
                    context: context,
                    showPhoneCode:
                        true, // optional. Shows phone code before the country name.
                    onSelect: (Country country) {
                      print('Select country: ${country.displayName}');
                      setState(() {
                        this.country = country.displayName.split(' ')[0];
                      });
                    },
                  );
                }),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Text('Age:',style: TextStyle(color: Colors.white, fontFamily: 'Poppins', fontSize: 18),),
              SizedBox(height: 10,),
              SizedBox(
                height: 90,
                width: size.width * 0.85,
                child: CupertinoTheme(
                  data: CupertinoThemeData(
                    brightness: Brightness.dark
                  ),
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: DateTime(2010),
                    onDateTimeChanged: (dateTime) => {
                      setState(() {
                        age = dateTime;
                        print(age);
                      })
                    },
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Container(
                width: size.width * 0.8,
                child: TextButton(
                    onPressed: () {
                      EmailAuth.regAuth(this.name, this.email, this.password, this.provider, this.country, this.age);
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
              SizedBox(
                height: size.height * 0.01,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => EmailSignUp()));
                  },
                  child: Text(
                    'Login with your email',
                    style:
                        TextStyle(fontFamily: 'Poppins', color: Colors.white),
                  )),
              SizedBox(
                height: size.height * 0.02,
              ),
            ],
          )
        ],
      ),
    );
  }
}
