import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vegetable Shop Cart',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CartPage(),
    );
  }
}

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                leading: Image.asset('assets/carrots.jpg'), // Replace with your asset path
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
                leading: Image.asset('assets/cucumbers.jpg'), // Replace with your asset path
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
                leading: Image.asset('assets/potatoes.jpg'), // Replace with your asset path
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
                leading: Image.asset('assets/tomatoes.jpg'), // Replace with your asset path
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
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
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
    );
  }
}
