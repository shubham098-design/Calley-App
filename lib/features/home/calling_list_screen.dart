import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'controller/home_controller.dart';

class CallingListScreen extends StatelessWidget {

  CallingListScreen({super.key,});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    // Fetch data once screen is built
    controller.getList("68626f9497757cb741f449b0");
    controller.getListDetails("68626fb697757cb741f449b9");

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Obx(() {
            if (controller.getListIndicator.value ||
                controller.getListDetailsIndicator.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.listData.value == null ||
                controller.listDetails.value == null) {
              return const Center(child: Text("No data available"));
            }

            final list = controller.listData.value!;
            final details = controller.listDetails.value!;

            return ListView(
              children: [
                const SizedBox(height: 12),

                // Dynamic List Card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            list.name,
                            style: const TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "${details.calls.length}",
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                           Text(
                            AppLocalizations.of(context)!.calls,
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 20,
                        child: Text(
                          list.name.isNotEmpty ? list.name[0] : "?",
                          style: const TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Circular Chart using pending/done/scheduled %
                SizedBox(
                  height: 150,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularPercentIndicator(
                        radius: 60,
                        lineWidth: 12,
                        percent: details.called / details.calls.length,
                        progressColor: Colors.blue,
                        backgroundColor: Colors.transparent,
                        circularStrokeCap: CircularStrokeCap.round,
                      ),
                      CircularPercentIndicator(
                        radius: 60,
                        lineWidth: 12,
                        percent: details.pending / details.calls.length,
                        progressColor: Colors.orange,
                        backgroundColor: Colors.transparent,
                        startAngle: 200,
                        circularStrokeCap: CircularStrokeCap.round,
                      ),
                      CircularPercentIndicator(
                        radius: 60,
                        lineWidth: 12,
                        percent: details.rescheduled / details.calls.length,
                        progressColor: Colors.purple,
                        backgroundColor: Colors.transparent,
                        startAngle: 300,
                        circularStrokeCap: CircularStrokeCap.round,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Status Cards with API data
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    statusCard(AppLocalizations.of(context)!.pending, "${details.pending}", Colors.orange.shade100, Colors.orange),
                    statusCard(AppLocalizations.of(context)!.done, "${details.called}", Colors.green.shade100, Colors.green),
                    statusCard(AppLocalizations.of(context)!.schedule, "${details.rescheduled}", Colors.purple.shade100, Colors.purple),
                  ],
                ),
                const SizedBox(height: 20),

                // Start Calling Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      // Start calling logic here
                    },
                    child:  Text(
                      AppLocalizations.of(context)!.start_calling_now,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget statusCard(String title, String count, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: textColor),
          ),
          const SizedBox(height: 4),
          Text(
            "$count Calls",
            style: const TextStyle(fontSize: 12, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
