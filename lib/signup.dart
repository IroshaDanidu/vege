import 'package:firstapp/chat.dart';
import 'package:firstapp/home.dart';
import 'package:firstapp/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String email_address = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        brightness: Brightness.light,
        // Add other theme configurations if needed
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            height: MediaQuery.of(context).size.height - 50,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      "Sign up",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.green,
                        fontFamily: 'Pacifico',
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Create an account, It's free ",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextField(
                        style: TextStyle(color: Colors.black),
                        onChanged: (value) {
                          email_address = value;
                        },
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.brown),
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          hintText: 'Email Address',
                          hintStyle: TextStyle(color: Colors.grey[500]),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextField(
                        style: TextStyle(color: Colors.black),
                        onChanged: (value) {
                          password = value;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.brown),
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Colors.grey[500]),
                        ),
                      ),
                    ),
                  ],
                  // children: <Widget>[
                  //   inputFile(label: "Username", ),
                  //   inputFile(label: "Email"),
                  //   inputFile(label: "Password", obscureText: true),
                  //   inputFile(label: "Confirm Password", obscureText: true),
                  // ],
                ),
                Container(
                  padding: EdgeInsets.only(top: 3, left: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border:
                        Border.all(color: Colors.transparent), // Removed border
                  ),
                  child: MaterialButton(
                    onPressed: () async {
                      try {
                        final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                email: email_address, password: password);
                        if (user != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                          );
                        }
                      } catch (ex) {
                        // print('User Registration Failed');
                        print(ex);
                      }
                    },
                    minWidth: double.infinity,
                    height: 60,
                    color: Color.fromARGB(255, 47, 135, 10),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Already have an account?"),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      },
                      child: Text(
                        " Login",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// We will be creating a widget for text field
Widget inputFile({label, obscureText = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.black87,
        ),
      ),
      SizedBox(
        height: 5,
      ),
      TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.grey[400] ?? Colors.transparent),
          ),
          border: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.grey[400] ?? Colors.transparent),
          ),
        ),
      ),
      SizedBox(height: 10),
    ],
  );
}
