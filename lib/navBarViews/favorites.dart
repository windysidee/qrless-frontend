import 'package:flutter/material.dart';

class favorites extends StatefulWidget{
  @override
  _favoriteState createState() =>  _favoriteState();

}
class _favoriteState extends State<favorites>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favorites")),
    );
  }
}