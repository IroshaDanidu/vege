import 'package:flutter/material.dart';
import 'package:firstapp/chat.dart';
import 'package:firstapp/cart.dart';
import 'package:firstapp/favorite.dart';
import 'package:firstapp/model/food.dart';
import 'package:firstapp/detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int indexCategory = 0;
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
      appBar: AppBar(
        title: Text(
          'FreshVeggies',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            fontFamily: 'Pacifico',
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
            onPressed: () {
              setState(() {
                isDarkMode = !isDarkMode;
              });
            },
            color: Colors.black,
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 2.0,
        shadowColor: Colors.grey.withOpacity(0.5),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
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
            setState(() {
              indexCategory = index;
            });
            navigateToPage(index);
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Chat',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorite',
              backgroundColor: Colors.white,
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          header(),
          const SizedBox(height: 30),
          title(),
          const SizedBox(height: 20),
          search(),
          const SizedBox(height: 30),
          categories(),
          const SizedBox(height: 20),
          gridFood(),
        ],
      ),
    );
  }

 Widget header() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      children: [
        Material(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(8),
            child: Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              child: const Icon(Icons.menu, color: Colors.black),
            ),
          ),
        ),
        const Spacer(),
        Icon(
          Icons.location_on,
          color: isDarkMode ? Colors.green : Colors.black,
          size: 18,
        ),
        Text(
          'Bandarawela, Sri Lanka',
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        const Spacer(),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            'assets/new.jpg',
            fit: BoxFit.cover,
            width: 60,
            height: 60,
          ),
        ),
      ],
    ),
  );
}

  Widget title() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Hi Irosha Rajapaksha',
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          Text(
            'Find your Fresh Veggies',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 34,
            ),
          ),
        ],
      ),
    );
  }

  Widget search() {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.fromLTRB(8, 2, 6, 2),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: const Icon(Icons.search, color: Colors.green),
                hintText: 'Search for veggies',
                hintStyle: TextStyle(color: Colors.grey[600]),
              ),
            ),
          ),
          Material(
            color: Colors.green,
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: 50,
                height: 50,
                alignment: Alignment.center,
                child: const Icon(Icons.bar_chart, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget categories() {
    List list = ['Fresh Veggies', 'Customized Packs', 'Ready-to-Cook'];
    return SizedBox(
      height: 40,
      child: ListView.builder(
        itemCount: list.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                indexCategory = index;
              });
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(
                index == 0 ? 16 : 16,
                0,
                index == list.length - 1 ? 16 : 16,
                0,
              ),
              alignment: Alignment.center,
              child: Text(
                list[index],
                style: TextStyle(
                  fontSize: 22,
                  color: indexCategory == index ? Colors.green : Colors.grey,
                  fontWeight: indexCategory == index ? FontWeight.bold : null,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget gridFood() {
    return GridView.builder(
      itemCount: dummyFoods.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        mainAxisExtent: 360,
      ),
      itemBuilder: (context, index) {
        Food food = dummyFoods[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DetailPage(food: food);
            }));
          },
          child: Container(
            height: 360,
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.grey[800] : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      food.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        food.name,
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            food.cookingTime,
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 18),
                              const SizedBox(width: 4),
                              Text(
                                food.rate.toString(),
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '\RS. ${food.price}',
                        style: TextStyle(
                          color: isDarkMode ? Colors.green : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: () {
                      // Add to Cart functionality
                      // You can implement your logic for adding to the cart here
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Add to Cart',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void navigateToPage(int index) {
    switch (index) {
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
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FavoritePage()),
        );
        break;
    }
  }
}
