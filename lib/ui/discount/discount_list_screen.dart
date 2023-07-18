import 'package:etoUser/controller/home_controller.dart';
import 'package:etoUser/ui/discount/discount_selected_category_page.dart';
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

import '../../api/api.dart';
import '../widget/custom_fade_in_image.dart';


class DiscountListPage extends StatefulWidget {
  const DiscountListPage({Key? key}) : super(key: key);

  @override
  State<DiscountListPage> createState() => _DiscountListPageState();
}

class _DiscountListPageState extends State<DiscountListPage> {
  final UserController _userController = Get.find();
  final HomeController homeController = Get.find();
  // String discountId = "";


  @override
  initState() {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //   await homeCont.getDiscountList();
    // });

    super.initState();
    // discountId = homeCont.checkRequestResponseModel.value.userCategoryDiscount_id.toString();
    // print("djfghdjfg==>${discountId}");
    // print("djfghdjfg==>${homeCont.checkRequestResponseModel.value.userDetails["user_discnt_status"]}");
  }


  @override
  Widget build(BuildContext context) {
    // homeController.checkRequestResponseModel.listen((p0) {
    //   homeController.discountStatus.value = p0.userCategoryDiscount_id!;
    //   print("cheklistuner===>${p0.userCategoryDiscount_id}");
    //
    // });

    return Scaffold(
      // appBar: CustomAppBar(text: "Profile Page"),
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        text: "Discount".tr,
      ),
      body: GetX<UserController>(builder: (cont) {


        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
        if (cont.error.value.errorType == ErrorType.internet) {
          return NoInternetWidget();
        }

        return  GetX<HomeController>(
          builder: (homeCont) {
            bool isCountZero = homeCont.checkRequestResponseModel.value.userCategoryDiscount_id == "0";
            bool isApproved = homeCont.checkRequestResponseModel.value.userDetails['user_discnt_status'] == "accept";
            bool isPending = homeCont.checkRequestResponseModel.value.userDetails['user_discnt_status'] == "pending";
            bool isRejected = homeCont.checkRequestResponseModel.value.userDetails['user_discnt_status'] == "reject";
            bool isNotAssign = homeCont.checkRequestResponseModel.value.userDetails['user_discnt_status'] == "not_assign";
            print("jsjsjjd===>${homeCont.checkRequestResponseModel.value.userCategoryDiscount_id}");
            return Stack(
              children: [
                Center(child: Image.asset(AppImage.toukToukBlurLogo,height: 220,width: 220,)),
                homeCont.discountList.isEmpty ? Center(child: Text("No Discount Available"))
                    :
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: homeCont.discountList.length,
                  itemBuilder: (context, index) {
                   int selectedIndex = int.parse(homeCont.checkRequestResponseModel.value.userCategoryDiscount_id!);
                  return InkWell(
                    onTap: "0"  == homeCont.checkRequestResponseModel.value.userCategoryDiscount_id ||
                        homeCont.checkRequestResponseModel.value.userCategoryDiscount_id == homeCont.discountList[index].id.toString() ?
                        () {
                      Get.to(DiscountSelectedCategoryPage(),arguments: [homeCont.discountList[index]]);
                    } : (){
                      print("dddddd===>%${homeCont.checkRequestResponseModel.value.userCategoryDiscount_id}");
                    },
                    child:
                    isCountZero
                      ?
                    Container(
                        height: 150,
                        margin: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            AppBoxShadow.defaultShadow(),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                                height: 120,width: 120,
                                child:
                                CustomFadeInImage(
                                  url:
                                  "${ApiUrl.baseImageUrl}storage/${homeCont.discountList[index].image}",
                                  fit: BoxFit.cover,
                                  placeHolder:
                                  AppImage.icUserPlaceholder,
                                )
                            ),
                            SizedBox(width: 8,),
                            Container(
                              width: MediaQuery.of(context).size.width*0.57,
                              child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(homeCont.discountList[index].name,style: TextStyle(
                                        color: Colors.black,fontSize: 20,fontWeight: FontWeight.w400,
                                      ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      Image.asset(AppImage.arrowCircle,height: 30,width: 30,)
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Text(homeCont.discountList[index].description,style: TextStyle(
                                    color: Colors.black,fontSize: 16,fontWeight: FontWeight.w400,
                                  ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 4,
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                    ):
                    index == selectedIndex-1 && (isPending || isApproved) ?
                    Container(
                        height: 150,
                        margin: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color(0xFFCEEDD8).withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            AppBoxShadow.defaultShadow(),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                                height: 120,width: 120,
                                child:
                                CustomFadeInImage(
                                  url:
                                  "${ApiUrl.baseImageUrl}storage/${homeCont.discountList[index].image}",
                                  fit: BoxFit.cover,
                                  placeHolder:
                                  AppImage.icUserPlaceholder,
                                )
                            ),
                            SizedBox(width: 8,),
                            Container(
                              width: MediaQuery.of(context).size.width*0.57,
                              child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(homeCont.discountList[index].name,style: TextStyle(
                                        color: Colors.black,fontSize: 20,fontWeight: FontWeight.w400,
                                      ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      Image.asset(AppImage.arrowCircle,height: 30,width: 30,)
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Text(homeCont.discountList[index].description,style: TextStyle(
                                    color: Colors.black,fontSize: 16,fontWeight: FontWeight.w400,
                                  ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 4,
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                    ):
                    index == selectedIndex-1 && (isRejected) ?
                    Container(
                        height: 150,
                        margin: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color(0xFFFADEDE).withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            AppBoxShadow.defaultShadow(),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                                height: 120,width: 120,
                                child:
                                CustomFadeInImage(
                                  url:
                                  "${ApiUrl.baseImageUrl}storage/${homeCont.discountList[index].image}",
                                  fit: BoxFit.cover,
                                  placeHolder:
                                  AppImage.icUserPlaceholder,
                                )
                            ),
                            SizedBox(width: 8,),
                            Container(
                              width: MediaQuery.of(context).size.width*0.57,
                              child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(homeCont.discountList[index].name,style: TextStyle(
                                        color: Colors.black,fontSize: 20,fontWeight: FontWeight.w400,
                                      ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      Image.asset(AppImage.arrowCircle,height: 30,width: 30,)
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Text(homeCont.discountList[index].description,style: TextStyle(
                                    color: Colors.black,fontSize: 16,fontWeight: FontWeight.w400,
                                  ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 4,
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                    ):

                   Stack(
                     children: [
                       Container(
                           height: 150,
                           margin: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
                           padding: EdgeInsets.all(10),
                           decoration: BoxDecoration(
                             color: Colors.white,
                             borderRadius: BorderRadius.circular(20),
                             boxShadow: [
                               AppBoxShadow.defaultShadow(),
                             ],
                           ),
                           child: Row(
                             children: [
                               Container(
                                   height: 120,width: 120,
                                   child:
                                   CustomFadeInImage(
                                     url:
                                     "${ApiUrl.baseImageUrl}storage/${homeCont.discountList[index].image}",
                                     fit: BoxFit.cover,
                                     placeHolder:
                                     AppImage.icUserPlaceholder,
                                   )
                               ),
                               SizedBox(width: 8,),
                               Container(
                                 width: MediaQuery.of(context).size.width*0.57,
                                 child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         Text(homeCont.discountList[index].name,style: TextStyle(
                                           color: Colors.black,fontSize: 20,fontWeight: FontWeight.w400,
                                         ),
                                           overflow: TextOverflow.ellipsis,
                                           maxLines: 1,
                                         ),
                                         Image.asset(AppImage.arrowCircle,height: 30,width: 30,)
                                       ],
                                     ),
                                     SizedBox(height: 8),
                                     Text(homeCont.discountList[index].description,style: TextStyle(
                                       color: Colors.black,fontSize: 16,fontWeight: FontWeight.w400,
                                     ),
                                       overflow: TextOverflow.ellipsis,
                                       maxLines: 4,
                                     ),
                                   ],
                                 ),
                               )
                             ],
                           )
                       ),
                       Container(height: 150,
                         margin: EdgeInsets.symmetric(horizontal: 12,vertical: 10),

                         decoration: BoxDecoration(
                           color:  Color(0xFFCCCCCC).withOpacity(.5),
                           borderRadius: BorderRadius.circular(20),
                           boxShadow: [
                             AppBoxShadow.defaultShadow(),
                           ],
                         ),
                       )
                     ],
                   ),
                  );
                },),
              ],
            );
          }
        );
          
          
          Column(
          children: [
            InkWell(
              onTap: () {
                Get.to(DiscountSelectedCategoryPage());
              },
              child: Container(
                height: 150,
                margin: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    AppBoxShadow.defaultShadow(),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                    height: 120,width: 120,
                        child: Image.asset(AppImage.studentVector,fit: BoxFit.contain)),
                    Container(
                      width: MediaQuery.of(context).size.width*0.57,
                      child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Student",style: TextStyle(
                                color: Colors.black,fontSize: 20,fontWeight: FontWeight.w400,
                              ),
                              overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              Image.asset(AppImage.arrowCircle,height: 30,width: 30,)
                            ],
                          ),
                          SizedBox(height: 8),
                          Text("Are you a student? Get approved on Touk Touk to enjoy additional discounts",style: TextStyle(
                            color: Colors.black,fontSize: 16,fontWeight: FontWeight.w400,
                          ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 4,
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ),
            ),
          ],
        );
      }),
    );
  }


}
