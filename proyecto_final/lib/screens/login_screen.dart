import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/providers/login_form_provider.dart';
import 'package:proyecto_final/services/services.dart';
import 'package:proyecto_final/ui/input_decorations.dart';
import 'package:proyecto_final/widgets/widgets.dart';


class LoginScreen extends StatefulWidget {

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoggedIn = false;
  Map _userObj = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 210),
              CardContainer(
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Text('Login', style: Theme.of(context).textTheme.headline4),
                    SizedBox(height: 10),
                    ChangeNotifierProvider(
                      create: (_) => LoginFormProvider(),
                      child: _LoginForm(),
                    ),
                    
                  ],
                )
              ),
              SizedBox(height: 50),
              MaterialButton(
                onPressed: () async {
                  final res = await FacebookAuth.instance.login(
                    permissions: ["public_profile", "email"]
                  ).then((value){
                    FacebookAuth.instance.getUserData().then((value) {
                      setState(() {
                        _isLoggedIn = true;
                        _userObj = value;
                        Navigator.pushReplacementNamed(context, 'home', arguments: _userObj['email']);
                      });
                    });
                  });
                  // if(res.status == LoginStatus.success){
                  //   Navigator.pushReplacementNamed(context, 'home');
                  // }
                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.grey,
                elevation: 0,
                color: Color(0xff3b5998),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  child: Text('Sign in w/FB', style: TextStyle(color: Colors.white),)
                ),
              ),
              SizedBox(height: 50),
              _ButtonLoginService(text: 'Sign in w/FB', color: Color(0xff3b5998),),
              SizedBox(height: 30),
              _ButtonLoginService(text: 'Sign in w/Google', color: Color(0xfff4b400),),
              SizedBox(height: 30),
              TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, 'register'), 
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.lightGreen.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(StadiumBorder())
                  ),
                child: Text(
                  'Crear una nueva cuenta',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                ),
              ),
            ],
          ),
        )
      )
    );
  }
}

class _ButtonLoginService extends StatelessWidget {
  final String text;
  final Color color;
  const _ButtonLoginService({
    Key? key, 
    required this.text, required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () async {
        final res = await FacebookAuth.instance.login(
          permissions: ["public_profile", "email"]
        );
        if(res.status == LoginStatus.success){
          final reqData = await FacebookAuth.instance.getUserData(
            fields: "email,name",
          );
        }
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      disabledColor: Colors.grey,
      elevation: 0,
      color: color,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
        child: Text(text, style: TextStyle(color: Colors.white),)
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Container(
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(hintText: '17031277@itcelaya.edu.mx', labelText: 'Email', prefixIcon: Icons.email_outlined),
              onChanged: (value) => loginForm.email = value,
              validator: (value){
                String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp  = new RegExp(pattern);

                return regExp.hasMatch(value ?? '')
                ? null
                : 'Introduce un correo valido'
                ;
              },
            ),
            SizedBox(height: 30),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(hintText: '*******', labelText: 'Password', prefixIcon: Icons.lock_outline),
              onChanged: (value) => loginForm.password = value,
              validator: (value){
                  return (value != null && value.length >= 6)
                  ? null
                  : 'La contrasena debe de ser de 6 caracteres';
              },
            ),
            SizedBox(height: 30),
            _ButtonSignIn(loginForm: loginForm, text: 'Sign in w/email', color: Colors.green.shade900),
          ],
        ),
      ),
    );
  }
}

class _ButtonSignIn extends StatelessWidget {

  final String text;
  final Color color;

  const _ButtonSignIn({
    Key? key,
    required this.loginForm,
    required this.text,
    required this.color,
  }) : super(key: key);

  final LoginFormProvider loginForm;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: loginForm.isLoading ? null : () async {
        FocusScope.of(context).unfocus();
        final authService = Provider.of<AuthService>(context, listen: false);
        if(!loginForm.isValidForm()) return;
        loginForm.isLoading = true;

        final String? resp = await authService.login(loginForm.email, loginForm.password);

        if(resp == null){
          Navigator.pushReplacementNamed(context, 'home', arguments: loginForm.email);
        } else {
          print(resp);
          NotificationsService.showSnackbar(resp);
          loginForm.isLoading = false;
        }
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      disabledColor: Colors.grey,
      elevation: 0,
      color: this.color,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
        child: (loginForm.isLoading)
        ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
        : Text(text, style: TextStyle(color: Colors.white),)
      ),
    );
  }
}