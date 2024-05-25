import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bai_1/modle/categories_modle.dart';
import 'package:flutter_bai_1/modle/food_categories_modle.dart';
import 'package:flutter_bai_1/modle/food_single_modle.dart';
import 'package:flutter_bai_1/provider/my_provider.dart';
import 'package:flutter_bai_1/scrren/categories.dart';
import 'package:flutter_bai_1/scrren/detail_page.dart';
import 'package:flutter_bai_1/scrren/login_page.dart';
import 'package:flutter_bai_1/scrren/widget/bottom_container.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<CategoriesModle> milkTeaList = [];
  List<CategoriesModle> fruitjuiceList = [];
  List<CategoriesModle> spaghettiList = [];
  List<CategoriesModle> otherList = [];
  List<CategoriesModle> streetFoodList = [];
  List<SingleModle> streetFoodSingleList = [];
  List<SingleModle> filterSearch = [];
  List<FoodCategoriesModle> foodCategories = [];
  final searchQuery = new TextEditingController();
  Timer? _debounce;
  String searchText = "false";
  int _cartItemCount = 2;

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  void initState() {
    super.initState();
    
    searchQuery.addListener(_onSearchChange);
  }

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

  Widget drawerItem({
    required String name,
    required IconData icon,
    Future<void> Function()? onTap,
  }) {
    return ListTile(
      onTap: onTap != null
          ? () async {
              try {
                await onTap();
              } catch (error) {
                // Handle error if needed
                print('Error: $error');
              }
            }
          : null,
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

  Widget spaghettiCategoriesComponent() {
    return Row(
      children: spaghettiList
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

    provider.getSpaghettiCategories();
    spaghettiList = provider.throwSpaghetti;
    //===================================Single =================================
    provider.getSingle();
    streetFoodSingleList = provider.throwStreetFoodSingleList;
    // filterSearch = streetFoodSingleList;
    // searchQuery.addListener(_onSearchChange);
    // filterSearch = searchText.isEmpty
    //     ? streetFoodSingleList
    //     : streetFoodSingleList
    //         .where((item) =>
    //             item.name.toLowerCase().contains(searchText.toLowerCase()))
    //         .toList();
    //===================================get list categories =====================
    provider.getFoodCategoriesList();
    foodCategories = provider.throwFoodCategoriesList;
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
                drawerItem(
                    name: "Log out", icon: Icons.exit_to_app, onTap: signOut),
              ]),
        ),
      ),
      appBar: AppBar(
        elevation: 0.0,
        actions: [
          Row(
            children: [
              Stack(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      // Bạn có thể thêm hành động khi nhấn vào biểu tượng giỏ hàng ở đây
                      print('Cart icon pressed');
                    },
                  ),
                  Positioned(
                    right: 4,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 18,
                        minHeight: 2,
                      ),
                      child: Text(
                        '$_cartItemCount',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(9.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage('images/profile.jpg'),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          TextField(
            controller: searchQuery,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 10),
              hintText: "Hãy tìm kiếm món bạn yêu thích nhé ",
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
                spaghettiCategoriesComponent(),
                otherCategoriesComponent()
              ],
            ),
          ),
          // SizedBox(height: 20,),
          Container(
            height: 500,
           
            child: ListView.separated(
              itemCount: filterSearch.length,
              itemBuilder: (context, index) {
                final item = filterSearch[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DetailPage(
                          image: item.image,
                          name: item.name,
                          price: item.price,
                          describle: item.describle,
                        ),
                      ),
                    );
                  },
                  child: Bottomcontainer(
                    image: item.image,
                    name: item.name,
                    price: item.price,
                    describle: item.describle,
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  color: Colors.grey,
                  thickness: 1.0,
                );
              },
            ),
          ),
        ]),
      ),
    );
  }

  @override
  void dispose() {
    searchQuery.removeListener(_onSearchChange);
    searchQuery.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChange() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        searchText = searchQuery.text;
        filterSearch = searchText.isEmpty
            ? streetFoodSingleList
            : streetFoodSingleList
                .where((item) =>
                    item.name.toLowerCase().contains(searchText.toLowerCase()))
                .toList();

      });
    });
  }
}
