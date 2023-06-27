import 'package:flutter/material.dart';

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

  //Widget build metodu sayfanın elemanlarını içeriyor.
  //Scaffold bir iskelet.Appbar başlık, body sayfanın geri kalanı.Tek bir body
  //objesi var, diğerleri child oluyor.Eğer birden fazla widget kullanılacaksa 
  //children : <Obje Türü> [buraya da çocuklar].
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: const Text('Sign Up'), 
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
                    //Başarılı sign up'dan sonra main page'e ineriz.
                    if(_emailController.text.isNotEmpty && 
                    _passwordController.text.isNotEmpty && _usernameController.text.isNotEmpty) {
                        Navigator.pop(context);
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
}