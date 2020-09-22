import 'package:food_fam/model/order_details.dart';

class SalesReport{
  List<OrderDetails> orderDetailList;
  String name,mobile,status;
  SalesReport(this.name, this.mobile, this.status,this.orderDetailList);

}