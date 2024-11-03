// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyDa12MRCZSQUlNCg9hcy3XGm9Dk1AWC07Y',
    appId: '1:615943697958:web:a4171a969ee78012b618e7',
    messagingSenderId: '615943697958',
    projectId: 'rivus-flutter',
    authDomain: 'rivus-flutter.firebaseapp.com',
    storageBucket: 'rivus-flutter.appspot.com',
    measurementId: 'G-SQ1BE51PK1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBJOqotLOzD1wh0lCbT9O0XX2Ncb_ss23g',
    appId: '1:615943697958:android:8b886e1a8d916a63b618e7',
    messagingSenderId: '615943697958',
    projectId: 'rivus-flutter',
    storageBucket: 'rivus-flutter.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAw4WxJkuUuAktl_p0YymazRLty3HHQCRQ',
    appId: '1:615943697958:ios:da095574133bdcc8b618e7',
    messagingSenderId: '615943697958',
    projectId: 'rivus-flutter',
    storageBucket: 'rivus-flutter.appspot.com',
    iosBundleId: 'com.example.rivusUser',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAw4WxJkuUuAktl_p0YymazRLty3HHQCRQ',
    appId: '1:615943697958:ios:da095574133bdcc8b618e7',
    messagingSenderId: '615943697958',
    projectId: 'rivus-flutter',
    storageBucket: 'rivus-flutter.appspot.com',
    iosBundleId: 'com.example.rivusUser',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDa12MRCZSQUlNCg9hcy3XGm9Dk1AWC07Y',
    appId: '1:615943697958:web:9e5ed9014a177a2db618e7',
    messagingSenderId: '615943697958',
    projectId: 'rivus-flutter',
    authDomain: 'rivus-flutter.firebaseapp.com',
    storageBucket: 'rivus-flutter.appspot.com',
    measurementId: 'G-5X1QWYQ718',
  );
}
