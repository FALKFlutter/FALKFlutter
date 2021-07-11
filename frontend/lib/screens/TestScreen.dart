import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class TestScreen extends StatelessWidget {
  GoogleSignInAccount user;
  final String noImage =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/600px-No_image_available.svg.png';
  TestScreen(Key? key, GoogleSignInAccount this.user) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image.network(
                this.user.photoUrl ?? this.noImage,
                width: 100.0,
                height: 100.0,
              )),
              SizedBox(height: 50.0),
          Text(
            'Hello ${this.user.displayName}! How are you?',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                decoration: TextDecoration.none,
                fontFamily: 'Poppins'),
          ),
        ],
      ),
    );
  }
}
