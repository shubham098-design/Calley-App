import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/list_detail_model.dart';
import '../model/list_model.dart';


class HomeController extends GetxController {
  var getListIndicator = false.obs;
  var listData = Rxn<ListModel>(); // Nullable reactive object

  Future<void> getList(String id) async {
    try {
      getListIndicator.value = true;

      final url = Uri.parse(
        'https://mock-api.calleyacd.com/api/list?userId=$id',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        listData.value = ListModel.fromJson(data);
      } else {
        Get.snackbar("Error", "Failed to fetch list: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      getListIndicator.value = false;
    }
  }

  var getListDetailsIndicator = false.obs;
  var listDetails = Rxn<ListDetailsModel>();

  Future<void> getListDetails(String listId) async {
    try {
      getListDetailsIndicator.value = true;

      final response = await http.get(
        Uri.parse(
          'https://mock-api.calleyacd.com/api/list/$listId',
        ),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        listDetails.value = ListDetailsModel.fromJson(data);
      } else {
        Get.snackbar("Error", "Failed to fetch details: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      getListDetailsIndicator.value = false;
    }
  }
}
