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
    apiKey: 'AIzaSyBOx1yB0dNn1HS4oJzMBnI2HxUI_7VBs10',
    appId: '1:480923533607:web:91abc99d0a2ea79c1e2902',
    messagingSenderId: '480923533607',
    projectId: 'awlaadsanaad',
    authDomain: 'awlaadsanaad.firebaseapp.com',
    storageBucket: 'awlaadsanaad.appspot.com',
    measurementId: 'G-GCPM2XK9WJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDtvpc-AzE0oc2NOI1pFMcyKdEQn8m6tv8',
    appId: '1:480923533607:android:c40f3a7074cab1b11e2902',
    messagingSenderId: '480923533607',
    projectId: 'awlaadsanaad',
    storageBucket: 'awlaadsanaad.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCf6kq3zwAUqCPzdoWv_5LrAqtFZIgMyok',
    appId: '1:480923533607:ios:094165523c2f41711e2902',
    messagingSenderId: '480923533607',
    projectId: 'awlaadsanaad',
    storageBucket: 'awlaadsanaad.appspot.com',
    iosBundleId: 'com.example.awladsanaad2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCf6kq3zwAUqCPzdoWv_5LrAqtFZIgMyok',
    appId: '1:480923533607:ios:094165523c2f41711e2902',
    messagingSenderId: '480923533607',
    projectId: 'awlaadsanaad',
    storageBucket: 'awlaadsanaad.appspot.com',
    iosBundleId: 'com.example.awladsanaad2',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBOx1yB0dNn1HS4oJzMBnI2HxUI_7VBs10',
    appId: '1:480923533607:web:15dc719a499a3e6e1e2902',
    messagingSenderId: '480923533607',
    projectId: 'awlaadsanaad',
    authDomain: 'awlaadsanaad.firebaseapp.com',
    storageBucket: 'awlaadsanaad.appspot.com',
    measurementId: 'G-1ZW4GCGTKZ',
  );
}
