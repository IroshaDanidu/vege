import 'package:flutter/material.dart';
import 'cart.dart';
import 'package:firstapp/profile.dart';
import 'package:firstapp/home.dart';
import '../model/food.dart';

bool isDarkMode = false; // Define isDarkMode variable
int indexCategory = 1; // Define indexCategory variable

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Quicksand',
      ),
      home: ChatPage(),
    );
  }
}

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vegetables'),
      ),
      body: VegetableCategories(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey[600],
        currentIndex: indexCategory,
        onTap: (index) {
          navigateToPage(index, context); 
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_florist),
            label: 'Vegetables',
            backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
            backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: 'Profile',
            backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
          ),
        ],
      ),
    );
  }
}

class VegetableCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: vegetableData.length,
      itemBuilder: (context, index) {
        return VegetableCard(vegetable: vegetableData[index]);
      },
    );
  }
}

class VegetableCard extends StatelessWidget {
  final Vegetable vegetable;

  VegetableCard({required this.vegetable});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VegetableDetailPage(vegetable: vegetable),
          ),
        );
      },
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        margin: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 150.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
                image: DecorationImage(
                  image: AssetImage(vegetable.imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    vegetable.name,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    vegetable.description,
                    style: TextStyle(fontSize: 16.0, color: Colors.black87),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          addToCart(vegetable);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                        ),
                        child: Text(
                          'Add to Cart',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Text(
                        '\Rs .${vegetable.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addToCart(Vegetable vegetable) {
    print('Added ${vegetable.name} to the cart');
    // Add your logic for adding to cart
  }
}

class VegetableDetailPage extends StatelessWidget {
  final Vegetable vegetable;

  VegetableDetailPage({required this.vegetable});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(vegetable.name),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 300.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(vegetable.imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  vegetable.name,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  ' ${vegetable.description}',
                  style: TextStyle(fontSize: 18.0, color: Colors.black87),
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        addToCart(vegetable);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                      ),
                      child: Text(
                        'Add to Cart',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Text(
                      '\Rs .${vegetable.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_florist),
            label: 'Vegetables',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          navigateToPage(index, context);
        },
      ),
    );
  }

  void addToCart(Vegetable vegetable) {
    print('Added ${vegetable.name} to the cart');
  }
}

class Vegetable {
  final String name;
  final String description;
  final String imagePath;
  final double price;

  Vegetable({
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
  });
}

List<Vegetable> vegetableData = [
  Vegetable(
    name: 'Carrot',
    description: 'A crunchy vegetable with a sweet taste.',
    imagePath: 'assets/carrots.jpg',
    price: 200,
  ),
  Vegetable(
    name: 'Broccoli',
    description: 'Nutrient-rich green vegetable with a unique taste.',
    imagePath: 'assets/broccoli.jpg',
    price: 249,
  ),
  Vegetable(
    name: 'Tomatoes',
    description: 'Nutrient-rich red vegetable with a unique taste.',
    imagePath: 'assets/tomatoes.jpg',
    price: 350,
  ),
  Vegetable(
    name: 'Potatoes',
    description: 'Versatile vegetable used in various dishes.',
    imagePath: 'assets/potatoes.jpg',
    price: 449,
  ),
  Vegetable(
    name: 'Cucumbers',
    description: 'Nutrient-rich green vegetable with a unique taste.',
    imagePath: 'assets/cucumbers.jpg',
    price: 309,
  ),
];

void addToCart(Vegetable vegetable) {
  print('Added ${vegetable.name} to the cart');
}

void navigateToPage(int index, BuildContext context) {
  switch (index) {
    case 0:
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
      break;
    case 1:
      // Navigate to Vegetables page
      Navigator.popUntil(context, ModalRoute.withName('/'));
      break;
    case 2:
      // Navigate to Cart page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CartPage()),
      );
      break;
    case 3:
      // Navigate to Profile page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()),
      );
      break;
    default:
      break;
  }
}
