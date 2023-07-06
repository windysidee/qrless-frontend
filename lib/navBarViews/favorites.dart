import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class favorites extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<favorites> {
  late Future<void> favoritesFuture;
  List<String> favorites = [];

  @override
  void initState() {
    super.initState();
    favoritesFuture = getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favorites")),
      body: Center(
        child: FutureBuilder<void>(
          future: favoritesFuture,
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(favorites[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        String brandName = favorites[index];
                        favorites.removeAt(index);
                        handleFavorite(index, brandName);
                        setState(() {});
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> getFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    var url = Uri.parse('http://192.168.170.234:8000/users/favorites');
    try {
      http.Response response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      // Parse the response body
      List<dynamic> responseBody = jsonDecode(response.body);
      favorites =
          responseBody.map((item) => item['brand_name'] as String).toList();
    } catch (e) {
      print("Something went wrong.");
      throw e; // Rethrow the exception to handle it in the FutureBuilder
    }
  }

  Future<void> handleFavorite(int index, String brandName) async {
    //kalbe basıp favoriden kaldırma DELETE
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    var url =
        Uri.parse('http://192.168.170.234:8000/users/favorites/$brandName');
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
