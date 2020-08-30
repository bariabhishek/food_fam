import 'package:flutter/material.dart';
import 'package:food_fam/theme/theme.dart';
import 'package:food_fam/utils/app_routes.dart';
import 'package:food_fam/utils/size_config.dart';

import 'dish_edit_history.dart';
import 'model/dish_model.dart';
import 'model/subcategory_model.dart';

class CategoryExpanseListItem extends StatefulWidget {
  var id;
  var restaurantid;
  var category_name;
  var createat;
  var blockstatus;
  List<SubategoryModel> _subCategoryList;
  List<DishModel> _dishList;
  GestureTapCallback addSubcategory, addDish;

  CategoryExpanseListItem(this.id, this.restaurantid, this.category_name,
      this.createat, this.blockstatus, this._subCategoryList,
      {this.addSubcategory, this.addDish});

  @override
  _CategoryExpanseListItemState createState() =>
      _CategoryExpanseListItemState();
}

class _CategoryExpanseListItemState extends State<CategoryExpanseListItem> {
  var index;
  bool isSwitched = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
      //  padding: EdgeInsets.only(left:24.0,right: 24),
      width: SizeConfig.widthMultiplier * 100,
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[300],
          ),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Container(
        padding: EdgeInsets.only(left: 5),
        child: ExpansionTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(widget.category_name.toString()),
              InkWell(
                onTap: () {
                  widget.addSubcategory();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  margin: EdgeInsets.only(left: 20),
                  padding:
                      EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
                  child: Text(
                    'Add Subcategory',
                    style: AppTheme.textStyle.lightHeading.copyWith(
                        color: Colors.white, fontSize: AppFontSize.s16),
                  ),
                ),
              ),
            ],
          ),
          children: <Widget>[
            ListView.builder(
              itemBuilder: (context, index) {
                return ExpansionTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(widget._subCategoryList[index].name.toString()),
                      InkWell(
                        onTap: () {
                          AppRoutes.replace(context, DishEdit(widget.id,widget._subCategoryList[index].id,));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppTheme.primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          margin: EdgeInsets.only(left: 20),
                          padding: EdgeInsets.only(
                              left: 12, right: 12, top: 8, bottom: 8),
                          child: Text(
                            'Add dish',
                            style: AppTheme.textStyle.lightHeading.copyWith(
                                color: Colors.white, fontSize: AppFontSize.s16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  children: [
                    ListView.builder(itemBuilder: (context, ind) {
                      return Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(widget._subCategoryList[index].dish_list[ind].name),
                            Switch(
                              value: isSwitched,
                              onChanged: (value) {
                                setState(() {
                                  isSwitched = value;
                                  //  updateClock(value);
                                });
                              },
                              activeTrackColor: Colors.grey,
                              activeColor: Colors.blue,
                              inactiveThumbColor: Colors.blue,
                            ),
                          ],
                        ),
                      );
                    },physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget._subCategoryList[index].dish_list.length,
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1,
                    ),
                  ],
                );
              },
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget._subCategoryList.length,
            ),
          ],
        ),
      ),
    );
  }
}
