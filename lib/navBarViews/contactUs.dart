import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ContactUs extends StatefulWidget{
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs>{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final subjectController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: DefaultTextStyle(
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            child: Text("Contact Us"),
          ),
          backgroundColor: Color(0xffACCBFF),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(25.0, 40, 25, 0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.account_circle),
                    hintText: 'Name',
                    labelText: 'Name',
                    labelStyle: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  style: TextStyle(color: Colors.black, fontSize: 20),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field cannot be empty';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 25),
                TextFormField(
                  controller: subjectController,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.subject),
                    hintText: 'Subject',
                    labelText: 'Subject',
                    labelStyle: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  style: TextStyle(color: Colors.black, fontSize: 20),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field cannot be empty';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 25),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.email),
                    hintText: 'Email',
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  style: TextStyle(color: Colors.black, fontSize: 20),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field cannot be empty';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 25),
                TextFormField(
                  controller: messageController,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.message),
                    hintText: 'Message',
                    labelText: 'Message',
                    labelStyle: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  style: TextStyle(color: Colors.black, fontSize: 20),
                  maxLines: null,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field cannot be empty';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showTopSnackBar(
                        context,
                        CustomSnackBar.success(
                          message: "Your message has been sent successfully!",
                          textStyle: TextStyle(fontSize: 20),
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Submit'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue, 
                    textStyle: TextStyle(fontSize: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Color(0xffACCBFF),
      ),
    );
  }
}
