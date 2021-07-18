import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/functions/FunctionVars.dart';
import 'package:http/http.dart' as http;
class EmailAuth {
  final String email;
  final String password;
  late String name;
  late String provider;
  late String country;
  late DateTime age;
  EmailAuth(this.email, this.password);
  EmailAuth.regAuth(this.name, this.email, this.password, this.provider, this.country, this.age);
  Future<dynamic> login() async{
    final String url = FunctionVars.baseUrl + '/login';
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
  Future<dynamic> register() async {
    final String url = FunctionVars.baseUrl + '/register';
    if(!EmailValidator.validate(this.email)){
      Fluttertoast.showToast(msg: "Please provide a normal email");
      return Future.value(false);
    }
    var response = await http.post(Uri.parse(url), body: {
      'name': this.name,
      'email': this.email,
      'password': this.password,
      'country': this.country,
      'provider': this.provider,
      'dateOfBirth': this.age.toString()
    });
    print({
      'name': this.name,
      'email': this.email,
      'password': this.password,
      'country': this.country,
      'provider': this.provider,
      'dateOfBirth': this.age.toString()
    });
    var jsonBody = jsonDecode(response.body);
    if(response.statusCode < 200 || response.statusCode > 300){
      Fluttertoast.showToast(msg: jsonBody['error']);
    }else{
      Fluttertoast.showToast(msg: jsonBody['message']);
    }
  }
}