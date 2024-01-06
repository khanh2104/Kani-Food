import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bai_1/modle/categories_modle.dart';

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
  }

  get throwMilkteaList {
    return milkteaCategoriesList;
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
  }

  get throwStreetfoodList {
    return streetfoodCategoriesList;
  }

  // get categories other
  List<CategoriesModle> otherCategoriesList = [];
  late CategoriesModle otherCategoriesModle;
  Future<void> getOtherCatetjgories() async {
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
  }

  get throwOtherList {
    return otherCategoriesList;
  }
}
