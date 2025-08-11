
import 'package:calley_app/route/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../services/shared_preferences.dart';
import 'bottom_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Dashboard",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: const [
          Icon(Icons.notifications_none, color: Colors.black),
          SizedBox(width: 12),
          Icon(Icons.settings, color: Colors.black),
          SizedBox(width: 8),
        ],
      ),
      body: BottomBar(),
    );
  }
}


class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    LanguagePreference languagePreference = LanguagePreference();
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        scrollDirection:Axis.vertical,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          // Top Profile Header
          Container(
            color: Colors.blue,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage('assets/user.png'), // Replace with your image
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [

                    FutureBuilder<String>(
                      future: languagePreference.get_name(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }
                        if (snapshot.hasError) {
                          return const Text("Error loading name");
                        }
                        return Text("${snapshot.data} • ${ AppLocalizations.of(context)!.personal}" ?? "",style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),);
                      },
                    ),

                    SizedBox(height: 4),
                    Text(
                      "xyz@cstech.in",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),

          // Menu Items
          _drawerItem(Icons.rocket_launch_outlined, AppLocalizations.of(context)!.getting_started),
          _drawerItem(Icons.sync,  AppLocalizations.of(context)!.sync_data),
          _drawerItem(Icons.emoji_events_outlined,  AppLocalizations.of(context)!.gamification),
          _drawerItem(Icons.call_outlined,  AppLocalizations.of(context)!.send_logs),
          _drawerItem(Icons.settings_outlined, AppLocalizations.of(context)!.settings),
          _drawerItem(Icons.help_outline,  AppLocalizations.of(context)!.help),
          _drawerItem(Icons.cancel_outlined,  AppLocalizations.of(context)!.cancel_subscription),

          // App Info Section
           Padding(
            padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
            child: Text(
              AppLocalizations.of(context)!.app_info,
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),

          _drawerItem(Icons.info_outline,  AppLocalizations.of(context)!.about_us,onTap: (){
            Get.toNamed(RouteName.about_us);
          }),
          _drawerItem(Icons.privacy_tip_outlined,  AppLocalizations.of(context)!.privacy_policy),
          _drawerItem(Icons.verified_outlined,  AppLocalizations.of(context)!.version),
          _drawerItem(Icons.share_outlined, AppLocalizations.of(context)!.share_app),
          _drawerItem(Icons.logout_outlined,  AppLocalizations.of(context)!.logout),
        ],
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title, {VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListTile(
        leading: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F7FA),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Icon(icon, color: Colors.black87, size: 22),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}

