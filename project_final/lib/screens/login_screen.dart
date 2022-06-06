import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project_final/screens/login_email_password_screen.dart';
import 'package:project_final/screens/signup_email_password_screen.dart';
import 'package:project_final/services/firebase_auth_methods.dart';
import 'package:project_final/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomButton(onTap: (){Navigator.pushNamed(context, EmailPasswordSignup.routeName);}, text: 'Crear Cuenta'),
            CustomButton(onTap: (){Navigator.pushNamed(context, EmailPasswordLogin.routeName);}, text: 'Iniciar Sesion con Correo'),
            CustomButton(onTap: (){context.read<FirebaseAuthMethods>().signInWithGoogle(context);}, text: 'Google'),
            CustomButton(onTap: (){context.read<FirebaseAuthMethods>().signInWithFacebook(context);}, text: 'Facebook'),
          ],
        ),
      ),
    );
  }
}