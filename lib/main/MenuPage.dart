import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  final Map<String, dynamic> menu;

  MenuPage({Key? key, required this.menu}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menu')),
      body: ListView(
        children:
            (menu['menu'] as Map<String, dynamic>).entries.map<Widget>((entry) {
          var category = entry.key;
          var items = entry.value as List<dynamic>;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                child: Text(category,
                    style:
                        TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
              ),
              ...items.map<Widget>((item) {
                return Card(
                  child: ListTile(
                    title: Text(item['name']),
                    subtitle: Text('\$${item['price'].toString()}'),
                    leading: Image.network(item['image_url']),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(item['name']),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(item['description'] ?? ""),
                                SizedBox(height: 10),
                                Image.network(item['image_url']),
                                SizedBox(height: 10),
                                Text('Price: \$${item['price'].toString()}'),
                              ],
                            ),
                            actions: [
                              TextButton(
                                child: Text('Close'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                );
              }).toList(),
            ],
          );
        }).toList(),
      ),
    );
  }
}
