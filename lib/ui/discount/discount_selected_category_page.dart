import 'dart:io';

import 'package:etoUser/api/api.dart';
import 'package:etoUser/controller/home_controller.dart';
import 'package:etoUser/model/discount_list_model.dart';
import 'package:etoUser/ui/discount/document_select_page.dart';
import 'package:etoUser/ui/drawer_srceen/help_screen.dart';
import 'package:etoUser/ui/home_screen.dart';
import 'package:etoUser/ui/widget/custom_fade_in_image.dart';
import 'package:etoUser/ui/widget/cutom_appbar.dart';
import 'package:etoUser/util/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:etoUser/controller/user_controller.dart';
import 'package:etoUser/enum/error_type.dart';
import 'package:etoUser/ui/widget/no_internet_widget.dart';
import 'package:image_picker/image_picker.dart';


class DiscountSelectedCategoryPage extends StatefulWidget {
  const DiscountSelectedCategoryPage({Key? key}) : super(key: key);

  @override
  State<DiscountSelectedCategoryPage> createState() => _DiscountSelectedCategoryPageState();
}

class _DiscountSelectedCategoryPageState extends State<DiscountSelectedCategoryPage> {
  final UserController _userController = Get.find();
  final HomeController _homeController = Get.find();


  DiscountListModel argumentVal = Get.arguments[0];

  @override
  void initState() {
    print("objectssss==>${argumentVal.image}");
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        text: "Discount Category".tr,
      ),
      body: GetX<UserController>(builder: (cont) {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
        if (cont.error.value.errorType == ErrorType.internet) {
          return NoInternetWidget();
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),
              Container(
                  height: 120,width: 120,
                  child:  CustomFadeInImage(
                    url:
                    "${ApiUrl.baseImageUrl}storage/${argumentVal.image}",
                    fit: BoxFit.cover,
                    placeHolder:
                    AppImage.icUserPlaceholder,
                  )),
              SizedBox(height: 10,),

              _homeController.checkRequestResponseModel.value.userDetails["user_discnt_status"] == "not_assign"?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text("${argumentVal.description}",style: TextStyle(
                  color: Colors.black,fontSize: 22,fontWeight: FontWeight.w400,
                ),
                 textAlign: TextAlign.center,
                ),
              ):  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text("Apply to become a verified ${argumentVal.name} on Touk Touk",style: TextStyle(
                  color: Colors.black,fontSize: 22,fontWeight: FontWeight.w400,
                ),
                 textAlign: TextAlign.center,
                ),
              ),

              SizedBox(height: _homeController.checkRequestResponseModel.value.userDetails["user_discnt_status"] == "not_assign"? 40:0,),

              _homeController.checkRequestResponseModel.value.userDetails["user_discnt_status"] == "not_assign"?  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  children: [
                  Text("Steps to start enjoying discounts on all your trips:",style: TextStyle(
                        color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold,
                      ),
                        textAlign: TextAlign.center,),
                    SizedBox(height: 15,),
                    Text("Upload document for verification",style: TextStyle(
                        color: Colors.black,fontSize: 18,fontWeight: FontWeight.w400,
                      ), textAlign: TextAlign.center,),
                    Image.asset(AppImage.pendingDocument,fit: BoxFit.cover,width: 60),

                    SizedBox(height: 15,),
                    Text("Touk Touk team reviews and approves within 2 business days.",style: TextStyle(
                        color: Colors.black,fontSize: 18,fontWeight: FontWeight.w400,
                      ), textAlign: TextAlign.center,),
                    Image.asset(AppImage.approvedDocument,fit: BoxFit.cover,width: 60),

                    SizedBox(height: 15,),
                    Text("Once approved, You will automatically get discount on all trips.",
                      style: TextStyle(
                        color: Colors.black,fontSize: 18,fontWeight: FontWeight.w400,
                      ), textAlign: TextAlign.center,),
                    Image.asset(AppImage.notAssignDocument,fit: BoxFit.cover,width: 60),
                    SizedBox(height: 15,),

                  ],
                ),
              ) : SizedBox(),

              _homeController.checkRequestResponseModel.value.userDetails["user_discnt_status"] == "pending"?

              Column(children: [
                Image.asset(AppImage.pendingDocument,fit: BoxFit.cover,width: 90),
                SizedBox(height: 20,),
                Container(
                    height: 50,width: 250,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Color(0xffE8595B)
                    ),
                    child: Text(
                      "In Review",style: TextStyle(color: AppColors.white,fontSize: 16,fontWeight: FontWeight.w400),)
                ),

              ],) :

              _homeController.checkRequestResponseModel.value.userDetails["user_discnt_status"] == "accept"?

              Column(children: [
                SizedBox(height: 10,),
                Image.asset(AppImage.approvedDocument,fit: BoxFit.cover,width: 90),
                SizedBox(height: 20,),
                Container(
                    height: 50,width: 250,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Color(0xff29DE8B)
                    ),
                    child: Text(
                      "Approved",style: TextStyle(color: AppColors.white,fontSize: 16,fontWeight: FontWeight.w400),)
                ),

              ],) :
              _homeController.checkRequestResponseModel.value.userDetails["user_discnt_status"] == "reject"?

              Column(children: [
                SizedBox(height: 10,),
                Image.asset(AppImage.rejectedIcon,fit: BoxFit.cover,width: 90),
                SizedBox(height: 20,),
                Container(
                    height: 50,width: 250,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Color(0xffE8595B)
                    ),
                    child: Text(
                      "Rejected",style: TextStyle(color: AppColors.white,fontSize: 16,fontWeight: FontWeight.w400),)
                ),

              ],) :

               Row( mainAxisAlignment: MainAxisAlignment.center,
                 children: [

                  SizedBox(width: 10,),
                   Column(
                     children: [
                         InkWell(
                         onTap:  () async {

                             Get.to(DocumentSelectPage(),arguments: [argumentVal]);


                         },
                         child:
                         Container(
                             height: 50,width: 250,
                             alignment: Alignment.center,
                             decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),
                                 color: AppColors.primaryColor
                             ),
                             child: Text(

                               "Select Document",style: TextStyle(color: AppColors.white,fontSize: 16,fontWeight: FontWeight.w400),)

                         ),
                       ),
                       SizedBox(height: 5,),


                     ],
                   ),
                 ],
               ),


              SizedBox(height: _homeController.checkRequestResponseModel.value.userDetails["user_discnt_status"] == "not_assign"? 80:30,),


              _homeController.checkRequestResponseModel.value.userDetails["user_discnt_status"] == "pending"?
          Column(
            children: [
              Text(
              "Waiting for Review",
                style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(height: 30,),
              Container( width: MediaQuery.of(context).size.width*0.85,
                child: Text(
                "We will notify once you are approved Once approved, You will start enjoying ${argumentVal.name} discount on all your trips",
                  style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w400),maxLines: 5,textAlign: TextAlign.center),
              ),
            ],
          ):

          _homeController.checkRequestResponseModel.value.userDetails["user_discnt_status"] == "accept"?

          Column(
            children: [
              Text(
                "Congratulations!",
                style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              Container( width: MediaQuery.of(context).size.width*0.85,
                child: Text(
                    "You are now verified ${argumentVal.name}.",
                    style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w400),maxLines: 5,textAlign: TextAlign.center),
              ),
            ],
          ):

          _homeController.checkRequestResponseModel.value.userDetails["user_discnt_status"] == "reject"?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    Text(
                      "Your status is Rejected",
                      style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                    SizedBox(height: 5,),
                    Text(
                        "Documents that are poorly structured or lack clear and concise information may be rejected.",
                        style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w400),maxLines: 5,
                    textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20,),
                    InkWell(
                      onTap: () {
                        Get.to(HelpScreen());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text(
                          "Please connect support team",
                          style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),maxLines: 5,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(width: 15,),
                        Container(height: 40,width: 53,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: Colors.black),
                            alignment: Alignment.center,
                            child:  Icon(Icons.arrow_forward_outlined,color: Colors.white,)
                        )
                      ],),
                    )
                  ],
                ),
              ) : SizedBox(),

              SizedBox(height:  _homeController.checkRequestResponseModel.value.userDetails["user_discnt_status"] == "accept"?  60:0,),
              _homeController.checkRequestResponseModel.value.userDetails["user_discnt_status"] == "accept"?
              InkWell(
                onTap: () {
                  Get.offAll(HomeScreen());
                },
                child: Container(
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 50),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Colors.black
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Text(
                            "Book a Trip",style: TextStyle(color: AppColors.white,fontSize: 16,fontWeight: FontWeight.w400),),
                        ),
                      Container(height: 40,width: 53,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: AppColors.white),
                        alignment: Alignment.center,
                      child:  Icon(Icons.arrow_forward_outlined)
                      )
                      ],
                    )
                ),
              ):SizedBox(),
          ],
          ),
        );
      }),
    );
  }


}
