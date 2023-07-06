import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_qrless/signin/SignUpView.dart';
import 'package:flutter_qrless/main/MainPageView.dart';
import 'package:http/http.dart' as http;
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  late String _username;
  late String _password;

  @override
  Widget build(BuildContext context) {
    Shader textGradient = const LinearGradient(
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
                SizedBox(height: 70.0), // Spacing
                const Text(
                  'Login',
                  style: TextStyle(
                    color: Color(0xFFF4FAFF),
                    fontSize: 40.0,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w800,
                    height: 1.5,
                  ),
                ),

                SizedBox(height: 30.0),

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

                SizedBox(height: 15.0),

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

                SizedBox(height: 50.0),

                ElevatedButton(
                  onPressed: () {
                    _username = _usernameController.text;
                    _password = _passwordController.text;
                    //Navigator.pushNamed(context, '/MainPage');
                    handleLogin();
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
                    minimumSize: Size(250, 55),
                  ),
                ),

                SizedBox(height: 15.0),

                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/SignIn');
                  },
                  child: Text(
                    'Sign Up',
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
                    minimumSize: Size(250, 55),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  Future<void> handleLogin() async {
    Uri uri = Uri.parse('http://192.168.170.234:8000/users/login');
    try {
      final response = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': '$_username',
          'password': '$_password',
        }),
      );

      if (response.statusCode == 200) {
        // Login successful
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login successful'),
            backgroundColor: Colors.green,
          ),
        );

        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        String? token = jsonResponse['access_token'];
        if (token != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);
        } else {
          print('Token was not found in the response body.');
        }

        Navigator.pushNamed(context, '/MainPage');
      } else {
        // Failed login
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed login! Username or password is incorrect.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
