// ignore_for_file: unnecessary_getters_setters, prefer_final_fields, no_leading_underscores_for_local_identifiers

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rivus_supplier/constants/constants.dart';
import 'package:rivus_supplier/models/api_error.dart';
import 'package:rivus_supplier/models/environment.dart';
import 'package:rivus_supplier/models/items.dart';
import 'package:rivus_supplier/models/sucess_model.dart';
import 'package:rivus_supplier/views/home/home_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class FoodsController extends GetxController {
  final box = GetStorage();

  var currentPage = 0.obs;

  void updatePage(int index) {
    currentPage.value = index;
  }

  RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  set setLoading(bool newValue) {
    _isLoading.value = newValue;
  }

  // Reactive state using RxInt
  final RxInt _tabIndex = 0.obs;

  // Getter to expose the current value
  int get tabIndex => _tabIndex.value;

  // Setter to change the value and notify listeners
  set setTabIndex(int newValue) {
    _tabIndex.value = newValue; // Update the reactive value
    // update(); // This is optional, as .value already triggers updates
  }

  // RxList<Additive> _additives = <Additive>[].obs;
  //
  // List<Additive> get additives => _additives;
  //
  // set setAdditives(Additive newValue) {
  //   _additives.add(newValue);
  // }

  RxList<String> _tags = <String>[].obs;

  List<String> get tags => _tags;

  set setTags(String newValue) {
    _tags.add(newValue);
  }

  // RxList<String> _type = <String>[].obs;
  //
  // List<String> get type => _type;
  //
  // set setType(String newValue) {
  //   _type.add(newValue);
  // }

  int generateRandomNumber() {
    int min = 10;
    int max = 10000;
    final _random = Random();
    return min + _random.nextInt(max - min + 1);
  }

  //Create category getter and setter of type string
  String _category = '';

  String get category => _category;

  set category(String newValue) {
    _category = newValue;
  }

  void addFood(String foodItem) async {
    String token = box.read('token');
    String accessToken = jsonDecode(token);

    Uri url = Uri.parse('${Environment.appBaseUrl}/api/items');

    try {
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: foodItem,
      );

      if (response.statusCode == 201) {
        var data = successResponseFromJson(response.body);
        setLoading = false;
        Get.snackbar(data.message, "Product successfully added",
            colorText: kLightWhite,
            backgroundColor: kPrimary,
            icon: const Icon(Icons.add_alert));
        Get.to(() => const HomePage(),
            transition: Transition.fadeIn,
            duration: const Duration(seconds: 1));
      } else {
        var data = apiErrorFromJson(response.body);

        Get.snackbar(data.message, "Failed to add product, please try again",
            backgroundColor: kRed, icon: const Icon(Icons.error));
      }
    } catch (e) {
      setLoading = false;

      Get.snackbar(e.toString(), "Failed to add product, please try again",
          colorText: kLightWhite,
          backgroundColor: kRed,
          icon: const Icon(Icons.error));
    } finally {
      setLoading = false;
    }
  }

  // Update Food Method
  void updateFood(String foodId, Item updatedFood) async {
    String token = box.read('token');
    String accessToken = jsonDecode(token);

    Uri url = Uri.parse('${Environment.appBaseUrl}/api/items/update/$foodId');

    try {
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(updatedFood.toJson()),
      );

      if (response.statusCode == 200) {
        var data = successResponseFromJson(response.body);
        setLoading = false;
        Get.snackbar(data.message, "Product successfully updated",
            colorText: kLightWhite,
            backgroundColor: kPrimary,
            icon: const Icon(Icons.add_alert));
        Get.to(() => const HomePage(),
            transition: Transition.fadeIn,
            duration: const Duration(seconds: 1));
      } else {
        var data = apiErrorFromJson(response.body);

        Get.snackbar(data.message, "Failed to update product, please try again",
            backgroundColor: kRed, icon: const Icon(Icons.error));
      }
    } catch (e) {
      setLoading = false;

      Get.snackbar(e.toString(), "Failed to update product, please try again",
          colorText: kLightWhite,
          backgroundColor: kRed,
          icon: const Icon(Icons.error));
    } finally {
      setLoading = false;
    }
  }
}
