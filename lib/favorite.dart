import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Page'),
      ),
      body: Center(
        child: const Text('Your favorite items will appear here.'),
      ),
    );
  }
}
