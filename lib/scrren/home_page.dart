import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bai_1/modle/categories_modle.dart';
import 'package:flutter_bai_1/modle/food_categories_modle.dart';
import 'package:flutter_bai_1/modle/food_single_modle.dart';
import 'package:flutter_bai_1/provider/my_provider.dart';
import 'package:flutter_bai_1/scrren/categories.dart';
import 'package:flutter_bai_1/scrren/detail_page.dart';
import 'package:flutter_bai_1/scrren/widget/bottom_container.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<CategoriesModle> milkTeaList = [];
  List<CategoriesModle> fruitjuiceList = [];
  List<CategoriesModle> otherList = [];
  List<CategoriesModle> streetFoodList = [];
  List<SingleModle> streetFoodSingleList = [];
  List<FoodCategoriesModle> foodCategories = [];
  Widget categoriesContainer({
    required void Function() onTap,
    required String image,
    required String name,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            margin: EdgeInsets.only(left: 20),
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          name,
          style: TextStyle(fontSize: 15, color: Colors.black),
        ),
      ],
    );
  }

  Widget drawerItem({required String name, required IconData icon}) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.black,
      ),
      title: Text(
        name,
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  Widget milkteaCategoriesComponent() {
    return Row(
      children: milkTeaList
          .map((e) =>
              categoriesContainer(image: e.image, name: e.name, onTap: () {}))
          .toList(),
    );
  }

  Widget fruitjuiceCategoriesComponent() {
    return Row(
      children: fruitjuiceList
          .map((e) =>
              categoriesContainer(image: e.image, name: e.name, onTap: () {}))
          .toList(),
    );
  }

  Widget streetfoodCategoriesComponent() {
    return Row(
      children: streetFoodList
          .map((e) => categoriesContainer(
              image: e.image,
              name: e.name,
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => Categories(list: foodCategories)));
              }))
          .toList(),
    );
  }

  Widget otherCategoriesComponent() {
    return Row(
      children: otherList
          .map((e) =>
              categoriesContainer(image: e.image, name: e.name, onTap: () {}))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context);
    provider.getMilkteaCategories();
    milkTeaList = provider.throwMilkteaList;

    provider.getFruitjuiceCategories();
    fruitjuiceList = provider.throwFruitjuiceList;

    provider.getStreetfoodCategories();
    streetFoodList = provider.throwStreetfoodList;

    provider.getOtherCategories();
    otherList = provider.throwOtherList;

    //===================================Single =================================
    provider.getSingle();
    streetFoodSingleList = provider.throwStreetFoodSingleList;
    //===================================get list categories =====================
    provider.getFoodCategoriesList();
    foodCategories = provider.throwFoodCategoriesList;
    streetFoodSingleList = provider.throwStreetFoodSingleList;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: Drawer(
        child: SafeArea(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('images/background.jpg'),
                    ),
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage('images/profile.jpg'),
                  ),
                  accountName: Text("Nhi nhỏ",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  accountEmail: Text("Nhinho7791@gmail.com",
                      style: TextStyle(fontSize: 16)),
                ),
                drawerItem(icon: Icons.person, name: "Profile"),
                drawerItem(icon: Icons.add_shopping_cart, name: "Cart"),
                drawerItem(icon: Icons.shop, name: "Order"),
                drawerItem(icon: Icons.info_outline_rounded, name: "About"),
                Divider(
                  thickness: 2,
                  color: Color.fromARGB(255, 232, 118, 118),
                ),
                ListTile(
                  leading: Text(
                    "Setting",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
                drawerItem(name: "Change", icon: Icons.lock),
                drawerItem(name: "Log out", icon: Icons.exit_to_app),
              ]),
        ),
      ),
      appBar: AppBar(
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('images/profile.jpg'),
            ),
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          TextField(
            decoration: InputDecoration(
              hintText: "Search Food",
              hintStyle: TextStyle(color: Colors.white),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              filled: true,
              fillColor: Color.fromARGB(255, 232, 118, 118),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                milkteaCategoriesComponent(),
                fruitjuiceCategoriesComponent(),
                streetfoodCategoriesComponent(),
                otherCategoriesComponent()
              ],
            ),
          ),
          Container(
            height: 510,
            child: GridView.count(
                shrinkWrap: false,
                primary: false,
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: streetFoodSingleList
                    .map(
                      (e) => GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => DetailPage(
                                image: e.image,
                                name: e.name,
                                price: e.price,
                              ),
                            ),
                          );
                        },
                        child: Bottomcontainer(
                          image: e.image,
                          name: e.name,
                          price: e.price,
                        ),
                      ),
                    )
                    .toList()
                // children: [
                // bottomContainer(
                //     image: 'images/trasua.jpg',
                //     name: 'trà sữa trân châu đen',
                //     price: 123),
                // bottomContainer(
                //     image: 'images/banhtrang.jpg',
                //     name: 'bánh tráng trộn ab',
                //     price: 123),
                // bottomContainer(
                //     image: 'images/trasua.jpg', name: 'trà sữa', price: 123),
                // bottomContainer(
                //     image: 'images/banhtrang.jpg',
                //     name: 'bánh tráng',
                //     price: 123),
                // ],
                ),
          ),
        ]),
      ),
    );
  }
}
