// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB-AcAAP7rGE5QNU_O6BmOQHY3JJDZS4MM',
    appId: '1:468482051782:web:d9430f5aa55ec1774051c7',
    messagingSenderId: '468482051782',
    projectId: 'flutter-varios-3ffaa',
    authDomain: 'flutter-varios-3ffaa.firebaseapp.com',
    databaseURL: 'https://flutter-varios-3ffaa-default-rtdb.firebaseio.com',
    storageBucket: 'flutter-varios-3ffaa.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAIttxIyMc4wuMGwaQh17hsC9X5da8pHVk',
    appId: '1:468482051782:android:ff10e6baad13667a4051c7',
    messagingSenderId: '468482051782',
    projectId: 'flutter-varios-3ffaa',
    databaseURL: 'https://flutter-varios-3ffaa-default-rtdb.firebaseio.com',
    storageBucket: 'flutter-varios-3ffaa.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyByGNbMgQ9wIRyVhSYZ91LdipRiyQ6HUW0',
    appId: '1:468482051782:ios:2b820d8520391d554051c7',
    messagingSenderId: '468482051782',
    projectId: 'flutter-varios-3ffaa',
    databaseURL: 'https://flutter-varios-3ffaa-default-rtdb.firebaseio.com',
    storageBucket: 'flutter-varios-3ffaa.appspot.com',
    androidClientId: '468482051782-0oq68s0r9k1o7erubbe95lgk4o8gesn3.apps.googleusercontent.com',
    iosClientId: '468482051782-j27mduk3bfsvv7khqa3dc87t973gkg19.apps.googleusercontent.com',
    iosBundleId: 'com.example.projectFinalPM',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyByGNbMgQ9wIRyVhSYZ91LdipRiyQ6HUW0',
    appId: '1:468482051782:ios:2b820d8520391d554051c7',
    messagingSenderId: '468482051782',
    projectId: 'flutter-varios-3ffaa',
    databaseURL: 'https://flutter-varios-3ffaa-default-rtdb.firebaseio.com',
    storageBucket: 'flutter-varios-3ffaa.appspot.com',
    androidClientId: '468482051782-0oq68s0r9k1o7erubbe95lgk4o8gesn3.apps.googleusercontent.com',
    iosClientId: '468482051782-j27mduk3bfsvv7khqa3dc87t973gkg19.apps.googleusercontent.com',
    iosBundleId: 'com.example.projectFinalPM',
  );
}
