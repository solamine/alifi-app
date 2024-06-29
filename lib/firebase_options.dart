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
    apiKey: 'AIzaSyAv1p8jNzyv-P4XXV3YqCfquGhMnAYzNlk',
    appId: '1:246390809487:web:48b0d370d85e4707f721fa',
    messagingSenderId: '246390809487',
    projectId: 'alifi-app',
    authDomain: 'alifi-app.firebaseapp.com',
    storageBucket: 'alifi-app.appspot.com',
    measurementId: 'G-PT5FB20DBR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAXhhpxfm_Pj1JbG-jEAvFMXkfEauUqnXU',
    appId: '1:246390809487:android:75ad1a95b5c9c88cf721fa',
    messagingSenderId: '246390809487',
    projectId: 'alifi-app',
    storageBucket: 'alifi-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD6OWeeAxHChQ2crRzGpFpQyfEvTmSVQPk',
    appId: '1:246390809487:ios:ff163a8cec3411cef721fa',
    messagingSenderId: '246390809487',
    projectId: 'alifi-app',
    storageBucket: 'alifi-app.appspot.com',
    iosBundleId: 'com.example.alifiApplication',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD6OWeeAxHChQ2crRzGpFpQyfEvTmSVQPk',
    appId: '1:246390809487:ios:ff163a8cec3411cef721fa',
    messagingSenderId: '246390809487',
    projectId: 'alifi-app',
    storageBucket: 'alifi-app.appspot.com',
    iosBundleId: 'com.example.alifiApplication',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAv1p8jNzyv-P4XXV3YqCfquGhMnAYzNlk',
    appId: '1:246390809487:web:86a8304c507ea732f721fa',
    messagingSenderId: '246390809487',
    projectId: 'alifi-app',
    authDomain: 'alifi-app.firebaseapp.com',
    storageBucket: 'alifi-app.appspot.com',
    measurementId: 'G-BRTZ8HLJSV',
  );

}