import 'dart:convert';

import 'package:calley_app/features/services/shared_preferences.dart';
import 'package:calley_app/route/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../screen/otp_verification_screen.dart';

class AuthController extends GetxController {
  var loginIndicator = false.obs;
  var signupIndicator = false.obs;
  var otpVerifyIndictor = false.obs;
   var rxEmail = ''.obs ;
   var rxNumber = ''.obs;

   LanguagePreference languagePreference = LanguagePreference();


  Future<void> signup(String name, String email, String password, String whatsappNo,String mobile) async {
    signupIndicator.value = true;
    try {
      rxEmail.value = email;
      rxNumber.value = whatsappNo;
      final response = await http.post(
        Uri.parse("https://mock-api.calleyacd.com/api/auth/register"),
        body: jsonEncode({
          "username": name,
          "email": email,
          "password": password,
        }),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final otpResponse = await http.post(
          Uri.parse("https://mock-api.calleyacd.com/api/auth/send-otp"),
          body: jsonEncode({
            "email": email,
          }),
          headers: {
            "Content-Type": "application/json",
          },
        );
        if (otpResponse.statusCode == 200 || otpResponse.statusCode == 201) {
          await languagePreference.set_id('123456');
          await languagePreference.set_name(name);
          Get.to(() => OtpVerificationScreen());
          Get.toNamed(RouteName.otp_verification);
        }
      } else {
        Get.snackbar(
          "Signup Failed",
          "Server responded with error: ${response.statusCode}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Something went wrong: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      signupIndicator.value = false;
    }
  }

  Future<void> otpVerify(String otp) async {
    otpVerifyIndictor.value = true;

    try {
      final response = await http.post(
        Uri.parse("https://mock-api.calleyacd.com/api/auth/verify-otp"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "email": rxEmail.value,
          "otp": otp,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        Get.snackbar(
          "Success",
          data["message"] ?? "OTP Verified Successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        Get.toNamed(RouteName.home);

      } else {
        final data = jsonDecode(response.body);
        Get.snackbar(
          "OTP Verification Failed",
          data["message"] ?? "Something went wrong.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Something went wrong: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      otpVerifyIndictor.value = false;
    }
  }

  Future<void> login(String email, String password) async {
    loginIndicator.value = true;
    try {
      final response = await http.post(
        Uri.parse("https://mock-api.calleyacd.com/api/auth/login"),
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final userId = data['user']?['_id'];
        final name = data['user']?['username'];
        if (userId != null ) {
          await languagePreference.set_id(userId);
        } else if(name != null) {
          await languagePreference.set_name(name);
        }else{
          print("either user_id or User name not found in response");
        }
        Get.snackbar(
          "Login ",
          "You are login Successfully!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.toNamed(RouteName.home);
      } else {
        Get.snackbar(
          "login Failed",
          "Server responded with error: ${response.statusCode}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Something went wrong: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      loginIndicator.value = false;
    }
  }

}
