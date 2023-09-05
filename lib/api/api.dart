import 'dart:io';

import 'package:etoUser/util/app_constant.dart';

class ApiUrl {
  // static  String? baseUrl;
  static  String?  baseUrlLebanon;
  static  String?  baseUrlNigeria;
  static  String?  baseUrl;
  // static  String  naigeriaBaseUrl = "https://demo.mozilit.com/superAdminLogin/touk_touktaxi/public";
      // 'http://104.131.10.45/superAdminLogin/touk_touktaxi/public';
      // 'https://demo.mozilit.com/superAdminLogin/touk_touktaxi/public';

  // static String baseImageUrl = baseUrl! + "/";
  // static String BASE_URL = baseUrl!;
  static String termsCondition = "/terms";
  static String privacyPolicy = "/terms";

  // static  String baseUrl = '${baseUrl}/api/user';

  static const String clientId = '10';
      //"2";
  //"8";
  static const String clientSecret = 'fXOAp7eIRbVaTPqix3SLaP49TH6j7o0ZWhy0NTJP';
      //'aemt5ueZUibxOBkg8V8INBG4zO3MoUF57Nj6emUn';
      //"Jh7SzC3gpIyByyHgJ3liNp24RAfWjzNx2L4EdbKb";

  // static const String clientId = "5";
  // static const String clientSecret = "Fg7SAg4540H9dQ0WagKh49Lg9QL1q2JLPowN4bfe";

  static String deviceType = Platform.isAndroid ? "android" : "ios";

  static String signUp = "/signup";
  static String login = "/oauth/token";
  static String googleLogin = "/auth/google";
  static String facebookLogin = "/auth/facebook";
  static String appleLogin = "/auth/apple";
  static String userDetails = "/details";
  static String userLatLong = "/user-details";
  static String services = "/services";
  static String fare = "/estimated/fare";
  static String request = "/send/request";
  static String paymentMode = "/change-payment-mod";
  static String updateLocation = "/update/location";
  static String onlineStatus = "/online/status";
  static String requestCheck = "/request/check";
  static String requestCancel = "/cancel/request";
  static String promoCodesList = "/promocodes_list";
  static String providerRate = "/rate/provider";
  static String etoRate = "/rate/eto";
  static String trips = "/trips";
  static String tripDetails = "/trip/details";
  static String upcomingTrips = "/upcoming/trips";
  static String upcomingTripDetails = "/upcoming/trip/details";
  static String notifications = "/notifications/user";
  static String passBook = "/wallet/passbook";
  static String reasons = "/reasons";
  static String updateProfile = "/update/profile";
  static String uploadDiscountImage = "/discount/doc";
  static String sendOTPProfile = "/sendotp_profile";
  static String verifyOTPProfile = "/otp_verified_for_profile_update";
  static String changePassword = "/change/password";
  static String help = "/help";
  static String location = "/location";
  static String logout = "/logout";
  static String chat = "/chat";
  static String disputeList = "/dispute-list";
  static String dispute = "/dispute";
  static String dropItem = "/drop-item";
  static String sendOtp = "/sendotp";
  static String sendOtpWithAuth = "/signup/otp";
  static String verifyOtpWithAuth = "/verify/otp";
  static String verifyOTP = "/otp_verified";
  static String forgotPassword = "/forgot/password";
  static String resetPassword = "/reset/password";
  static String cardList = "/cardList";
  static String createCard = "/createCard";
  static String walletAdd = "/walletAdd";
  static String updateRequest = "/update/request";
  static String extendTrip = "/extend/trip";
  static String payment = "/payment";
  static String deleteAccount = "/delete/account";
  static String showContact = "/show/contact";
  static String showProviders = "/show/providers";
  static String showNearByDriver = "/show_driver_emt";
  static String addSaveContactList = "/add_contact";
  static String editSaveContactList = "/edit/contact";
  static String deleteSaveContactList = "/delete/contact";
  static String giveFeedback = "/ticketcreate";
  static String discountList = "/discount/list";

  static String payStackUrl(
          {required String email,
          required dynamic userId,
          required dynamic amount,
          String paymentMode = "PAYSTACK",
          String? requestId,
          String userType = "user"}) =>
      "${baseUrl}/getform?email=$email&amount=$amount&payment_mode=$paymentMode&user_id=$userId&user_type=$userType ${requestId != null ? "&user_request_id=$requestId" : ""}";
}
