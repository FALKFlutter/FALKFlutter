import 'package:flutter/material.dart';
import 'package:frontend/colors/FalkColors.dart';
class SplashScreen extends StatelessWidget {
  int duration = 3;
  Widget goToPage;
  SplashScreen(Key? key, this.duration, this.goToPage) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: duration), (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => this.goToPage));
    });
    return Container(
        color: FalkColors.MAIN,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/Icons/tiger.png',
              width: 90.0,
            ),
            SizedBox(height: 1),
            Text('FALK',style: TextStyle(color: Colors.white, letterSpacing: 1.5, decoration: TextDecoration.none, fontSize: 28, fontFamily: 'Poppins'))
          ],
        ));
  }
}
