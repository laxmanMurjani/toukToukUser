import 'dart:io';

import 'package:etoUser/controller/home_controller.dart';
import 'package:etoUser/controller/user_controller.dart';
import 'package:etoUser/model/discount_list_model.dart';
import 'package:etoUser/ui/widget/cutom_appbar.dart';
import 'package:etoUser/util/app_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:image_picker/image_picker.dart';

class DocumentSelectPage extends StatefulWidget {
  const DocumentSelectPage({Key? key}) : super(key: key);

  @override
  State<DocumentSelectPage> createState() => _DocumentSelectPageState();
}

class _DocumentSelectPageState extends State<DocumentSelectPage> {

  final UserController _userController = Get.find();
  final HomeController _homeController = Get.find();
  DiscountListModel argumentVal = Get.arguments[0];
  final ImagePicker _imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: "Document Selected Screen".tr,
      ),
      body: Column(
        children: [
          SizedBox(height: 20,),
          Container(height: 300,margin: EdgeInsets.symmetric(horizontal: 20),
            child:  _homeController.discountImageFilePah == null ?
            Image.asset(AppImage.logoMain):
            Image.file(File(_homeController.discountImageFilePah!),fit: BoxFit.contain,)
          ),
          SizedBox(height: 20,),
          InkWell(
            onTap:  () async {

              showDialog(
              context: context,
              builder: (BuildContext context) {
              return AlertDialog(
              title: Text(
              "Choose option",
              style: TextStyle(color: Colors.blue),
              ),
              content: SingleChildScrollView(
              child: ListBody(
              children: [
              Divider(
              height: 1,
              color: Colors.blue,
              ),
              ListTile(
              onTap: () {
              Get.back();
              _imagePick();
              },
              title: Text("Gallery"),
              leading: Icon(
              Icons.account_box,
              color: Colors.blue,
              ),
              ),
              Divider(
              height: 1,
              color: Colors.blue,
              ),
              ListTile(
              onTap: () {
              Get.back();
              _photoPick();
              },
              title: Text("Camera"),
              leading: Icon(
              Icons.camera,
              color: Colors.blue,
              ),
              ),
              ],
              ),
              ),
              );
              });

            },
            child:
            Container(
                height: 50,width: 250,
                alignment: Alignment.center,
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: AppColors.primaryColor
                ),
                child: Text(

                  "Pick Image",style: TextStyle(color: AppColors.white,fontSize: 16,fontWeight: FontWeight.w400),)

            ),
          ),
          SizedBox(height: 10,),
          InkWell(
            onTap: () {
              if(_homeController.discountImageFilePah != null){
                _homeController.uploadDiscountImage(argumentVal.id.toString());
              }

            },
            child: Container(
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 50),
                alignment: Alignment.center,
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Color(0xFF0BA33B)
                ),
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Text(
                        "Upload Document",style: TextStyle(color: AppColors.white,fontSize: 16,fontWeight: FontWeight.w400),),
                    ),
                    Container(height: 40,width: 53,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: AppColors.white),
                        alignment: Alignment.center,
                        child:  Icon(Icons.arrow_forward_outlined)
                    )
                  ],
                )
            ),
          ),

        ],
      ),
    );
  }
  Future<void> _imagePick() async {
    final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 10);
    if (image != null) {
      _homeController.discountImageFilePah = image.path;
      setState(() {});
    }
  }

  Future<void> _photoPick() async {
    _userController.removeUnFocusManager();

    final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 10);
    if (image != null) {
      _homeController.discountImageFilePah = image.path;
      setState(() {});
    }
  }
}


