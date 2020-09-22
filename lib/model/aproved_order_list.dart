import 'order_details.dart';

class AproverdOrders {
  List<OrderDetails> orderDetails ;
  String id, name, mobile, status, reason, date, instruction;

  AproverdOrders(this.id, this.name, this.mobile, this.status, this.reason,
      this.date, this.instruction, this.orderDetails);
}
