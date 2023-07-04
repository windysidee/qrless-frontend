import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qrless/login/LoginView.dart';  
import 'package:flutter_qrless/signin/SignUpView.dart';
import 'package:flutter_qrless/main/MainPageView.dart';
import 'package:flutter_qrless/main/MenuPage.dart';

void main() async {
  //kamera işleri normalde main'deydi fakat gpt buraya aldırdı inan bilmiyorum.
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(MyApp(firstCamera: firstCamera));
}

class MyApp extends StatelessWidget {
  final CameraDescription firstCamera;

  MyApp({required this.firstCamera});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QRless',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        //Menu görüntüleyeceksiniz alttakini yorumdan çıkarmaç
        //'/': (context) => MenuPage(),
        '/': (context) => LoginView(),
        '/SignIn': (context) => SignUpView(),
        '/MainPage': (context) => MainPageView(camera: firstCamera),
      }, 
    );
  }
}