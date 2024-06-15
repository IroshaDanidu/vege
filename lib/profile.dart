import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firstapp/home.dart';
import 'package:firstapp/chat.dart';
import 'package:firstapp/cart.dart';
import 'package:firstapp/login.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int indexCategory = 3; // Assuming 'Profile' is at index 3
  bool isDarkMode = false;
  File? _profileImage;
  String? profileImageUrl;

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      profileImageUrl = userDoc['profileImageUrl'];
    });
  }

  Future<void> _showImagePickerOptions() async {
    showModalBottomSheet(
      context: context,
      builder: (context) => Wrap(
        children: [
          ListTile(
            leading: Icon(Icons.photo_library),
            title: Text('Choose from Gallery'),
            onTap: () {
              _pickImage(ImageSource.gallery);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.camera_alt),
            title: Text('Take a Photo'),
            onTap: () {
              _pickImage(ImageSource.camera);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });

      // Upload to Firebase Storage
      String fileName = 'profile_${FirebaseAuth.instance.currentUser!.uid}.jpg';
      Reference storageReference =
          FirebaseStorage.instance.ref().child('profileimage/$fileName');
      UploadTask uploadTask = storageReference.putFile(_profileImage!);
      await uploadTask.whenComplete(() async {
        String downloadUrl = await storageReference.getDownloadURL();
        // Save the URL to Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
          'profileImageUrl': downloadUrl,
        });
        setState(() {
          profileImageUrl = downloadUrl;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.grey[900]! : Colors.white,
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  _showImagePickerOptions();
                  // Display storage contents
                  String storagePath = 'gs://vege-shop-eae7e.appspot.com/profileimage';
                  FirebaseStorage.instance.ref(storagePath).listAll().then((result) {
                    result.items.forEach((Reference ref) {
                      ref.getDownloadURL().then((url) {
                        print(url);
                      });
                    });
                  }).catchError((error) {
                    print(error);
                  });
                },
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.green,
                  backgroundImage: _profileImage != null
                      ? FileImage(_profileImage!)
                      : (profileImageUrl != null
                          ? NetworkImage(profileImageUrl!)
                          : AssetImage('assets/user_photo.jpg') as ImageProvider),
                ),
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
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                ),
                child: Text(
                  'Sign Out',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
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
              offset: Offset(0, -3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
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
