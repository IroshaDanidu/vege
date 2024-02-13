import 'package:flutter/material.dart';
import 'package:firstapp/home.dart';
import 'package:firstapp/chat.dart';
import 'package:firstapp/cart.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int indexCategory = 3; // Assuming 'Profile' is at index 3
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: SingleChildScrollView( // Wrap with SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 80,
                backgroundColor: Colors.green,
                backgroundImage: AssetImage(
                    'assets/user_photo.jpg'), // Replace with your user photo
              ),
              SizedBox(height: 16),
              Text(
                'Irosha Rajapaksha',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'iro7899rajapaksha@gmail.com',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 24),
              Divider(
                height: 20,
                thickness: 2,
                color: Colors.green,
              ),
              SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.phone, color: Colors.green),
                title: Text(
                  'Phone Number',
                  style: TextStyle(fontSize: 18),
                ),
                subtitle: Text(
                  '+94 (76) 684 0032',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              ListTile(
                leading: Icon(Icons.location_on, color: Colors.green),
                title: Text(
                  'Address',
                  style: TextStyle(fontSize: 18),
                ),
                subtitle: Text(
                  'Bandarawela, Sri Lanka',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  // Add your logic for editing the profile here
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                ),
                child: Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
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
          type: BottomNavigationBarType.fixed, // Change to fixed
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
      case 2:
        // Navigate to Cart page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CartPage()),
        );
        break;
      default:
        break;
    }
  }
}
