import 'package:flutter/material.dart';

class FALKTextBox extends StatelessWidget {
  FALKTextBox(this.valController, this.size, this.hintText, this.icon, {Key? key, TextInputAction this.textAction = TextInputAction.done}) : super(key: key);
  TextInputAction textAction;
  TextEditingController valController;
  final double size;
  final String hintText;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.size,
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(10, 5, 5, 10),
      decoration: BoxDecoration(
          color: Colors.grey[500]?.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16.0)),
      child: TextFormField(
        controller: this.valController,
        cursorColor: Colors.white,
        style:
            TextStyle(color: Colors.white, fontFamily: 'Poppins', fontSize: 20),
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: this.hintText,
            icon: this.icon,
            hintStyle: TextStyle(color: Colors.white, fontSize: 20)),
        textInputAction: this.textAction,
      ),
    );
  }
}
