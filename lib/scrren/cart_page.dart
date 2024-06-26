import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bai_1/modle/cart_modle.dart';
import 'package:flutter_bai_1/modle/checkout_modle.dart';
import 'package:flutter_bai_1/provider/my_provider.dart';
import 'package:flutter_bai_1/scrren/home_page.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  Widget cartItem(
      {required String image,
      required String name,
      required int price,
      required void Function() onTap,
      required int quantity}) {
    return Row(
      children: [
        Container(
          width: 170,
          height: 170,
          child: CircleAvatar(
            backgroundImage: NetworkImage(image),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
            child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "burger bhout acha hain",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(
                    "\$ $price",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text(
                        "$quantity",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      )
                    ],
                  )
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.close, color: Colors.black),
              onPressed: onTap,
            )
          ],
        )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context);
    var total = provider.totalPrice();
    return Scaffold(
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 65,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(10),
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text("$total" + "K",
              style: TextStyle(color: Colors.black, fontSize: 30)),
          ElevatedButton(
              onPressed: () {
                // Retrieve the MyProvider instance
                MyProvider provider =
                    Provider.of<MyProvider>(context, listen: false);

                // Calculate the total price
                // var total = provider.totalPrice();

                // Create a FoodCheckoutModel instance
                FoodCheckoutModel checkoutModel = FoodCheckoutModel(
                  nameCustomer: "Nhinho",
                  total: total,
                  dateCreated: DateTime.now(),
                  noteOrder: "Note for order", // Replace with actual note
                  quantityOrder: provider.cartList.length,
                  orderList: convertCartToOrderList(provider.cartList),
                );

                // Insert data into Firebase
                insertDataIntoFirebase(checkoutModel).then((_) {
                  // Clear the cart after successful insertion
                  // provider.clearCart();

                  // Navigate to home page
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                }).catchError((error) {
                  // Handle error if insertion fails
                  print('Error inserting data into Firebase: $error');
                  // Optionally, show an error message to the user
                });
              },
              child: Text("Thanh toán",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold)))
        ]),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
        ),
      ),
      body: ListView.builder(
        itemCount: provider.cartList.length,
        itemBuilder: (ctx, index) {
          return cartItem(
              image: provider.cartList[index].image,
              name: provider.cartList[index].name,
              price: provider.cartList[index].price,
              quantity: provider.cartList[index].quantity,
              onTap: () {
                provider.delete(index);
              });
        },
      ),
    );
  }
}

Map<FoodOrderItemModle, int> convertCartToOrderList(List<CartModle> cartList) {
  
  Map<FoodOrderItemModle, int> orderList = {};

  cartList.forEach((cartItem) {
    // Assuming your FoodOrderItemModle class has a property 'name' representing the food name
    // String foodName = cartItem.food_name;
    FoodOrderItemModle orderItem = FoodOrderItemModle(
      food_name: cartItem.name,
      note: "burger bhout acha hain",
      quantity: cartItem.quantity,
    );
    orderList[orderItem] = cartItem.quantity;
  });
  return orderList;
}
