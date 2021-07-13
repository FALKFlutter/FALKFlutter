import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class OAuthButton extends StatelessWidget {
  final dynamic iconImage;
  final String text;
  double padding;
  double iconSpacing;
  void Function() pressCallback;
  OAuthButton(Key? key, this.iconImage, this.text, {this.padding = 20.0, required this.pressCallback, this.iconSpacing = 0.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(20.0, this.padding, 20.0, this.padding),
        child: TextButton(
            onPressed:  this.pressCallback,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                this.iconImage,
                SizedBox(width: 20 + this.iconSpacing),
                Text(
                  this.text,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )
              ],
            ),
            style: ButtonStyle(
                overlayColor:
                    MaterialStateProperty.resolveWith((_) => Colors.grey[300]),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.fromLTRB(30, 15, 30, 15)),
                backgroundColor:
                    MaterialStateProperty.resolveWith((_) => Colors.white),
                foregroundColor:
                    MaterialStateProperty.resolveWith((_) => Colors.black),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                )))));
  }
}
