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
    apiKey: 'AIzaSyBSD1AQ2AW5ZBNzomFCw3RFqbdQD_hGbP8',
    appId: '1:17372746140:web:7a71c674b44879bb96f859',
    messagingSenderId: '17372746140',
    projectId: 'fir-the-tech-course',
    authDomain: 'fir-the-tech-course.firebaseapp.com',
    storageBucket: 'fir-the-tech-course.appspot.com',
    measurementId: 'G-X8R8HEX8VX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBfU9gXehE0Pxqv6cFcOfmCe_htRQRx8Xg',
    appId: '1:17372746140:android:b3e666e1d7da761196f859',
    messagingSenderId: '17372746140',
    projectId: 'fir-the-tech-course',
    storageBucket: 'fir-the-tech-course.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyArrP6S_-YwPqD8XNdzzaIX6GSK3D_YXMY',
    appId: '1:17372746140:ios:addbd3a049b0f37896f859',
    messagingSenderId: '17372746140',
    projectId: 'fir-the-tech-course',
    storageBucket: 'fir-the-tech-course.appspot.com',
    iosClientId: '17372746140-0tfoooub8oqk40om7pdqh2cdu4nvn7ls.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebaseTheTechCourse',
  );
}
