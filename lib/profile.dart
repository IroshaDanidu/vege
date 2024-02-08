import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vegetable Shop',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Padding(
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
                'Bandarawela , SriLanka',
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
    );
  }
}
