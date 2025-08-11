import 'package:calley_app/features/auth/controller/auth_controller.dart';
import 'package:calley_app/features/auth/screen/login_screen.dart';
import 'package:calley_app/features/auth/screen/otp_verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../route/route_name.dart';



class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController whatsappMobileController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  AuthController authController = Get.put(AuthController());

  bool agreeTerms = false;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    whatsappMobileController.dispose();
    mobileController.dispose();
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
              const SizedBox(height: 20),

              // App Logo and Title
              Image.asset(
                'assets/logo.png', // replace with your actual asset
                height: 60,
              ),

              const SizedBox(height: 24),

              // Welcome Text
              Text(
                AppLocalizations.of(context)!.welcome,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
               Text(
                AppLocalizations.of(context)!.please_register_to_continue,
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 24),

              // Name
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.name,
                  suffixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),

              // Email
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.email_address,
                  suffixIcon: Icon(Icons.email_outlined),

                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),

              // Password
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.password,
                  suffixIcon: Icon(Icons.lock_outline),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),

              // Country Code and WhatsApp Icon
              TextFormField(
                controller: whatsappMobileController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: "+91",
                  suffixIcon: Image.asset(
                    'assets/whatsapp.png', // replace with your actual asset
                    height: 24,
                  ),
                  prefixIcon: Image.asset(
                    'assets/india.png', // replace with your actual asset
                    height: 18,
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),

              const SizedBox(height: 16),
              TextFormField(
                controller: mobileController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.mobile_no,
                  suffixIcon: Icon(Icons.phone_android),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),
              // Terms and Conditions
              Row(
                children: [
                  Checkbox(
                    value: agreeTerms,
                    onChanged: (value) {
                      setState(() {
                        agreeTerms = value ?? false;
                      });
                    },
                  ),
                   Text(AppLocalizations.of(context)!.i_agree_to_the),
                  GestureDetector(
                    onTap: () {
                      // Open terms and conditions
                    },
                    child:  Text(
                      AppLocalizations.of(context)!.term_condition,
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Sign In Text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Text(AppLocalizations.of(context)!.already_have_an_account,),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteName.login);

                    },
                    child:  Text(
                      AppLocalizations.of(context)!.sign_in,
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),


              // Sign Up Button
              Obx(
                ()=> SizedBox(
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
                      if (agreeTerms) {
                        authController.signup(nameController.text, emailController.text, passwordController.text, whatsappMobileController.text,mobileController.text);

                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Please agree to the Terms and Conditions")),
                        );
                      }
                    },
                    child: authController.signupIndicator.value ? CircularProgressIndicator()
                        :  Text(AppLocalizations.of(context)!.signup, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
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
