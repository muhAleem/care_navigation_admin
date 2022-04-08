import 'package:care_navigation_admin_panel/view/auth/login/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(

    options: const FirebaseOptions(
        apiKey: "AIzaSyAcBinqkTMiubp7DqYt2DhVhXJPYo9viI0",
        authDomain: "carenavigation-caae6.firebaseapp.com",
        databaseURL: "https://carenavigation-caae6-default-rtdb.firebaseio.com",
        projectId: "carenavigation-caae6",
        storageBucket: "carenavigation-caae6.appspot.com",
        messagingSenderId: "457617510020",
        appId: "1:457617510020:web:f496f101295f545807fcd1"
      // apiKey: 'AIzaSyAcBinqkTMiubp7DqYt2DhVhXJPYo9viI0',
      // appId: '1:457617510020:web:612e7215609470bb07fcd1',
      // messagingSenderId: '457617510020',
      // projectId: 'carenavigation-caae6',
      // storageBucket: 'https://console.firebase.google.com/project/carenavigation-caae6/storage/carenavigation-caae6.appspot.com/files'
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Care Navigation Admin Panel',
      home: const Login(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
