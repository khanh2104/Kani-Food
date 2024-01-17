import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Bottomcontainer extends StatelessWidget {
  final String image;
  final String name;
  final int price;
  Bottomcontainer({
    // required void Function() onTap,
    required this.image,
    required this.name,
    required this.price, 
  });
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(image),
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
            leading: Container(
              width: 120,
              height: 50,
              child: Text(
                name,
                style: TextStyle(fontSize: 20, color: Colors.black, height: 1),
              ),
            ),
            trailing: Text(
              "$price" + "K",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
