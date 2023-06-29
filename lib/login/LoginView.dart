import 'package:flutter/material.dart';
import 'dart:ui';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _username = "";
  String _password = "";

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

                SizedBox(height: 20.0),

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

                SizedBox(height: 30.0),

                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/MainPage');
                    _username = _usernameController.text;
                    _password = _passwordController.text;
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
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/SignIn');
                  },
                  child: const Text('Sign Up'),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF3B5998),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
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
}
