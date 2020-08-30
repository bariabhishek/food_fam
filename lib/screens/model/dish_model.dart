import 'category_model.dart';

class DishModel{
  var id;
  var restaurantid;
  var name;
  var createat;
  var blockstatus;
  var category_id;
  var subcategory_id;
  var price;
  var description;


  DishModel(
      this.id,
      this.restaurantid,
      this.name,
      this.createat,
      this.blockstatus,
      this.category_id,
      this.subcategory_id,
      this.price,
      this.description,
     );
}