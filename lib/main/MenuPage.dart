import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_qrless/main/MainPageView.dart';


class MenuPage extends StatefulWidget {
  final Map<String, dynamic> menu;

  MenuPage({Key? key, required this.menu}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  late List<Item> data;

  @override
  void initState() {
    super.initState();
    data = widget.menu.keys.map((key) {
      return Item(
        header: key,
        expandedValue: widget.menu[key],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menu')),
      body: SingleChildScrollView(
        child: Container(
          child: ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                data[index].isExpanded = !isExpanded;
              });
            },
            children: data.map<ExpansionPanel>((Item item) {
              return ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: Text(item.header),
                  );
                },
                body: Column(
                  children: item.expandedValue.map<Widget>((i) {
                    return ListTile(
                      title: Text(i['name']),
                      subtitle: Text('\$${i['price'].toString()}'),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(i['name']),
                              content: Column(
                                children: [
                                  Text(i['description']),
                                  SizedBox(height: 10),
                                  Image.network(i['image_url']),
                                  SizedBox(height: 10),
                                  Text('Price: \$${i['price'].toString()}'),
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
                    );
                  }).toList(),
                ),
                isExpanded: item.isExpanded,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class Item {
  Item({
    required this.expandedValue,
    required this.header,
    this.isExpanded = false,
  });

  List expandedValue;
  String header;
  bool isExpanded;
}
