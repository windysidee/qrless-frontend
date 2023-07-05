import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_qrless/navbar/navBar.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter_qrless/main/MenuPage.dart';
import 'package:shared_preferences/shared_preferences.dart';


// Main page's entry point
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: MainPageView(
        camera: firstCamera,
      ),
    ),
  );
}

class MainPageView extends StatefulWidget {
  const MainPageView({
    Key? key,
    required this.camera,
  }) : super(key: key);

  final CameraDescription camera;

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPageView> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.max,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Main'de geri basınca çıkmak istiyor musunuz diye pop-up çıkıyor, evet dersen uygulamayı kapatıyor.
  Future<bool> _onWillPop() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: const Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  // Fotoyu backend'e göndermeç.
  Future<void> sendImage(String base64Image) async {
  // Retrieve token from shared preferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  if (token == null) {
    print('Token is null, please authenticate again');
    return;
  }

  // Your URL may change
  Uri uri = Uri.parse('http://192.168.170.234:8000/azure/detect-brand');
  
  try {
    http.Response response = await http.post(
      uri,
      body: jsonEncode(<String, String>{'image': base64Image}),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      //Menü geliyo gösteriliyo.
      Map<String, dynamic> menuData = jsonDecode(response.body);
      Navigator.push(
        _scaffoldKey.currentContext!,
        MaterialPageRoute(builder: (context) => MenuPage(menu: menuData)),
      );
    } else {
      // pop-up eklenebilir
      print('Failed to upload image. Status code: ${response.statusCode}');
    }
  } catch (e) {
    // opo-up eklenebilir
    print('Failed to upload image: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key:_scaffoldKey,
        appBar: AppBar(
          title: const Center(
            child: Text('QRless'),
          ),
        ),
        drawer: navBar(),
        body: Stack(
          children: <Widget>[
            FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(_controller);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            Positioned(
              bottom: 5.0,
              left: 0.0,
              right: 0.0,
              child: Center(
                child: FloatingActionButton(
                  onPressed: () async {
                    try {
                      await _initializeControllerFuture;

                      final image = await _controller.takePicture();

                      if (!mounted) return;

                      Uint8List imageBytes =
                          await File(image.path).readAsBytes();

                      // Base64 encoded image
                      String base64Image = base64Encode(imageBytes);

                      await sendImage(base64Image);
                    
                      // Vibrate for a short time
                      HapticFeedback.lightImpact();

                      // Create an overlay entry
                      OverlayEntry overlayEntry = OverlayEntry(
                        builder: (context) => Container(
                          color: const Color.fromARGB(255, 186, 179, 179)
                              .withOpacity(0.4),
                        ),
                      );

                      // Insert the overlay entry to the current context
                      Overlay.of(context)!.insert(overlayEntry);

                      // Remove the overlay entry after 1 second
                      if(mounted) {
                        Overlay.of(context)!.insert(overlayEntry);
                        Future.delayed(
                            Duration(seconds: 1), () => overlayEntry.remove());
                      }
                    } catch (e) {
                      print(e);
                    }
                  },

//BURASI HEM TİTREŞİMLİ HEM DE EKRAN BLURLU KOD/////////////////////////////////////////////////////////////////////////////////////
//                   onPressed: () async {
//   try {
//     await _initializeControllerFuture;

//     final image = await _controller.takePicture();

//     if (!mounted) return;

//     Uint8List imageBytes = await File(image.path).readAsBytes();

//     // Base64 encoded image
//     String base64Image = base64Encode(imageBytes);

//     sendImage(base64Image);

//     // Vibrate the device for 1 second
//     Vibration.vibrate(duration: 1000);

//     // Create an overlay entry
//     OverlayEntry overlayEntry = OverlayEntry(
//       builder: (context) => Container(
//         color: Colors.white.withOpacity(0.3),
//       ),
//     );

//     // Insert the overlay entry to the current context
//     Overlay.of(context)!.insert(overlayEntry);

//     // Remove the overlay entry after 1 second
//     Future.delayed(Duration(seconds: 1), () => overlayEntry.remove());
//   } catch (e) {
//     print(e);
//   }
// },

                  child: const Icon(Icons.camera_alt),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
