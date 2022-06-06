import 'package:flutter/material.dart';
import 'package:project_final/services/firebase_auth_methods.dart';
import 'package:project_final/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<FirebaseAuthMethods>().user;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if(!user.isAnonymous && user.phoneNumber == null) Text(user.email!),
          if(!user.isAnonymous && user.phoneNumber == null) Text(user.providerData[0].providerId),
          if(user.phoneNumber != null) Text(user.phoneNumber!),
          Text(user.uid),
          CustomButton(onTap: () {context.read<FirebaseAuthMethods>().signOut(context);}, text: 'Cerrar Sesion')
          
        ],
      )
    );
  }
}
