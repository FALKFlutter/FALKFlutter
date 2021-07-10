import 'package:flutter/material.dart';
class WelcomePage extends StatelessWidget {
  const WelcomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text('Welcome', style: TextStyle(decoration: TextDecoration.none, color: Colors.green[300]),),
      ),
    );
  }
}
