import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green,
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
        title: Text('Vegetable Categories'),
      ),
      body: VegetableCategories(),
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
          MaterialPageRoute(builder: (context) => VegetableDetailPage(vegetable: vegetable)),
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
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    vegetable.description,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 200.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(vegetable.imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 16.0),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Description: ${vegetable.description}',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ],
      ),
    );
  }
}

class Vegetable {
  final String name;
  final String description;
  final String imagePath;

  Vegetable({
    required this.name,
    required this.description,
    required this.imagePath,
  });
}

List<Vegetable> vegetableData = [
  Vegetable(
    name: 'Carrot',
    description: 'A crunchy vegetable with a sweet taste.',
    imagePath: 'assets/carrot.jpg',
  ),
  Vegetable(
    name: 'Broccoli',
    description: 'Nutrient-rich green vegetable with a unique taste.',
    imagePath: 'assets/broccoli.jpg',
  ),
  // Add more vegetables as needed
  Vegetable(
    name: 'Spinach',
    description: 'Dark leafy green loaded with vitamins and minerals.',
    imagePath: 'assets/carrots.jpg',
  ),
  Vegetable(
    name: 'Bell Pepper',
    description: 'Colorful and crisp vegetable perfect for salads.',
    imagePath: 'assets/bell_pepper.jpg',
  ),
  Vegetable(
    name: 'Tomato',
    description: 'Juicy red vegetable often used in cooking and salads.',
    imagePath: 'assets/tomato.jpg',
  ),
  Vegetable(
    name: 'Cucumber',
    description: 'Cool and refreshing vegetable commonly used in salads.',
    imagePath: 'assets/cucumber.jpg',
  ),
  Vegetable(
    name: 'Kale',
    description: 'Superfood with a rich nutrient profile and earthy flavor.',
    imagePath: 'assets/kale.jpg',
  ),
  Vegetable(
    name: 'Zucchini',
    description: 'Versatile vegetable often used in savory dishes.',
    imagePath: 'assets/zucchini.jpg',
  ),
  Vegetable(
    name: 'Eggplant',
    description: 'Purple vegetable with a meaty texture.',
    imagePath: 'assets/eggplant.jpg',
  ),
  Vegetable(
    name: 'Sweet Potato',
    description: 'Nutrient-dense root vegetable with a sweet taste.',
    imagePath: 'assets/sweet_potato.jpg',
  ),
  Vegetable(
    name: 'Asparagus',
    description: 'Tender green vegetable with a unique spear-like shape.',
    imagePath: 'assets/asparagus.jpg',
  ),
  Vegetable(
    name: 'Cauliflower',
    description: 'Versatile white vegetable often used as a low-carb alternative.',
    imagePath: 'assets/cauliflower.jpg',
  ),
  Vegetable(
    name: 'Mushroom',
    description: 'Fungi with a savory taste used in various dishes.',
    imagePath: 'assets/mushroom.jpg',
  ),
];
