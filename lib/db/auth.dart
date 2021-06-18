import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './users.dart';

abstract class BaseAuth {
  Future<FirebaseUser> googleSignIn();
}

class Auth implements BaseAuth {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  
  Firestore _firestore = Firestore.instance;
  UserServices _userServices=UserServices();
  @override
  Future<FirebaseUser> googleSignIn() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleAccount = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

    try{
      FirebaseUser user = await _firebaseAuth.signInWithCredential(credential).then((user){
        _firestore.collection('users').document(user.uid).setData({
          'name':user.displayName,
          'email':user.email,
          'uid':user.uid
        });
      });
      return user;
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}
