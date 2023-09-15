import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBOhHlChiBKZYTVQP6yxNX1bI8VSq32ipU",
            authDomain: "pro-sanpo-test.firebaseapp.com",
            projectId: "pro-sanpo-test",
            storageBucket: "pro-sanpo-test.appspot.com",
            messagingSenderId: "443485230140",
            appId: "1:443485230140:web:97df373669800e03731f39"));
  } else {
    await Firebase.initializeApp();
  }
}
