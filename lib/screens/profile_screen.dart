import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_fam/api/API.dart';
import 'package:food_fam/theme/theme.dart';
import 'package:food_fam/utils/ShareManager.dart';
import 'package:food_fam/utils/app_assets.dart';
import 'package:food_fam/utils/app_routes.dart';
import 'package:food_fam/utils/display_alert_widget.dart';
import 'package:food_fam/utils/size_config.dart';
import 'package:image_picker/image_picker.dart';

import '../api/API.dart';

class foodfamProfile extends StatefulWidget {
  @override
  _foodfamState createState() => _foodfamState();
}


class _foodfamState extends State<foodfamProfile> {
  File profile;
  String Rname='';
  String id='';
  String ownermobile='';
  String logo='';
  String landmark='';
  String dis='';
  var diloagContext;

  var mobile = TextEditingController();
  var mail = TextEditingController();
  var address = TextEditingController();
  var discription = TextEditingController();
//  String Rname='';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ShareMananer.getUserDetails().then((data){
      id=data["token"].toString();
      print(Rname);
      getProfile(data["token"].toString());
    });


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.primaryColor,

        title: Text(
          "PROFILE",
        
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(2))),

              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap:() => pickProfileImage(),
                    child: Center(
                      child:ClipRRect(

                        borderRadius: BorderRadius.circular(100.0),
                        /*  decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(100.0),
      ),*/
                        child:  profile==null?FadeInImage.assetNetwork(
                          image: API.imageBaseUrl+logo,
                          width: 60.0,
                          height: 60.0,
                          placeholder: Assets.logo,fit: BoxFit.fill,):Image.file(profile, width: 60.0,
                          height: 60.0,fit: BoxFit.fill)
                      )
                    ),
                  ),
                  Text(
                    Rname.toString(),
                    style: AppTheme.textStyle.lightHeading.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: AppFontSize.s22),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier * 4,
            ),
            Container(
                 padding: EdgeInsets.only(left:10,right:10),
              width: SizeConfig.heightMultiplier * 90,
              height: SizeConfig.heightMultiplier * 7,
              //  width: SizeConfig.heightMultiplier*30,

              child: Container(

                decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(2))),
                padding: EdgeInsets.all(12),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Owner/Contact Person",
                      style: AppTheme.textStyle.lightHeading.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: AppFontSize.s18),
                    ),

                    GestureDetector(
                        onTap: (){


                        },
                        child: Icon(Icons.edit,color: Colors.white,))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier * 2,
            ),
            Container(
              width: SizeConfig.widthMultiplier*100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                       padding: EdgeInsets.only(left:4),
                    child: Icon(
                      Icons.phone,
                      size: 25,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    width: SizeConfig.widthMultiplier*80,
                    height: SizeConfig.heightMultiplier * 7,
                    child: TextField(
                      readOnly: true,
                      controller: mobile,
                      minLines: 10,
                      maxLines: 15,
                      autocorrect: false,
                      decoration: InputDecoration(
                        hintText: ownermobile,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier * 2,
            ),
            Container(
              width: SizeConfig.widthMultiplier*100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                       padding: EdgeInsets.only(left:4),
                    child: Icon(
                      Icons.email,
                      size: 25,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                     padding: EdgeInsets.only(right: 10),
                    width: SizeConfig.widthMultiplier*80,
                    height: SizeConfig.heightMultiplier * 7,
                    child: TextField(
                      readOnly: true,
                      controller: mail,
                      minLines: 10,
                      maxLines: 15,
                      autocorrect: false,
                      decoration: InputDecoration(
                        hintText: 'Restaurant@gmail.com',
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier * 2,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                       padding: EdgeInsets.only(left:4),
                    child: Icon(
                      Icons.location_on,
                      size: 25,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                     padding: EdgeInsets.only(right: 10),
                    width: SizeConfig.widthMultiplier*80,
                    height: SizeConfig.heightMultiplier * 13,
                    child: TextField(
                      readOnly: true,
                      controller: address,
                      minLines: 10,
                      maxLines: 15,
                      autocorrect: false,
                      decoration: InputDecoration(
                        hintText: landmark,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier * 2,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                       padding: EdgeInsets.only(left:4),
                    child: Icon(
                      Icons.announcement,
                      size: 25,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                     padding: EdgeInsets.only(right: 10),
                    width: SizeConfig.widthMultiplier*80,
                    height: SizeConfig.heightMultiplier * 20,
                    child: TextField(
                      controller: discription,
                      minLines: 10,
                      maxLines: 15,
                      autocorrect: false,
                      decoration: InputDecoration(
                        hintText: 'Description',
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier * 2,
            ),

          ],
        ),
      ),
      bottomNavigationBar: InkWell(
        child: Container(
          height: SizeConfig.heightMultiplier * 7,
          color: AppTheme.primaryColor,
          child: Center(
              child: Text('Update Profile',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18))),
        ),
        onTap: () {
          _updateProfile(
            mobile.text,
            mail.text,
            address.text,
            discription.text
          );
        },
      ),
    );
  }

  getProfile(String restaurantid) async {
   // loadProgress();
    /*   Response response;
    Dio dio = new Dio();
    response = await  dio.post(API.LoginAPi, data: {"restaurantid": "FOODFAM0006", "password": "1"});
    print(response.data.toString());

    print(response.data.toString());
*/



    Map<String, String> args = new Map();
    args["restaurantid"]=restaurantid;

    API.post(API.ProfileAPi,args,"").then((response){

      print(response.statusCode.toString());
      print(response.body.toString());

      if(response.statusCode==200)
      {
        final data = json.decode(response.body);

        print(data['success']);

        if(data['success']==1){

          String id = data['id'].toString();
          String restaurantid = data['restaurantid'].toString();
          Rname = data['Rname'].toString();
          String ownername = data['ownername'].toString();
          mobile.text = data['ownermobile'].toString();
          logo = data['logo'].toString();
          address.text = data['landmark'].toString();
          discription.text = data['aboutus'].toString();
          mail.text = data['Email']??"NA";
          print("Restorent name"+Rname.toString());

       setState(() {

       });
        }else{
          showDisplayAllert(context: context,isSucces: false,message: data['message']);
        }

      }
      else{
        showDisplayAllert(context: context,isSucces: false,message: "Server error");
      }

    });
  }

  _dialog(){
    showDialog(
        context: this.context,
        barrierDismissible: true,
        builder: (context) {
          return Dialog(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: <Widget>[
                  Container(
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          AppTheme.primaryColor),
                    ),
                  ),
                  SizedBox(width: SizeConfig.widthMultiplier*2,),
                  Text('Please Wait...', style: TextStyle()),
                ],
              ),
            ),
          );
        });
  }

  report() {

  }

  pickProfileImage()async{
    final ImagePicker _picker = ImagePicker();
    final pickedFile = await _picker.getImage(source: ImageSource.gallery,imageQuality: 50);

    if(pickedFile!=null)
    {
      profile = File(pickedFile.path);
      setState(() {

      });
      uploadProfile();
    }


  }

  uploadProfile()async{
    _dialog();
    Dio dio = new Dio();
    FormData formData= FormData.fromMap({
      "logo": await MultipartFile.fromFile(profile.path, filename:profile.path.split('/').last),
      "retaurantid": id,
    });

    final response  = await dio.post(
        API.editProfile,
        data: formData,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "multipart/form-data",
        }));

    Navigator.of(context).pop(diloagContext);
    final data = json.decode(response.data);

    print("aaaa"+data.toString());
    if(response.statusCode==200)
    {
      showDisplayAllert(message:data["message"].toString(),isSucces: true,context: context);
    }else {
      showDisplayAllert(message:"Server Error".toString(),isSucces: false,context: context);
    }
  }

  void _updateProfile(
      String mobile,
      String mail,
      String address,
      String discription) {

    _dialog();

    Map<String, String> args = new Map();
    args["retaurantid"]=id.toString();
    args["ownermobile"]=mobile.toString();
    args["email"]=mail.toString();
    args["landmark"]=address.toString();
    args["aboutus"]=discription.toString();

    API.post(API.editprofile, args, "").then((response) {

      print(response.statusCode.toString());
      print(response.body.toString());

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['success'] == 1) {

          Navigator.of(context).pop(diloagContext);
          Future.delayed(Duration(seconds: 1), () {
            showDisplayAllert(
                context: context, isSucces: true, message: data['message']);
            // AppRoutes.makeFirst(context, SearchScreen());
          });
        } else {
          Navigator.of(context).pop(diloagContext);
          showDisplayAllert(
              context: context, isSucces: false, message: data['message']);

        }
      } else {
        Navigator.of(context).pop(diloagContext);
        showDisplayAllert(
            context: context, isSucces: false, message: "Server error");

      }
    });
  }
}
