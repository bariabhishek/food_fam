import 'order_details.dart';

class PendingOrders_ {
  List<OrderDetails> orderDetails ;
  String id, name, mobile, status, reason, date, instruction;

  PendingOrders_(this.id, this.name, this.mobile, this.status, this.reason,
      this.date, this.instruction, this.orderDetails);
}
