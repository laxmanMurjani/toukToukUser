import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:etoUser/api/api.dart';
import 'package:etoUser/controller/home_controller.dart';
import 'package:etoUser/main.dart';
import 'package:etoUser/preference/preference.dart';
import 'package:etoUser/ui/dialog/update_app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:etoUser/controller/user_controller.dart';
import 'package:etoUser/ui/authentication_screen/login_screen.dart';
import 'package:etoUser/ui/authentication_screen/sign_in_up_screen.dart';
import 'package:etoUser/ui/authentication_screen/sign_up_screen.dart';
import 'package:etoUser/ui/home_screen.dart';
import 'package:etoUser/util/app_constant.dart';
import 'package:etoUser/util/common.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with WidgetsBindingObserver{
  final UserController _userController = Get.find();
  final HomeController _homeController = Get.find();
  GoogleMapController? _controller;

  _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            alignment: Alignment.center,
            title: Text(
              "Touk touk user would like to collect location data to enable your current location to provide you the service for taxi booking and navigation even when the app is closed or not in use.",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
            ),
            actions: [
              TextButton(
                  onPressed: () async {
                    Database.setSeenLocationAlertDialog();
                    Get.back();
                    _userController.setLanguage();
                    checkPermissionStatus();
                    _homeController.isStatusCheck.value = true;


                    if(!AppString.testing_version_code_check_dialog!){
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      if(Platform.isAndroid){
                        if(int.parse(AppString.detectUserAndroidBuildNumber!) < int.parse(AppString.firebaseUserAndroidBuildNumber!) ||
                            int.parse(AppString.detectUserAndroidVersionCode!) < int.parse(AppString.firebaseUserAndroidVersionCode!)){
                          _userController.isUpdateApp.value = true;
                        } else{
                          _userController.isUpdateApp.value = false;
                          Timer(const Duration(seconds: 3), () {
                            // _homeController.getUserLatLong();
                            if (_userController.userToken.value.accessToken != null) {
                              if(prefs.containsKey("base_url")){
                                setState(() {
                                  ApiUrl.baseUrl = prefs.getString("base_url");
                                });
                              }
                              _homeController.getUserLatLong();
                              // _userController.currentUserApi();
                              // Get.off(()=> HomeScreen());
                              _userController.getUserProfileData();

                            } else {
                              Get.off(() => LoginScreen());
                            }
                          });
                        }}
                      else{
                        if(int.parse(AppString.detectUserIosBuildNumber!) < int.parse(AppString.firebaseUserIosBuildNumber!) &&
                            int.parse(AppString.detectUserIosVersionCode!) <= int.parse(AppString.detectUserIosVersionCode!)){
                          _userController.isUpdateApp.value = true;
                        } else{
                          _userController.isUpdateApp.value = false;
                          Timer(const Duration(seconds: 3), () {
                            // _homeController.getUserLatLong();
                            if (_userController.userToken.value.accessToken != null) {
                              if(prefs.containsKey("base_url")){
                                setState(() {
                                  ApiUrl.baseUrl = prefs.getString("base_url");
                                });
                              }
                              _homeController.getUserLatLong();
                              // _userController.currentUserApi();
                              // Get.off(()=> HomeScreen());
                              _userController.getUserProfileData();

                            } else {
                              Get.off(() => LoginScreen());
                            }
                          });
                        }
                      }
                    }
                  },
                  child: Text(
                    "Ok",
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ))
            ],
          );
        });
  }


  checkPermissionStatus()async{
    var status = await Geolocator.checkPermission();
    if (status == LocationPermission.denied) {
      Geolocator.requestPermission();
      // We didn't ask for permission yet or he permission has been denied before but not permanently.
      print("Permission is denined.");
    }else if(status == LocationPermission.always){
      //permission is already granted.
      location.enableBackgroundMode(enable: true);
      print("Permission is already granted.");
    }else if(status  == LocationPermission.deniedForever){
      //permission is permanently denied.
      openAppSettings();
      print("Permission is permanently denied");
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    // determinePosition();
    // contactPermissions();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final prefs = await SharedPreferences.getInstance();
      // prefs.containsKey("base_url");
      print(
          "prefs.containsKey(Database.seenOnBoarding)===>${prefs.containsKey(Database.seenOnBoarding)}");
      if (!prefs.containsKey(Database.seenOnBoarding)) {
        _showDialog();
      }

      if (prefs.containsKey(Database.seenOnBoarding)) {
        checkPermissionStatus();
        _userController.setLanguage();

        _homeController.isStatusCheck.value = true;


        if(!AppString.testing_version_code_check_dialog!){
          if(Platform.isAndroid){
            if(int.parse(AppString.detectUserAndroidBuildNumber!) < int.parse(AppString.firebaseUserAndroidBuildNumber!) ||
                int.parse(AppString.detectUserAndroidVersionCode!) < int.parse(AppString.firebaseUserAndroidVersionCode!)){
              _userController.isUpdateApp.value = true;
            } else{
              _userController.isUpdateApp.value = false;
              Timer(const Duration(seconds: 3), () {
                // _homeController.getUserLatLong();
                if (_userController.userToken.value.accessToken != null) {
                  if(prefs.containsKey("base_url")){
                    setState(() {
                      ApiUrl.baseUrl = prefs.getString("base_url");
                    });
                  }
                  _homeController.getUserLatLong();
                  // _userController.currentUserApi();
                  // Get.off(()=> HomeScreen());
                  _userController.getUserProfileData();

                } else {
                  Get.off(() => LoginScreen());
                }
              });
            }}
          else{
            if(int.parse(AppString.detectUserIosBuildNumber!) < int.parse(AppString.firebaseUserIosBuildNumber!) &&
                int.parse(AppString.detectUserIosVersionCode!) <= int.parse(AppString.detectUserIosVersionCode!)){
              _userController.isUpdateApp.value = true;
            } else{
              _userController.isUpdateApp.value = false;
              Timer(const Duration(seconds: 3), () {
                // _homeController.getUserLatLong();
                if (_userController.userToken.value.accessToken != null) {
                  if(prefs.containsKey("base_url")){
                    setState(() {
                      ApiUrl.baseUrl = prefs.getString("base_url");
                    });
                  }
                  _homeController.getUserLatLong();
                  // _userController.currentUserApi();
                  // Get.off(()=> HomeScreen());
                  _userController.getUserProfileData();

                } else {
                  Get.off(() => LoginScreen());
                }
              });
            }
          }
        }
      }
      _userController.isUserUpdated.value = prefs.containsKey('isUserUpdated');
    });

    super.initState();}

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   // TODO: implement didChangeAppLifecycleState
  //   super.didChangeAppLifecycleState(state);
  //
  //
  //   print("test===>${state }");
  //   if(state == AppLifecycleState.resumed || state == AppLifecycleState.paused
  //       || state == AppLifecycleState.inactive || state == AppLifecycleState.detached
  //   ){
  //     print("test===>${state == AppLifecycleState.resumed}");
  //     determinePosition();
  //   }
  // }

  Future<Position?> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.showSnackbar(GetSnackBar(
          messageText: Text(
            "location_permissions_denied",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          mainButton: InkWell(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "allow",
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ));
      }
    }

    if (permission == LocationPermission.deniedForever) {
      await openAppSettings();
    }
    Position? position;
    try {
      position = await Geolocator.getCurrentPosition();
    } catch (e) {
      Get.showSnackbar(GetBar(
        messageText: Text(
          e.toString(),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        mainButton: InkWell(
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "allow",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ));
      // showError(msg: e.toString());
    }
    if (position != null) {
      showMarker(latLng: LatLng(position.latitude, position.longitude));
      print("cccc===>${position.latitude}");
    }
    return position;
  }

  Future<void> showMarker({required LatLng latLng}) async {
    CameraPosition cameraPosition = CameraPosition(
      target: LatLng(latLng.latitude, latLng.longitude),
      zoom: 14.4746,
    );
    //
    // _markers.add(Marker(markerId: const MarkerId("first"), position: latLng));
    _controller?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    // PolylinePoints polylinePoints = PolylinePoints();
    // PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
    //     AppString.googleMapKey,
    //     const PointLatLng(21.1702, 72.8311),
    //     const PointLatLng(21.1418, 72.7709),
    //     travelMode: TravelMode.driving);
    //
    // List<LatLng> points = <LatLng>[];
    // for (var element in result.points) {
    //   points.add(LatLng(element.latitude, element.longitude));
    // }
    //
    // List<PatternItem> pattern = [PatternItem.dash(20), PatternItem.gap(5)];
    // Polyline polyline = Polyline(
    //     startCap: Cap.buttCap,
    //     polylineId: id,
    //     color: Colors.red,
    //     points: points,
    //     width: 3,
    //     patterns: pattern,
    //     endCap: Cap.squareCap);
    // _polyLine.add(polyline);
  }

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      //AppColors.primaryColor,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.asset(AppImage.newSplash),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                AppImage.logoMain,
                height: 195,
                width: 195,
                fit: BoxFit.cover,
              ),
            ),
          ),
          _userController.isUpdateApp.value ? CustomAlertDialog(
            title: "Update App",
              message: "We are regularly upgrading your experience. New version of this app is available on ${Platform.isAndroid ? "Play Store" : "App Store"}, Please update app.",
            onPostivePressed: () async{
              await _userController.sendUpdateApp();
            },
            onNegativePressed: (){
              _userController.isUpdateApp.value = false;

              setState(() {

              });

                if (_userController.userToken.value.accessToken != null) {
                  _homeController.getUserLatLong();
                  _userController.getUserProfileData();
                } else {
                  Get.off(() => LoginScreen());
                }

              // Navigator.pop(context);
            },
            positiveBtnText: 'Update',
            negativeBtnText: 'Cancel',
            negativeButtonShow: !AppString.isForceCancleButtonShow!,
            positiveButtonShow: true,) : SizedBox(),
      AppString.testing_version_code_check_dialog! ? CustomAlertDialog(
        title: "Check version History",
        message: "detectUser${Platform.isAndroid ? "Android" : "Ios"}BuildNumber ==>${Platform.isAndroid?AppString.detectUserAndroidBuildNumber:AppString.detectUserIosBuildNumber}\ndetectUser${Platform.isAndroid ? "Android" : "Ios"}VersionCode ===> ${Platform.isAndroid ? AppString.detectUserAndroidVersionCode : AppString.detectUserIosVersionCode} \n\n"
            "firebaseUser${Platform.isAndroid ? "Android": "Ios"}BuildNumber ===>${Platform.isAndroid?AppString.firebaseUserAndroidBuildNumber:AppString.firebaseUserIosBuildNumber}\ndetectUser${Platform.isAndroid ? "Android" : "Ios"}VersionCode ===> ${Platform.isAndroid ? AppString.firebaseUserAndroidVersionCode : AppString.firebaseUserIosVersionCode}",
      ) : SizedBox()

          // Column(mainAxisAlignment: MainAxisAlignment.end,children: [
          //   Text('By',style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700,color: Colors.white,),),
          //   Image.asset(AppImage.mozilitNameLogo,width: MediaQuery.of(context).size.width*0.7,),
          //   SizedBox(height: 25,)
          // ],)
        ],
      ),
    );
  }
}
