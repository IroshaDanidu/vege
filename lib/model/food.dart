import 'package:flutter/material.dart';

class Food {
  Food({
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.rate,
    required this.kcal,
    required this.cookingTime,
    required this.description,
  });

  String id;
  String image;
  String name;
  int price;
  double rate;
  String kcal;
  String cookingTime;
  String description;

  factory Food.fromJson(Map<String, dynamic> json) => Food(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        price: json["price"],
        rate: json["rate"].toDouble(),
        kcal: json["kcal"],
        cookingTime: json["cookingTime"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "price": price,
        "rate": rate,
        "kcal": kcal,
        "cookingTime": cookingTime,
        "description": description,
      };
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Food App'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              for (var food in dummyFoods) FoodCard(food: food),
            ],
          ),
        ),
      ),
    );
  }
}

class FoodCard extends StatelessWidget {
  final Food food;

  const FoodCard({Key? key, required this.food}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(food.image,
              height: 150, width: double.infinity, fit: BoxFit.cover),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(food.name,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('Price: \$${food.price} | Rating: ${food.rate}'),
                SizedBox(height: 8),
                Text('Cooking Time: ${food.cookingTime} | Kcal: ${food.kcal}'),
                SizedBox(height: 8),
                Text(food.description),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// List of dummy foods for testing
final dummyFoods = [
  Food(
    id: '1',
    image: 'assets/potatoes.jpg',
    name: 'Potatoes',
    price: 210,
    rate: 4.5,
    kcal: '100',
    cookingTime: '500g',
    description: ' Potatoes are starchy tuberous vegetables that come in various varieties, such as russet, red, and sweet potatoes. They are a versatile ingredient in cooking, used in dishes like mashed potatoes, fries, and casseroles. Potatoes are a good source of carbohydrates, vitamins, and minerals.',
  ),
  Food(
    id: '2',
    image: 'assets/tomatoes.jpg',
    name: 'Tomatoes',
    price: 415,
    rate: 4.5,
    kcal: '',
    cookingTime: '500g',
    description:
        'Tomatoes are vibrant, red fruits commonly used as vegetables in cooking. They are rich in vitamins, particularly vitamin C and antioxidants. Tomatoes are a key ingredient in various cuisines, contributing to sauces, salads, and soups. They come in different varieties, including cherry tomatoes and roma tomatoes.',
  ),
  Food(
    id: '3',
    image: 'assets/carrots.jpg',
    name: 'Carrots',
    price: 375,
    rate: 4,
    kcal: '20',
    cookingTime: '250g',
    description:
        'Carrots are orange-rooted vegetables known for their sweet taste and crunchy texture. They are an excellent source of beta-carotene, which the body converts into vitamin A. Carrots can be enjoyed raw as a snack, added to salads, or cooked in various dishes like soups, stews, and stir-fries.',
  ),
  Food(
    id: '4',
    image: 'assets/cucumbers.jpg',
    name: 'Cucumbers',
    price: 325,
    rate: 4.8,
    kcal: '60',
    cookingTime: '500g',
    description:
        'Cucumbers are cool, refreshing vegetables with a high water content. They are often enjoyed raw in salads, sandwiches, or as a crunchy snack. Cucumbers are low in calories and provide hydration due to their water content. They also contain vitamins and minerals, contributing to overall health and well-being.',
  ),
   
];

void main() {
  runApp(MyApp());
}
