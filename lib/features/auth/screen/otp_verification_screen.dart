import 'package:calley_app/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class OtpVerificationScreen extends StatefulWidget {

  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  TextEditingController otpController  = TextEditingController();
  AuthController authController = Get.put(AuthController());

  @override
  void dispose() {
    super.dispose();
    otpController .dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FBFF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),

              // Logo
              Image.asset(
                'assets/logo.png', // Ensure logo.png is in assets
                height: 80,
              ),

              const SizedBox(height: 24),

              // Title
               Text(
               AppLocalizations.of(context)!.whats_app_notification,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),

               Text(
                AppLocalizations.of(context)!.please_ensure,
                style: TextStyle(fontSize: 14, color: Colors.black54),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 24),

              // OTP Input
              PinCodeTextField(
                appContext: context,
                length: 6,
                controller: otpController,
                onChanged: (value) {
                },
                keyboardType: TextInputType.number,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(10),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Colors.white,
                  selectedFillColor: Colors.white,
                  inactiveFillColor: Colors.white,
                  inactiveColor: Colors.black26,
                  selectedColor: Colors.blue,
                  activeColor: Colors.black26,
                ),
                enableActiveFill: true,
              ),

              const SizedBox(height: 12),

              // Mobile number
              Obx(
                ()=> Text(
                  "+91 ${authController.rxNumber}",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),

              const SizedBox(height: 16),

              // Resend OTP
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Text(AppLocalizations.of(context)!.did_not_receive_otp_code,),
                  GestureDetector(
                    onTap: () {
                      // Resend OTP logic here
                    },
                    child:  Text(
                      AppLocalizations.of(context)!.resend_otp,
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Verify Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2962FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    String enteredOtp = otpController.text.trim();

                    if (enteredOtp.length == 6) {
                      print("Verifying OTP: $enteredOtp");
                      authController.otpVerify(enteredOtp);

                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please enter a valid 6-digit OTP")),
                      );
                    }
                  },
                  child: authController.otpVerifyIndictor.value
                      ? const CircularProgressIndicator() : Text(
                    AppLocalizations.of(context)!.verify,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
