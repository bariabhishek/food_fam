import 'package:flutter/material.dart';
import 'package:food_fam/theme/theme.dart';
import 'package:food_fam/utils/app_routes.dart';
import 'package:food_fam/utils/size_config.dart';

import 'add_dish.dart';
import 'category_view_page.dart';
import 'dish_view_page.dart';
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
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Container(
        padding: EdgeInsets.only(left: 5),
        child: ExpansionTile(
          tilePadding: EdgeInsets.symmetric(horizontal: 8),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () {
                  AppRoutes.goto(
                      context,
                      CategoryViewScreen(widget.category_name, widget.id,));
                },
                child: Container(
                  width: SizeConfig.heightMultiplier * 26,
                  child: Text(widget.category_name.toString(),
                      textAlign: TextAlign.left,
                      style: AppTheme.textStyle.lightHeading.copyWith(
                          color: Colors.black, fontSize: AppFontSize.s18)),
                ),
              ),
              FlatButton(
                padding: EdgeInsets.symmetric(vertical: 1, horizontal: 6),
                minWidth: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                color: AppTheme.primaryColor,
                onPressed: () {
                  widget.addSubcategory();
                },
                child: Tooltip(
                  message: "Add SubCategory",
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              FlatButton(
                padding: EdgeInsets.symmetric(vertical: 1, horizontal: 6),
                minWidth: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                color: AppTheme.accentColor,
                onPressed: () {
                  AppRoutes.goto(
                      context,
                      CategoryViewScreen(widget.category_name, widget.id,));
                },
                child: Tooltip(
                  message: "View category",
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 20,
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
                          AppRoutes.replace(
                              context,
                              AddDish(
                                widget.id,
                                widget._subCategoryList[index].id,
                              ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppTheme.primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          padding: EdgeInsets.all(6),
                          child: Center(
                            child: Text(
                              'Add Dish',
                              style: AppTheme.textStyle.lightHeading.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: AppFontSize.s14),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  children: [
                    ListView.builder(
                      itemBuilder: (context, ind) {
                        return Container(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(widget
                                  ._subCategoryList[index].dish_list[ind].name),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 10,
                              )
                            ],
                          ),
                        );
                      },
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount:
                          widget._subCategoryList[index].dish_list.length,
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
