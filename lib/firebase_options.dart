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
    apiKey: 'AIzaSyCwbSRiePWLUAdGz8S82B45EsjBnpg3HAY',
    appId: '1:236690908689:web:c29527458bc655f245f3b0',
    messagingSenderId: '236690908689',
    projectId: 'petstore-2f1a7',
    authDomain: 'petstore-2f1a7.firebaseapp.com',
    storageBucket: 'petstore-2f1a7.appspot.com',
    measurementId: 'G-9MNFJPYKPW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAWeSEJfwqoGZZb0fM-EFKyyMTQ5t8G8g8',
    appId: '1:236690908689:android:2ff7280d1b59937f45f3b0',
    messagingSenderId: '236690908689',
    projectId: 'petstore-2f1a7',
    storageBucket: 'petstore-2f1a7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDHIUSsX9cebOviAGHMesA5BpO9vrLygQU',
    appId: '1:236690908689:ios:329ccdb6074cf5a345f3b0',
    messagingSenderId: '236690908689',
    projectId: 'petstore-2f1a7',
    storageBucket: 'petstore-2f1a7.appspot.com',
    iosBundleId: 'com.bitknit.petStoreAdmin',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDHIUSsX9cebOviAGHMesA5BpO9vrLygQU',
    appId: '1:236690908689:ios:329ccdb6074cf5a345f3b0',
    messagingSenderId: '236690908689',
    projectId: 'petstore-2f1a7',
    storageBucket: 'petstore-2f1a7.appspot.com',
    iosBundleId: 'com.bitknit.petStoreAdmin',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCwbSRiePWLUAdGz8S82B45EsjBnpg3HAY',
    appId: '1:236690908689:web:dba7fbc579aab6a045f3b0',
    messagingSenderId: '236690908689',
    projectId: 'petstore-2f1a7',
    authDomain: 'petstore-2f1a7.firebaseapp.com',
    storageBucket: 'petstore-2f1a7.appspot.com',
    measurementId: 'G-RTX5VEQ6TC',
  );
}
