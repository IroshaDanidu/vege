import 'package:firstapp/home.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/chat.dart';
import 'package:firstapp/profile.dart';
import 'package:flutter/material.dart';

import '../model/food.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int indexCategory = 2; // Assuming 'Cart' is at index 2
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 2,
              child: ListTile(
                leading: Image.asset(
                  'assets/carrots.jpg', // Replace with your asset path
                ),
                title: Text('Fresh Spinach'),
                subtitle: Text('Price: \Rs .360'),
                trailing: IconButton(
                  icon: Icon(Icons.remove_circle),
                  onPressed: () {
                    // Remove item from the cart
                  },
                ),
              ),
            ),
            SizedBox(height: 16),
            Card(
              elevation: 2,
              child: ListTile(
                leading: Image.asset(
                  'assets/cucumbers.jpg', // Replace with your asset path
                ),
                title: Text('Organic Tomatoes'),
                subtitle: Text('Price: \Rs. 210'),
                trailing: IconButton(
                  icon: Icon(Icons.remove_circle),
                  onPressed: () {
                    // Remove item from the cart
                  },
                ),
              ),
            ),
            SizedBox(height: 16),
            Card(
              elevation: 2,
              child: ListTile(
                leading: Image.asset(
                  'assets/potatoes.jpg', // Replace with your asset path
                ),
                title: Text('Fresh Spinach'),
                subtitle: Text('Price: \Rs .325'),
                trailing: IconButton(
                  icon: Icon(Icons.remove_circle),
                  onPressed: () {
                    // Remove item from the cart
                  },
                ),
              ),
            ),
            SizedBox(height: 16),
            Card(
              elevation: 2,
              child: ListTile(
                leading: Image.asset(
                  'assets/tomatoes.jpg', // Replace with your asset path
                ),
                title: Text('Organic Tomatoes'),
                subtitle: Text('Price: \Rs .252'),
                trailing: IconButton(
                  icon: Icon(Icons.remove_circle),
                  onPressed: () {
                    // Remove item from the cart
                  },
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Total: \Rs .1147',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Proceed to checkout
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                onPrimary: Colors.white,
              ),
              child: Text('Proceed to Checkout'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[900] : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey[600],
          currentIndex: indexCategory,
          onTap: (index) {
            navigateToPage(index);
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
      ),
    );
  }

  void navigateToPage(int index) {
    setState(() {
      indexCategory = index;
    });
    switch (index) {
      case 0:
        // Navigate to Home page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChatPage()),
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
}
