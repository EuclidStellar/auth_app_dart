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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCzH2YFQrvuLe-a-9lfDRQEQY3KL846FxY',
    appId: '1:1064195404522:web:91cdf693d40b3f4f265d93',
    messagingSenderId: '1064195404522',
    projectId: 'brl-login-task',
    authDomain: 'brl-login-task.firebaseapp.com',
    storageBucket: 'brl-login-task.appspot.com',
    measurementId: 'G-58326Y7SL9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDTVemBDQbjwhs6m-QhWFuKZ5G3irbjbcU',
    appId: '1:1064195404522:android:1363bc3d383241f6265d93',
    messagingSenderId: '1064195404522',
    projectId: 'brl-login-task',
    storageBucket: 'brl-login-task.appspot.com',
  );
}