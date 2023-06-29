import 'package:flutter/material.dart';

class searchHistory extends StatefulWidget{
  @override
  _searchHistoryState createState() =>  _searchHistoryState();

}
class _searchHistoryState extends State<searchHistory>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search History")),
    );
  }
}