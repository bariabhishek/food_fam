import 'package:food_fam/model/toppings_model.dart';

class OrderDetails{
  String orderId,orderName,orderPrice,orderQuantity,orderConditions,orderassociatedModel;
  List <ToppingsDishModel> topingMainList;
  OrderDetails( this.orderId, this.orderName, this.orderPrice, this.orderQuantity,this.orderConditions, this.orderassociatedModel,this.topingMainList);
}