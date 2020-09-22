import 'package:flutter/material.dart';
import 'package:food_fam/screens/daily.dart';
import 'package:food_fam/screens/yearly.dart';
import 'package:food_fam/theme/theme.dart';
import 'package:food_fam/utils/size_config.dart';

import 'monthlyscreen.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen>with SingleTickerProviderStateMixin{
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report'),
        backgroundColor: AppTheme.primaryColor,
      ),
      body: Container(
      child:  Column(children: [
        Container(
          height: SizeConfig.heightMultiplier*7,
          child: TabBar(
            unselectedLabelColor: Colors.red,
            labelPadding: EdgeInsets.all(3.0),
            labelColor: Colors.white,
            tabs: [
              Container(
                padding: EdgeInsets.only(left: 8,top: 8,bottom: 8),

                child: Center(
                  child: Text(
                    'Daily',
                    style: AppTheme.textStyle.heading1.copyWith(
                        color: Colors.grey,
                        fontSize: AppFontSize.s18,
                        fontWeight: FontWeight.normal),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 8,top: 8,bottom: 8),
                child: Center(
                  child: Text(
                    'Monthly',
                    style: AppTheme.textStyle.heading1.copyWith(
                        color: Colors.grey,
                        fontSize: AppFontSize.s18,
                        fontWeight: FontWeight.normal),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 8,top: 8,bottom: 8),
                child: Center(
                  child: Text(
                    'Yearly',
                    style: AppTheme.textStyle.heading1.copyWith(
                        color: Colors.grey,
                        fontSize: AppFontSize.s18,
                        fontWeight: FontWeight.normal),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
            controller: _tabController,
            indicatorColor: Colors.grey,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
        ),
        Container(
          height: SizeConfig.heightMultiplier*70,
          child: TabBarView(
            children: [
              Container(
                child: DailyScreen() ,

              ),
              Container(
                   child: MonthlyScreen(),
              ),
              Container(

                   child: YearlyScreen(),
              ),
            ],
            controller: _tabController,
          ),
        ),
      ],)
      ),
    );
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
