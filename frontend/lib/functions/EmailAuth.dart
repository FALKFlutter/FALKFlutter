import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
class EmailAuth {
  final String email;
  final String password;

  const EmailAuth(this.email, this.password);

  Future<dynamic> login() async{
    String url = 'https://falkbackend.herokuapp.com/login';
    var response = await http.post(Uri.parse(url), body: {
      'email': this.email,
      'password': this.password
    });
    print(jsonEncode(<String, String>{
      'email': this.email,
      'password': this.password
    }));
    var jsonBody = jsonDecode(response.body);
    if(response.statusCode < 200 || response.statusCode > 300){
      Fluttertoast.showToast(msg: jsonBody['error']);
    }else{
      Fluttertoast.showToast(msg: jsonBody['message']);
    }
  }
}