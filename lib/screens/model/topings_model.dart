import 'category_model.dart';

class ToppingsModel{
  var id;
  var dishId;
  var name;
  var createat;
  var price;
  var description;


  ToppingsModel(
      this.id,
      this.dishId,
      this.name,
      this.createat,
      this.price,
      this.description,
     );

  Map<String, dynamic> toJson(){
    return {
      'name': this.name,
      'price': this.price,
    };
  }
}