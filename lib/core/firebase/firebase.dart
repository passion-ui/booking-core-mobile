import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart';

class FirebaseCore {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAJHw4shyYf5aw3Up9Qk0RFxDSCHlfTivM',
    appId: '1:320103724101:android:a32e9109e7ffdc5216df2c',
    messagingSenderId: '320103724101',
    projectId: 'booking-core-ee5dc',
    storageBucket: 'booking-core-ee5dc.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDiIKiRVk42MS2vAZm3fwL029UMwjtm2x0',
    appId: '1:320103724101:ios:f8d0b6284eb5cc4f16df2c',
    messagingSenderId: '320103724101',
    projectId: 'booking-core-ee5dc',
    storageBucket: 'booking-core-ee5dc.firebasestorage.app',
    iosBundleId: 'com.huynh.booking',
  );
}
