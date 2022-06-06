import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_final/firebase_options.dart';
import 'package:project_final/screens/home_screen.dart';
import 'package:project_final/screens/login_email_password_screen.dart';
import 'package:project_final/screens/login_screen.dart';
import 'package:project_final/screens/product_edit_screen.dart';
import 'package:project_final/screens/signup_email_password_screen.dart';
import 'package:project_final/services/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthMethods>(
          create: (_) => FirebaseAuthMethods(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<FirebaseAuthMethods>().authState, 
          initialData: null
        ),
        ChangeNotifierProvider(create: (context) => ProductsService())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Firebase',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.grey[400],
            appBarTheme: AppBarTheme(
              color: Colors.green[900]
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.green,
              elevation: 0
            )
          ),
          home: AuthWrapper(),
          routes: {
            EmailPasswordLogin.routeName: (context) => const EmailPasswordLogin(),
            EmailPasswordSignup.routeName: (context) => const EmailPasswordSignup(),
            ProductScreen.routeName: (context) => ProductScreen()
          },
        ),
    );
  }
}


class AuthWrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if(firebaseUser != null){
      return const HomeScreen();
    }
    return const LoginScreen();
  }
}