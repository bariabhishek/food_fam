import 'package:food_fam/screens/model/dish_model.dart';

class SubategoryModel{
  var id;
  var restaurantid;
  var name;
  var createat;
  var blockstatus;
  var category_id;

  List<DishModel> dish_list;

  SubategoryModel(this.id, this.restaurantid, this.name, this.createat, this.blockstatus, this.category_id, this.dish_list);
}