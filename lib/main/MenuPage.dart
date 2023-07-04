import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_qrless/main/MainPageView.dart';

void main() {
  runApp(MenuApp());
}

class MenuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MenuPage(),
    );
  }
}

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {

  //Image url'leri değişir
  final menuJson = '''{
    "menu": {
      "burgers": [
        {
          "name": "Whopper",
          "description": "A quarter pound of savory flame-grilled beef topped with juicy tomatoes, fresh lettuce, creamy mayonnaise, ketchup, crunchy pickles, and sliced white onions on a soft sesame seed bun.",
          "price": 4.99,
          "image_url": "https://example.com/images/whopper.jpg"
        },
        {
          "name": "Impossible Whopper",
          "description": "100% Whopper, 0% Beef. Our Impossible™ WHOPPER® Sandwich features a savory flame-grilled patty made from plants topped with juicy tomatoes, fresh lettuce, creamy mayonnaise, ketchup, crunchy pickles, and sliced white onions on a soft sesame seed bun.",
          "price": 5.49,
          "image_url": "https://example.com/images/impossible_whopper.jpg"
        },
        {
          "name": "Bacon King",
          "description": "Our Bacon King Sandwich features two quarter-pound savory flame-grilled beef patties, topped with thick-cut smoked bacon, melted American cheese, ketchup, and creamy mayonnaise on a soft sesame seed bun.",
          "price": 6.99,
          "image_url": "https://example.com/images/bacon_king.jpg"
        },
        {
          "name": "Cheeseburger",
          "description": "A classic cheeseburger made with a quarter pound of flame-grilled beef, topped with melted American cheese, pickles, ketchup, and mustard on a toasted sesame seed bun.",
          "price": 3.99,
          "image_url": "https://example.com/images/cheeseburger.jpg"
        }
      ],
      "sides": [
        {
          "name": "Chicken Fries",
          "description": "Made with white meat chicken, our Chicken Fries are coated in a light crispy breading seasoned with savory spices and herbs. Chicken Fries are shaped like fries and are perfect to dip in any of our delicious dipping sauces.",
          "price": 2.99,
          "image_url": "https://example.com/images/chicken_fries.jpg"
        },
        {
          "name": "Onion Rings",
          "description": "Crispy and golden on the outside, and sweet and tender on the inside, our Onion Rings are a perfect side to complement your meal.",
          "price": 1.99,
          "image_url": "https://example.com/images/onion_rings.jpg"
        }
      ],
      "drinks": [
        {
          "name": "Coca-Cola",
          "price": 1.99,
          "image_url": "https://example.com/images/coca_cola.jpg"
        },
        {
          "name": "Sprite",
          "price": 1.99,
          "image_url": "https://example.com/images/sprite.jpg"
        },
        {
          "name": "Fanta Orange",
          "price": 1.79,
          "image_url": "https://example.com/images/fanta_orange.jpg"
        }
      ]
    }
  }''';
  var menu;
  List<Item> data = [];

  @override
  void initState() {
    super.initState();
    menu = json.decode(menuJson)['menu'];
    menu.keys.forEach((key) {
      data.add(Item(header: key, expandedValue: menu[key]));
    });
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
