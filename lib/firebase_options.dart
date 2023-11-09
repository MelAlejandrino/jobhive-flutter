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
    apiKey: 'AIzaSyBjPB5puJwD0_exIWw3dLl0h-t54ejHXNg',
    appId: '1:199863771879:web:47cf5925dc9d4bf0c4b842',
    messagingSenderId: '199863771879',
    projectId: 'jobhive-b9ff8',
    authDomain: 'jobhive-b9ff8.firebaseapp.com',
    databaseURL: 'https://jobhive-b9ff8-default-rtdb.firebaseio.com',
    storageBucket: 'jobhive-b9ff8.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDQ2OOsBzayAy8k_TB-LJhONBUqfEcY8jY',
    appId: '1:199863771879:android:80f97469e72a5c97c4b842',
    messagingSenderId: '199863771879',
    projectId: 'jobhive-b9ff8',
    databaseURL: 'https://jobhive-b9ff8-default-rtdb.firebaseio.com',
    storageBucket: 'jobhive-b9ff8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAHWo1BzKjj1zwm-uri74gqCbu_qUPkmNc',
    appId: '1:199863771879:ios:0534deb8c88afda5c4b842',
    messagingSenderId: '199863771879',
    projectId: 'jobhive-b9ff8',
    databaseURL: 'https://jobhive-b9ff8-default-rtdb.firebaseio.com',
    storageBucket: 'jobhive-b9ff8.appspot.com',
    iosBundleId: 'com.example.jobhive',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAHWo1BzKjj1zwm-uri74gqCbu_qUPkmNc',
    appId: '1:199863771879:ios:4ebe3a23fb5873abc4b842',
    messagingSenderId: '199863771879',
    projectId: 'jobhive-b9ff8',
    databaseURL: 'https://jobhive-b9ff8-default-rtdb.firebaseio.com',
    storageBucket: 'jobhive-b9ff8.appspot.com',
    iosBundleId: 'com.example.jobhive.RunnerTests',
  );
}