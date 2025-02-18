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
    apiKey: 'AIzaSyB1PrGKh5cerJvS7PGGDzB5B1_T1934xf0',
    appId: '1:78854343895:web:99048a55e7e87436d43492',
    messagingSenderId: '78854343895',
    projectId: 'testlogin-20430',
    authDomain: 'testlogin-20430.firebaseapp.com',
    storageBucket: 'testlogin-20430.firebasestorage.app',
    measurementId: 'G-015C9PGNPD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyByJH-dDyQg8wIxO87svS663iLj1qnbBng',
    appId: '1:78854343895:android:52f75328dd2909d2d43492',
    messagingSenderId: '78854343895',
    projectId: 'testlogin-20430',
    storageBucket: 'testlogin-20430.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCbH_-nM01eWBOQCcoN0xoJGAokDYlfoIk',
    appId: '1:78854343895:ios:6470fc876bf5e7afd43492',
    messagingSenderId: '78854343895',
    projectId: 'testlogin-20430',
    storageBucket: 'testlogin-20430.firebasestorage.app',
    iosBundleId: 'com.example.test',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCbH_-nM01eWBOQCcoN0xoJGAokDYlfoIk',
    appId: '1:78854343895:ios:6470fc876bf5e7afd43492',
    messagingSenderId: '78854343895',
    projectId: 'testlogin-20430',
    storageBucket: 'testlogin-20430.firebasestorage.app',
    iosBundleId: 'com.example.test',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB1PrGKh5cerJvS7PGGDzB5B1_T1934xf0',
    appId: '1:78854343895:web:376e3df4b860cc81d43492',
    messagingSenderId: '78854343895',
    projectId: 'testlogin-20430',
    authDomain: 'testlogin-20430.firebaseapp.com',
    storageBucket: 'testlogin-20430.firebasestorage.app',
    measurementId: 'G-8YZH2Z4KLD',
  );

}