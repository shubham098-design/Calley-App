import 'package:calley_app/features/auth/controller/auth_controller.dart';
import 'package:calley_app/features/auth/screen/otp_verification_screen.dart';
import 'package:calley_app/features/auth/screen/signup_screen.dart';
import 'package:calley_app/route/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  AuthController authController = Get.put(AuthController());


  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();

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
                AppLocalizations.of(context)!.please_sign_in_to_continue,
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 24),

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
              const SizedBox(height: 3),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                 Text(AppLocalizations.of(context)!.forgot_password,)
                ],
              ),
              const SizedBox(height: 8),

              // Signup In Text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppLocalizations.of(context)!.do_not_have_any_account,),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteName.signup);
                    },
                    child:  Text(
                      AppLocalizations.of(context)!.signup,
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
                      authController.login(emailController.text, passwordController.text);

                    },
                    child: authController.loginIndicator.value ? CircularProgressIndicator()
                        :  Text(AppLocalizations.of(context)!.login, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
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
