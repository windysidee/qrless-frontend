import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  Future<List<dynamic>> getFavorite() async {
    //url değişir
    var url = Uri.parse('https://192.168.170.234/scanhistory');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      return jsonData;
    } else {
      throw Exception('Failed to fetch data from the server');
    }
  }

  //kalbe basma işlemleri
  Future<void> handleFavorite(int index, String brandName) async {
    var url;
    if (favorited[index]) {
      url = Uri.parse('https://192.168.170.234/favorites/$brandName');
      //kalbe basıp favorileme POST
      var response = await http.post(url);
      if (response.statusCode == 200) {
        print('Brand added to favorites');
      } else {
        print(
            'Failed to add brand to favorites. Status code: ${response.statusCode}');
      }
    } else {
      //kalbe basıp favoriden kaldırma DELETE
      url = Uri.parse('https://192.168.170.234/favorites/$brandName');
      var response = await http.delete(url);
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
          future: getFavorite(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                var mydata = jsonDecode(snapshot.data.toString());
                if (favorited.isEmpty) {
                  favorited = List<bool>.filled(mydata.length, false);
                }
                return ListView.builder(
                  itemCount: mydata == null ? 0 : mydata.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        title:
                            Text("Brand Name: " + mydata[index]["brand_name"]),
                        subtitle:
                            Text("Scan Time: " + mydata[index]["scan_time"]),
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
