import 'package:google_sign_in/google_sign_in.dart';
class GoogleAuthFALK {
   static final _googleSignIn = GoogleSignIn();
   static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();
}