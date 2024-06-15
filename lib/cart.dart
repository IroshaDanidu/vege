import 'package:firstapp/main.dart';
import 'package:flutter/material.dart';
import '../model/food.dart';
import 'package:firstapp/home.dart';

class CartPage extends StatefulWidget {
  static List<Food> cartItems = []; // List to store cart items

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
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
            if (CartPage.cartItems.isEmpty)
              Center(
                child: Text('Your cart is empty'),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: CartPage.cartItems.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 2,
                      child: ListTile(
                        leading: Image.asset(
                          CartPage.cartItems[index].image,
                          width: 50,
                          height: 50,
                        ),
                        title: Text(CartPage.cartItems[index].name),
                        subtitle: Text(
                            'Price: \Rs ${CartPage.cartItems[index].price}'),
                        trailing: IconButton(
                          icon: Icon(Icons.remove_circle),
                          onPressed: () {
                            removeFromCart(index);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            SizedBox(height: 16),
            Text(
              'Total: \Rs ${calculateTotal()}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                checkout();
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

  void removeFromCart(int index) {
    setState(() {
      CartPage.cartItems.removeAt(index);
    });
  }

  int calculateTotal() {
    int total = 0;
    for (var item in CartPage.cartItems) {
      total += item.price;
    }
    return total;
  }

  void checkout() {
    // Clear the cart
    setState(() {
      CartPage.cartItems.clear();
    });

    // Show a SnackBar with a beautiful message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Order placed successfully',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
    );

    
  }
}
