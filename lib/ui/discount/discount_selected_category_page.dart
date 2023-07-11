import 'package:etoUser/controller/home_controller.dart';
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
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
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

        return Column(
          children: [
            SizedBox(height: 20,),
            Container(
                height: 120,width: 120,
                child: Image.asset(AppImage.studentVector,fit: BoxFit.contain)),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text("Apply to become a verified student on Touk Touk",style: TextStyle(
                color: Colors.black,fontSize: 22,fontWeight: FontWeight.w400,
              ),
               textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 80,),
            InkWell(
              onTap: () async {
                return showDialog(
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
              child: Container(
                  height: 50,width: 250,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: AppColors.primaryColor
                  ),
                  child: Text("Upload Document",style: TextStyle(color: AppColors.white,fontSize: 16,fontWeight: FontWeight.w400),)),
            ),
          ],
        );
      }),
    );
  }

  Future<void> _imagePick() async {
    final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 10);
    if (image != null) {
      _userController.imageFilePah = image.path;
      setState(() {});
    }
  }

  Future<void> _photoPick() async {
    _userController.removeUnFocusManager();

    final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 10);
    if (image != null) {
      _userController.imageFilePah = image.path;
      setState(() {});
    }
  }

}
