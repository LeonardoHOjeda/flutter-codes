import 'package:flutter/material.dart';
import 'package:progra_movil/utilities/utilities.dart';
import 'package:progra_movil/widgets/widgets.dart';

class PracticeThreeScreen extends StatefulWidget {
  static const String routerName = 'PracticeThree';

  @override
  State<PracticeThreeScreen> createState() => _PracticeThreeScreenState();
}

class _PracticeThreeScreenState extends State<PracticeThreeScreen> {
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Practica 3'),
          backgroundColor: Colors.green[800],
        ),
        drawer: SideMenu(),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.green.shade600,
                        Colors.green.shade400,
                        Colors.green.shade200,
                        Colors.green.shade50,
                      ],
                      stops: [
                        0.1,
                        0.4,
                        0.7,
                        0.9
                      ]),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding:
                      EdgeInsets.symmetric(horizontal: 40.0, vertical: 50.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Iniciar Sesion',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 30.0),
                        _buildEmailTF(),
                        SizedBox(height: 30.0),
                        _buildPasswordTF(),
                        _buildForgotPasswordBtn(),
                        _buildRememberMeCheckbox(),
                        _buildLoginBtn(),
                        _buildSignInWithText(),
                        _buildSocialBtnRow(),
                        _buildSignUpBtn()
                      ]),
                ),
              )
            ],
          ),
        ));
  }

  GestureDetector _buildSignUpBtn() {
    return GestureDetector(
      onTap: ()=> print('Crear Cuenta Button'),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'No tienes una cuenta?',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w400
              ),
            ),
            TextSpan(
              text: 'Crear Cuenta',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold
              )
            )
          ]
        ),
      ),
    );
  }

  Padding _buildSocialBtnRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildSocialBtn(() => print('Login with Facebook') ,AssetImage('assets/facebook.png')),
          _buildSocialBtn(() => print('Login with Google') ,AssetImage('assets/google.png')),
        ]
      ),
    );
  }

  GestureDetector _buildSocialBtn(VoidCallback onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: Colors.black87,
              offset: Offset(0,2),
              blurRadius: 6.0
            )
          ],
          image: DecorationImage(
            image: logo
          )
        ),
      ),
    );
  }

  Column _buildSignInWithText() {
    return Column(
      children: [
        Text(
          '- OR -',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          'Iniciar Sesion con',
          style: kLabelStyle,
        )
      ],
    );
  }

  Container _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0)
            )
          ),
          backgroundColor: MaterialStateProperty.all(Colors.red)
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(
            'INICIAR SESION', 
            style: TextStyle(
              letterSpacing: 1.5,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans'
            ),
          ),
        ),
        onPressed: () => print('Inicio de Sesion Presionado'),
      ),
    );
  }

  Container _buildRememberMeCheckbox() {
    return Container(
      child: Row(
        children: [
          Theme(
              data: ThemeData(unselectedWidgetColor: Colors.black),
              child: Checkbox(
                value: _rememberMe,
                checkColor: Colors.green,
                activeColor: Colors.black,
                onChanged: (value) {
                  setState(() {
                    _rememberMe = value!;
                  });
                },
              )),
          Text(
            'Recuerda mis credenciales',
            style: kLabelStyle,
          )
        ],
      ),
    );
  }

  Column _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            obscureText: true,
            style: TextStyle(color: Colors.white, fontFamily: 'OpenSans'),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(Icons.lock, color: Colors.black),
                hintText: 'Introduce tu Password',
                hintStyle: kHintTextStyle),
          ),
        )
      ],
    );
  }

  Column _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(Icons.email, color: Colors.black),
                hintText: 'Introduce tu Email',
                hintStyle: kHintTextStyle),
          ),
        )
      ],
    );
  }
}

class _buildForgotPasswordBtn extends StatelessWidget {
  const _buildForgotPasswordBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        child: Text(
          'Olvidaste Contra',
          style: kLabelStyle,
        ),
        onPressed: () => print('Boton Olvidar Contra, presionado'),
      ),
    );
  }
}
