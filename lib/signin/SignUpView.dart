import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Uri uri = Uri.parse('https://192.168.1.37:3000/api');

class SignUpView extends StatefulWidget{
  @override
  _SignUpViewState createState() =>  _SignUpViewState();

}
class _SignUpViewState extends State<SignUpView>{
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child:  Text('Sign Up'), 
        ),
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
                  'Please fill all of the fields.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    ),                
                ),
          
                TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      //Aga icon olayı baya iyi Icons classında her bok var.
                      icon:Icon(Icons.mail),
                      labelText: 'Email',
                      hintText: 'Enter your email',
                    ),
                    validator: (value){
                      if(value==null||value.isEmpty){
                        return 'Email field can not be empty !';
                      }
                      return null;
                    },        
                ),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                      icon:Icon(Icons.person),
                      labelText: 'Username',
                      hintText: 'Enter your username',
                    ),
                    validator: (value){
                      if(value==null||value.isEmpty){
                        return 'Username field can not be empty';
                      }
                      return null;
                    },  
                
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                      icon:Icon(Icons.lock),
                      labelText: 'Password',
                      hintText: 'Enter your password'
                    ),
                    validator: (value){
                      if(value==null||value.isEmpty){
                        return 'Password field can not be empty!';
                      }
                      return null;
                    },  
                
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                      icon:Icon(Icons.lock),
                      labelText: 'Password Again',
                      hintText: 'Enter your password again'
                    ),
                    validator: (value){
                      if(value==null||value.isEmpty){
                        return 'Password field can not be empty!';
                      }
                      return null;
                    },  
                
                ),
                //Submit butonu ayarlamaç
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child:ElevatedButton(
                  onPressed:() {
                    if(_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty && _usernameController.text.isNotEmpty){
                        sendPostRequest();
                    }
                    
                    },                  
                  child: const Text("Submit"),
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
  void dispose(){
    super.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }
  
//Kullanıcı adı şifre postlanması, DENENMEDİ
Future<void> sendPostRequest() async {
  String jsonString = '{"name": "$username", "email": "$email", "password: "$password"}';

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


