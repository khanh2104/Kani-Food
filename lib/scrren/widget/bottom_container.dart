import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Bottomcontainer extends StatelessWidget {
  final String image;
  final String name;
  final int price;
  final String describle;
  Bottomcontainer({
    // required void Function() onTap,
    required this.image,
    required this.name,
    required this.price,
    required this.describle,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(image),
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,

          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style:
                      TextStyle(fontSize: 20, color: Colors.black, height: 1),
                ),
                Text(
                  describle,
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  "$price" + "K",
                  style: TextStyle(
                      fontSize: 18, color: Color.fromARGB(255, 227, 24, 24)),
                ),
              ],
            ),
          ),

          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.add_shopping_cart,
                    color: Colors.green,
                  ),
                  onPressed: () {
                    // Bạn có thể thêm hành động khi nhấn vào biểu tượng giỏ hàng ở đây
                    print('Cart icon pressed');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
