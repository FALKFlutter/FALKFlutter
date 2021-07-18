import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/colors/FalkColors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frontend/screens/screens.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class SplashScreen extends StatelessWidget {
  int duration = 3;
  dynamic goToPage;
  SplashScreen(Key? key, this.duration) : super(key: key);
  @override
  late Box<dynamic> mainData;

  Future openBox() async {
    var dir = await getApplicationDocumentsDirectory();
    try {
      Hive.init(dir.path);
      this.mainData = await Hive.openBox('mainData');
    } catch (e) {
      print(e);
      return Future.value(false);
    }
    return Future.value(true);
  }

  Widget build(BuildContext context) {
    this.openBox().then((value) => {
          if (this.mainData.get('user') == null)
            {
              print('null'),
              Future.delayed(Duration(seconds: duration), () {
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) => new WelcomePage()), (Route<dynamic> route) => false);
              })
            }else{
              print('!null'),
              Future.delayed(Duration(seconds: duration), () {
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) => new TestScreen(null, this.mainData.get('user'))), (Route<dynamic> route) => false);
              })
            }
        });

    return Container(
        child: Stack(alignment: Alignment.center, children: [
      Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/img/heartbg.jpg',
                ),
                fit: BoxFit.cover,
                colorFilter:
                    ColorFilter.mode(Colors.black87, BlendMode.xor))),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/Icons/tiger.png',
            width: 90.0,
            color: Colors.white,
          ),
          SizedBox(height: 1),
          Text('FALK',
              style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 1.5,
                  decoration: TextDecoration.none,
                  fontSize: 28,
                  fontFamily: 'Poppins')),
          SizedBox(height: 100),
          const SpinKitCubeGrid(
            duration: Duration(milliseconds: 1000),
            color: Colors.white,
            size: 50.0,
          )
        ],
      ),
    ]));
  }
}
