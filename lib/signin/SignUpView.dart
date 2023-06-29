import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:ui';

Uri uri = Uri.parse('https://192.168.1.37:3000/api');

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  //Key'e çok takılma nolduğunu ben de anlamadım
  final _formKey = GlobalKey<FormState>();
  //Input handling, fazla bilgi için üstüne gel oku
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  late String email;
  late String username;
  late String password;

  //Widget build metodu sayfanın elemanlarını içeriyor.
  //Scaffold bir iskelet.Appbar başlık, body sayfanın geri kalanı.Tek bir body
  //objesi var, diğerleri child oluyor.Eğer birden fazla widget kullanılacaksa
  //children : <Obje Türü> [buraya da çocuklar].
  @override
  Widget build(BuildContext context) {
    Shader textGradient = LinearGradient(
      colors: <Color>[
        Color.fromARGB(255, 255, 255, 255),
        Color.fromARGB(255, 72, 72, 255)
      ],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
    return Scaffold(
      backgroundColor: Color(0xFFACCBFF),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'QRless',
            style: TextStyle(
              fontSize: 60.0,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.25),
                  offset: Offset(0, 4),
                  blurRadius: 2,
                ),
              ],
              fontFamily: 'Bruno Ace SC',
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400,
              foreground: Paint()..shader = textGradient,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 40.0,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w800,
                    height: 1.5,
                  ),
                ),

                SizedBox(height: 50.0),

                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFDBEDFF),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.email),
                      hintText: 'Enter your email',
                      labelText: 'Email',
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                ),

                SizedBox(height: 10.0),

                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFDBEDFF),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      hintText: 'Enter your username',
                      labelText: 'Username',
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                ),

                SizedBox(height: 10.0),

                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFDBEDFF),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.lock),
                      hintText: 'Enter your password',
                      labelText: 'Password',
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    obscureText: true,
                  ),
                ),

                SizedBox(height: 10.0),

                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFDBEDFF),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.lock),
                      hintText: 'Please enter your password again',
                      labelText: 'Password Again',
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password again';
                      }
                      return null;
                    },
                    obscureText: true,
                  ),
                ),

                //Submit butonu ayarlamaç
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_emailController.text.isNotEmpty &&
                          _passwordController.text.isNotEmpty &&
                          _usernameController.text.isNotEmpty) {
                        sendPostRequest();
                      }
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w800, // Extra bold
                        fontStyle: FontStyle.normal,
                        fontFamily: 'Inter',
                        shadows: [
                          Shadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            offset: Offset(0, 4),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF3B5998), // Background color
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(30.0), // Border radius
                      ),
                      minimumSize: Size(387, 55),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Controller'ları dispose etmek gerekiyor.Garbage collector yok galiba.
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

//Kullanıcı adı şifre postlanması, DENENMEDİ
  Future<void> sendPostRequest() async {
    String jsonString =
        '{"name": "$username", "email": "$email", "password: "$password"}';

    try {
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonString,
      );

      if (response.statusCode == 200) {
        Navigator.pop(context);
        // Request successful
        print('POST request successful');
        print('Response body: ${response.body}');
      } else {
        // Request failed
        print('POST request failed');
        print('Response status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      // Request error
      print('Error during POST request: $e');
    }
  }
}
