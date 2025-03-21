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
    apiKey: 'AIzaSyBasfa4EHI-Ld_C1VXXCISjqtMdxKZQWds',
    appId: '1:374534360641:web:b646a96c7b796dccb580c0',
    messagingSenderId: '374534360641',
    projectId: 'test-56034',
    authDomain: 'test-56034.firebaseapp.com',
    storageBucket: 'test-56034.firebasestorage.app',
    measurementId: 'G-TR11DSNXLK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD7Zh4RjR1hImG8RX2nOjUVguP3NS7cq-Y',
    appId: '1:374534360641:android:5431578e0a83fc65b580c0',
    messagingSenderId: '374534360641',
    projectId: 'test-56034',
    storageBucket: 'test-56034.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBw9kkUxa2RV6fmm7je25l5k3_bcpgVOog',
    appId: '1:374534360641:ios:3e2442b6e4168be5b580c0',
    messagingSenderId: '374534360641',
    projectId: 'test-56034',
    storageBucket: 'test-56034.firebasestorage.app',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBw9kkUxa2RV6fmm7je25l5k3_bcpgVOog',
    appId: '1:374534360641:ios:3e2442b6e4168be5b580c0',
    messagingSenderId: '374534360641',
    projectId: 'test-56034',
    storageBucket: 'test-56034.firebasestorage.app',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBasfa4EHI-Ld_C1VXXCISjqtMdxKZQWds',
    appId: '1:374534360641:web:aac0ed1332536125b580c0',
    messagingSenderId: '374534360641',
    projectId: 'test-56034',
    authDomain: 'test-56034.firebaseapp.com',
    storageBucket: 'test-56034.firebasestorage.app',
    measurementId: 'G-ZNQPTZNMRS',
  );
}
