import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:github_sign_in/github_sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project_final/utils/showSnackBar.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  FirebaseAuthMethods(this._auth);
  
  User get user => _auth.currentUser!;

  //SAVE STATE
  Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();
  //EMAIL SIGN UP
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required BuildContext context
  }) async {
    try{
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await sendEmailVerification(context);
    } on FirebaseAuthException catch(e){
      print(e.code);
      showSnackBar(context, e.message!);
    }
  }

  //EMAIL LOGIN
  Future<void> loginWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      if(!_auth.currentUser!.emailVerified){
        await sendEmailVerification(context);
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  //GOOGLE SIGIN
  Future<void> signInWithGoogle(BuildContext context) async{
    try{
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      if(googleAuth?.accessToken != null && googleAuth?.idToken != null){
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken
        );
        UserCredential userCredential = await _auth.signInWithCredential(credential);

        if(userCredential.user != null){
          if(userCredential.additionalUserInfo!.isNewUser){}
        }
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  //FACEBOOK SIGNIN
  Future<void> signInWithFacebook(BuildContext context) async{
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login(); 

      final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

      await _auth.signInWithCredential(facebookAuthCredential);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }
  //APPLE AUTH
  Future<void> signInWithGithub(BuildContext context) async{
    try{
      final GitHubSignIn gitHubSignIn = GitHubSignIn(
        clientId: '837252b3b116a590a91e', 
        clientSecret: '978d8fb2acf892012264d1b6a2adfa4318ac966a', 
        redirectUrl: 'https://flutter-varios-3ffaa.firebaseapp.com/__/auth/handler');

        final result = await gitHubSignIn.signIn(context);
        print('Resutl: ${result.status}');
        print('Resutl: ${result.errorMessage}');
        switch (result.status) {
          case GitHubSignInResultStatus.ok:
            print('Resultado Token: $result.token');
            final gitHubAuthCredentials = GithubAuthProvider.credential(result.token!);
            await _auth.signInWithCredential(gitHubAuthCredentials);

            break;
          case GitHubSignInResultStatus.cancelled:
          case GitHubSignInResultStatus.failed:
            print('Error: ${result.errorMessage}');
            break;
        }
        // print(GithubAuthProvider.credential(result.token!));
        // final gitHubAuthCredentials = GithubAuthProvider.credential(result.token!);

    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  //EMAIL VERIFICATION
  Future<void> sendEmailVerification(BuildContext context) async{
    try {
      _auth.currentUser!.sendEmailVerification();
      showSnackBar(context, 'Email Verification sent!');
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  
  //SIGN OUT
  Future<void> signOut(BuildContext context) async{
    try{
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }
}
