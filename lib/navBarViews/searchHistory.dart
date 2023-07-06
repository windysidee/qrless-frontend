import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class searchHistory extends StatefulWidget {
  @override
  _SearchHistoryState createState() => _SearchHistoryState();
}

class _SearchHistoryState extends State<searchHistory> {
  late List<bool> favorited;

  @override
  void initState() {
    super.initState();
    favorited = [];
  }

  void _toggleFavorite(int index, String brandName) {
    setState(() {
      favorited[index] = !favorited[index];
    });
    handleFavorite(index, brandName);
  }

  //favorileri alma
  Future<List<dynamic>> scanHistory() async {
    //url değişir
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      print('Token is null, please authenticate again');
    }

    var url = Uri.parse('http://192.168.170.234:8000/users/scanhistory');
    var response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer $token",
      },
    );
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      print("*/*/*/*/*/*/*/*/*/*/*");
      print(jsonData);
      return jsonData;
    } else {
      throw Exception('Failed to fetch data from the server');
    }
  }

  //kalbe basma işlemleri
  Future<void> handleFavorite(int index, String brandName) async {
    var url;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (favorited[index]) {
      url = Uri.parse('http://192.168.170.234:8000/users/favorites/$brandName');
      //kalbe basıp favorileme POST
      var response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      if (response.statusCode == 200) {
        print('Brand added to favorites');
      } else {
        print(
            'Failed to add brand to favorites. Status code: ${response.statusCode}');
      }
    } else {
      //kalbe basıp favoriden kaldırma DELETE
      url = Uri.parse('http://192.168.170.234:8000/users/favorites/$brandName');
      var response = await http.delete(
        url,
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      if (response.statusCode == 200) {
        print('Brand removed from favorites');
      } else {
        print(
            'Failed to remove brand from favorites. Status code: ${response.statusCode}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scan History")),
      body: Center(
        child: FutureBuilder(
          future: scanHistory(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                var mydata = snapshot.data as List;
                if (favorited.isEmpty) {
                  favorited = List<bool>.filled(mydata.length, false);
                }
                return ListView.builder(
                  itemCount: mydata == null ? 0 : mydata.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        title:
                            Text(mydata[index]["brand_name"]),
                        subtitle: Text("Scan Time: " +
                            DateFormat('yyyy-MM-dd HH:mm').format(
                                DateTime.parse(mydata[index]["scan_time"]))),
                        trailing: IconButton(
                          icon: favorited[index]
                              ? Icon(Icons.favorite)
                              : Icon(Icons.favorite_border),
                          onPressed: () {
                            _toggleFavorite(index, mydata[index]["brand_name"]);
                          },
                        ));
                  },
                );
              }
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
