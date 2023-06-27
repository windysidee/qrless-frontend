import 'package:flutter/material.dart';
import 'package:flutter_qrless/signin/SignUpView.dart';
import 'package:flutter_qrless/main/MainPageView.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: const Text('QRless')),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'Enter your username',
                    labelText: 'Username',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.lock),
                    hintText: 'Enter your password',
                    labelText: 'Password',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  obscureText: true,
                ),
                ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context,'/MainPage');
                  },
                   child: Text('Submit'),
                  ),
                TextButton(                 
                  onPressed: (){
                    Navigator.pushNamed(context, '/SignIn');
                    
                  },  
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
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

  //Controller yazacaksan dispose et, imha et.
  @override
  void dispose(){
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();



  }
}
