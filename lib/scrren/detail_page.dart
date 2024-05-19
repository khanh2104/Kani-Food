import 'package:flutter/material.dart';
import 'package:flutter_bai_1/provider/my_provider.dart';
import 'package:flutter_bai_1/scrren/cart_page.dart';
import 'package:flutter_bai_1/scrren/home_page.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  final String image;
  final String name;
  final int price;
  final String describle;
  DetailPage({
    required this.image,
    required this.name,
    required this.price,
    required this.describle,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int quantity = 1;
  int count = 0;
  void _decrementQuantity() {
    if (quantity > 0) {
      setState(() {
        quantity--;
      });
    }
  }

  void _incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  @override
  Widget build(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
        ),
      ),
      body: Column(children: [
        Expanded(
          child: Container(
            child: CircleAvatar(
              radius: 110,
              backgroundImage: NetworkImage(widget.image),
            ),
          ),
        ),
        Expanded(
            child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(fontSize: 40, color: Colors.black),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _decrementQuantity();
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10)),
                            child: Icon(Icons.remove_circle_outline),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          quantity.toString(),
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            _incrementQuantity();
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10)),
                            child: Icon(Icons.add_circle_outline),
                          ),
                        )
                      ],
                    ),
                    Text(
                      "${widget.price}" + "K",
                      style: TextStyle(color: Colors.black, fontSize: 30),
                    ),
                  ],
                ),
                Text(
                  "Mô tả :",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.describle,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 19,
                  ),
                ),
                Spacer(),
                Container(
                  height: 55,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (quantity > 0) {
                        provider.addToCart(
                            image: widget.image,
                            name: widget.name,
                            price: widget.price,
                            quantity: quantity);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => CartPage(),
                        ));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: quantity > 0
                          ? Color.fromARGB(255, 248, 250, 248)
                          : Color.fromARGB(255, 10, 76, 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_cart,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Add to Cart",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        )
                      ],
                    ),
                  ),
                )
              ]),
        ))
      ]),
    );
  }
}
