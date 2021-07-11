import 'package:flutter/material.dart';
import 'package:frontend/colors/FalkColors.dart';
import 'package:frontend/widgets/widgets.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Stack(
        children: [
          Positioned.fill(
              child: Opacity(
            opacity: 0.4,
            child: Image.asset(
              'assets/img/lovebackground.jpg',
              fit: BoxFit.cover,
            ),
          )),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: ClipOval(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      color: Color(0x9529CDFF),
                      width: 90,
                      height: 90,
                      child: Image.asset(
                        'assets/Icons/tiger.png',
                        width: 90.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 90),
                Text(
                  'Welcome',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      decoration: TextDecoration.none,
                      fontFamily: 'Poppins'),
                ),
                SizedBox(height: 2),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Create new friends or find your loved one!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w200,
                        decoration: TextDecoration.none,
                        fontFamily: 'Poppins'),
                  ),
                ),
                SizedBox(height: 50),
                OAuthButton(null, Image.asset('assets/Icons/GitHub-Mark-32px.png'), 'SIGN IN WITH GITHUB'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
