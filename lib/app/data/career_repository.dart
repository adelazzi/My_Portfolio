import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/app/data/career_data.dart';

/// Loads assets/portfolio/career.json once and tracks the language to show it in.
class CareerRepository extends GetxController {
  static CareerRepository get to => Get.find();

  static const assetPath = 'assets/portfolio/career.json';

  final Rx<CareerData> data = CareerData.empty.obs;
  final RxString lang = 'en'.obs;

  static Future<void> initialize({String lang = 'en'}) async {
    final repo = Get.put(CareerRepository(), permanent: true);
    repo.lang.value = lang;
    final raw = await rootBundle.loadString(assetPath);
    final parsed = CareerData.parse(json.decode(raw));
    if (kDebugMode) {
      for (final w in parsed.warnings) {
        debugPrint('career.json: $w');
      }
    }
    repo.data.value = parsed;
  }
}
