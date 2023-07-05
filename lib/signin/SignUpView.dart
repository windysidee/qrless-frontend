import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:ui';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  late String email;
  late String username;
  late String password;

  @override
  Widget build(BuildContext context) {
    Shader textGradient = LinearGradient(
      colors: <Color>[
        Color.fromARGB(255, 255, 255, 255),
        Color.fromARGB(255, 72, 72, 255),
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
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        handleRegister();
                      }
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w800,
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
                      primary: Color(0xFF3B5998),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
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

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  /*void handleRegister() {
    // Simulate registration success
    Future.delayed(Duration(seconds: 1), () {
      // Clear the form fields
      _emailController.clear();
      _usernameController.clear();
      _passwordController.clear();

      // Show success dialog
      showSuccessDialog();

      // Navigate back to LoginView after a delay
      Future.delayed(Duration(seconds: 2), () {
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/',
          (Route<dynamic> route) => false,
        );
      });
    });
  }
*/
  //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  //BURASINI SİLMEDİM BACKENDDEN GERÇEK VERİ GELİNCE BURASI KULLANILIR BELKİ DİYE EMİN DEĞİLİM!
  //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

   Future<void> handleRegister() async {
     email = _emailController.text;
     username = _usernameController.text;
     password = _passwordController.text;

     Uri uri = Uri.parse('http://192.168.170.234:8000/users/register');
     try {
       final response = await http.post(
         uri,
         headers: <String, String>{
           'Content-Type': 'application/json; charset=UTF-8',
         },
         body: jsonEncode(<String, String>{
           'username': username,
           'password': password,
         }),
       );

       if (response.statusCode == 200) {
         showSuccessDialog();
         _emailController.clear();
         _usernameController.clear();
         _passwordController.clear();
       } else {
         print('Response status code: ${response.statusCode}');
       }
     } catch (e) {
       print("Exception occurred: $e");
     }
   }

  void showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            color: Colors.green,
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Registration Successful!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
