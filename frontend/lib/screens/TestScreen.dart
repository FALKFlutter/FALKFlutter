import 'package:flutter/material.dart';
import 'package:frontend/screens/screens.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/adapters.dart';

class TestScreen extends StatelessWidget {
  dynamic user;
  final String noImage =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/600px-No_image_available.svg.png';
  TestScreen(Key? key, dynamic this.user) : super(key: key);

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
                this.user['photoUrl'] ?? this.noImage,
                width: 100.0,
                height: 100.0,
              )),
          SizedBox(height: 50.0),
          Text(
            'Hello ${this.user['displayName']}! How are you?',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                decoration: TextDecoration.none,
                fontFamily: 'Poppins'),
          ),
          SizedBox(
            height: 100,
          ),
          TextButton(
            onPressed: () async {
              await Hive.box('mainData').delete('user');
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context) => WelcomePage()), (Route<dynamic> route) => false);
            },
            child: Text('Logout',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 18.0,
                    decoration: TextDecoration.none)),
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.resolveWith((_) => Colors.red[400])),
          )
        ],
      ),
    );
  }
}
