import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bai_1/modle/cart_modle.dart';
import 'package:flutter_bai_1/modle/categories_modle.dart';
import 'package:flutter_bai_1/modle/food_categories_modle.dart';
import 'package:flutter_bai_1/modle/food_single_modle.dart';
import 'package:flutter_bai_1/modle/checkout_modle.dart';
class MyProvider extends ChangeNotifier {
  //get categories milk tea
  List<CategoriesModle> milkteaCategoriesList = [];
  late CategoriesModle milkteaCategoriesModle;
  Future<void> getMilkteaCategories() async {
    List<CategoriesModle> newMilkteaCategoriesList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .doc('fcbMhullJM7x4SaD6KDh')
        .collection('milk tea')
        .get();
    querySnapshot.docs.forEach((element) {
      milkteaCategoriesModle = CategoriesModle(
        image: element.get('image'),
        name: element.get('name'),
      );
      newMilkteaCategoriesList.add(milkteaCategoriesModle);
      milkteaCategoriesList = newMilkteaCategoriesList;
    });
    notifyListeners();
  }

  get throwMilkteaList {
    return milkteaCategoriesList;
  }
 //get categories spaghetti
  List<CategoriesModle> spaghettiCategoriesList = [];
  late CategoriesModle spaghettiCategoriesModle;
  Future<void> getSpaghettiCategories() async {
    List<CategoriesModle> newSpaghettiCategoriesList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .doc('fcbMhullJM7x4SaD6KDh')
        .collection('spaghetti')
        .get();
    querySnapshot.docs.forEach((element) {
      spaghettiCategoriesModle = CategoriesModle(
        image: element.get('image'),
        name: element.get('name'),
      );
      newSpaghettiCategoriesList.add(spaghettiCategoriesModle);
      spaghettiCategoriesList = newSpaghettiCategoriesList;
    });
    notifyListeners();
  }

  get throwSpaghetti {
    return spaghettiCategoriesList;
  }
// get categories fruit juice
  List<CategoriesModle> fruitjuiceCategoriesList = [];
  late CategoriesModle fruitjuiceCategoriesModle;
  Future<void> getFruitjuiceCategories() async {
    List<CategoriesModle> newFruitjuiceCategoriesList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .doc('fcbMhullJM7x4SaD6KDh')
        .collection('fruit juice')
        .get();
    querySnapshot.docs.forEach((element) {
      fruitjuiceCategoriesModle = CategoriesModle(
        image: element.get('image'),
        name: element.get('name'),
      );
      newFruitjuiceCategoriesList.add(fruitjuiceCategoriesModle);
      fruitjuiceCategoriesList = newFruitjuiceCategoriesList;
    });
    notifyListeners();
  }

  get throwFruitjuiceList {
    return fruitjuiceCategoriesList;
  }

  // get categories street food
  List<CategoriesModle> streetfoodCategoriesList = [];
  late CategoriesModle streetfoodCategoriesModle;
  Future<void> getStreetfoodCategories() async {
    List<CategoriesModle> newStreetfoodCategoriesList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .doc('fcbMhullJM7x4SaD6KDh')
        .collection('street food')
        .get();
    querySnapshot.docs.forEach((element) {
      streetfoodCategoriesModle = CategoriesModle(
        image: element.get('image'),
        name: element.get('name'),
      );
      newStreetfoodCategoriesList.add(streetfoodCategoriesModle);
      streetfoodCategoriesList = newStreetfoodCategoriesList;
    });
    notifyListeners();
  }

  get throwStreetfoodList {
    return streetfoodCategoriesList;
  }

  // get categories other
  List<CategoriesModle> otherCategoriesList = [];
  late CategoriesModle otherCategoriesModle;
  Future<void> getOtherCategories() async {
    List<CategoriesModle> newOtherCategoriesList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .doc('fcbMhullJM7x4SaD6KDh')
        .collection('other')
        .get();
    querySnapshot.docs.forEach((element) {
      otherCategoriesModle = CategoriesModle(
        image: element.get('image'),
        name: element.get('name'),
      );
      newOtherCategoriesList.add(otherCategoriesModle);
      otherCategoriesList = newOtherCategoriesList;
    });
    notifyListeners();
  }

  get throwOtherList {
    return otherCategoriesList;
  }

//=================================== Data Single =======================================

// get categories other
  List<SingleModle> singleList = [];
  late SingleModle singleModle;
  Future<void> getSingle() async {
    List<SingleModle> newSingleList = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('foods').get();
    querySnapshot.docs.forEach((element) {
      singleModle = SingleModle(
          image: element.get('image'),
          name: element.get('name'),
          price: element.get('price'),
          describle: element.get('describle'));
      newSingleList.add(singleModle);
      singleList = newSingleList;
    });
    notifyListeners();
  }

  get throwStreetFoodSingleList {
    return singleList;
  }

//==========================================get Food order by categories======================
  List<FoodCategoriesModle> foodCategoriesList = [];
  late FoodCategoriesModle foodCategoriesModle;
  Future<void> getFoodCategoriesList() async {
    List<FoodCategoriesModle> newFoodCategoriesList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('foodcategories')
        .doc('YlVACmgasQZCLHH36M3a')
        .collection('streetfood')
        .get();
    querySnapshot.docs.forEach((element) {
      foodCategoriesModle = FoodCategoriesModle(
          image: element.get('image'),
          name: element.get('name'),
          price: element.get('price'),
          describle: element.get('describle'));
      newFoodCategoriesList.add(foodCategoriesModle);
      foodCategoriesList = newFoodCategoriesList;
    });
    notifyListeners();
  }

  get throwFoodCategoriesList {
    return foodCategoriesList;
  }

//==========================================================add to cart===================================================
  List<CartModle> cartList = [];
  List<CartModle> newCartList = [];
  late CartModle cartModel;
  void addToCart(
      {required String image,
      required String name,
      required int price,
      required int quantity}) {
    cartModel =
        CartModle(name: name, image: image, price: price, quantity: quantity);
    newCartList.add(cartModel);
    cartList = newCartList;
  }

  get throwCartList {
    return cartList;
  }

//===============================================make total============================
  int totalPrice() {
    int total = 0;
    cartList.forEach((element) {
      total += element.price * element.quantity;
    });
    return total;
  }

//==================================================delete cart ====================================
   late int deleteIndex ;
  void getDeleteIndex(int index) {
    deleteIndex = index;
  }

  void delete(int deleteIndex) {
    print("check delete");
    print(deleteIndex);
    print(cartList);
    cartList.removeAt(deleteIndex);
    notifyListeners();
  }
}

//=================================================check out ===================================================


 Future<void> insertDataIntoFirebase(FoodCheckoutModel checkoutModel) async {
  try {
    // Step 1: Access Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Step 2: Convert your FoodCheckoutModel object into a format suitable for Firestore
    Map<String, dynamic> checkoutData = {
      'nameCustomer': checkoutModel.nameCustomer,
      'total': checkoutModel.total,
      'dateCreated': checkoutModel.dateCreated,
      'noteOrder': checkoutModel.noteOrder,
      'quantityOrder': checkoutModel.quantityOrder,
      'orderList': convertOrderListToJson(checkoutModel.orderList),
    };

    // Step 3: Insert data into Firestore
    await firestore.collection('checkOut').add(checkoutData);
  } catch (error) {
    print('Error inserting data into Firebase: $error');
  }
}

// Helper function to convert orderList to JSON
Map<String, dynamic> convertOrderListToJson(Map<FoodOrderItemModle, int> orderList) {
  Map<String, dynamic> jsonMap = {};
  orderList.forEach((foodOrderItem, quantity) {
    jsonMap[foodOrderItem.food_name] = {
      'note': foodOrderItem.note,
      'quantity': quantity,
    };
  });
  return jsonMap;
}
      
  
