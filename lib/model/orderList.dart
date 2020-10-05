import 'order_details.dart';

class OrderList{
  String id,name,mobile,  status;
  List<OrderDetails> orderDetails ;
  OrderList(
      this.id,this.name,this.mobile,this.status,this.orderDetails
      );

}