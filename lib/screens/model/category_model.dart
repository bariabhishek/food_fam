import 'package:food_fam/screens/model/subcategory_model.dart';

class CategoryModel{
  var id;
  var restaurantid;
  var name;
  var createat;
  var blockstatus;
  var category_id;
  var subcategory_id;
  var price;
  var description;
  var dishid;
  List<SubategoryModel> subcategory_list;

  CategoryModel(this.id, this.restaurantid, this.name, this.createat, this.blockstatus,this.subcategory_list);


}