class FoodCheckoutModel {
  final String nameCustomer;
  final int total;
  final DateTime dateCreated;
  final String noteOrder;
  final int quantityOrder;
  final Map<FoodOrderItemModle, int> orderList;

  FoodCheckoutModel({
    required this.nameCustomer,
    required this.total,
    required this.dateCreated,
    required this.noteOrder,
    required this.quantityOrder,
    required this.orderList,
  });
}

class FoodOrderItemModle {
  final String food_name;
  final String note;  
  final int quantity;
  FoodOrderItemModle(
      {required this.food_name, required this.note, required this.quantity});
}
