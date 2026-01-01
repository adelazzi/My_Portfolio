import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:my_portfolio/app/models/portfolio_models.dart';

import 'package:get/get.dart';

class PortfolioData extends GetxController {
  static PortfolioData? _instance;
  static PortfolioData? get to => _instance ??= Get.put(PortfolioData());

  // Reactive state
  final Rx<Map<String, dynamic>?> _data = Rx<Map<String, dynamic>?>(null);
  final RxString currentLang = 'en'.obs;

  Map<String, dynamic>? get rawData => _data.value;
  String get currentLanguage => currentLang.value;

  @override
  void onInit() {
    super.onInit();
    initial();
  }

  static Future<void> load(String langCode) async {
    try {
      final jsonString =
          await rootBundle.loadString('assets/portfolio/$langCode.json');
      to!._data.value = json.decode(jsonString);
      to!.currentLang.value = langCode;
    } catch (e) {
      // Fallback to English
      final jsonString =
          await rootBundle.loadString('assets/portfolio/en.json');
      to!._data.value = json.decode(jsonString);
      to!.currentLang.value = 'en';
    }
  }

  static Future<void> initial() async {
    try {
      final jsonString =
          await rootBundle.loadString('assets/portfolio/en.json');
      to!._data.value = json.decode(jsonString);
      // print('PortfolioData loaded: ${roles.length} roles'); // Fixed print
    } catch (e) {
      // print('PortfolioData fallback to English: $e');
      final jsonString =
          await rootBundle.loadString('assets/portfolio/en.json');
      to!._data.value = json.decode(jsonString);
    }
  }

  // ✅ ALL YOUR GETTERS - Now reactive!
  static List<Education> get educationList => to!._parsedEducationList;
  List<Education> get _parsedEducationList =>
      (_data.value?['educationList'] as List?)
          ?.map((e) => Education.fromJson(e))
          .toList() ??
      [];

  static List<Experience> get experienceList => to!._parsedExperienceList;
  List<Experience> get _parsedExperienceList =>
      (_data.value?['experienceList'] as List?)
          ?.map((e) => Experience.fromJson(e))
          .toList() ??
      [];

  static List<Project> get projectList => to!._parsedProjectList;
  List<Project> get _parsedProjectList =>
      (_data.value?['projectList'] as List?)
          ?.map((e) => Project.fromJson(e))
          .toList() ??
      [];

  static List<Skill> get skillsList => to!._parsedSkillsList;
  List<Skill> get _parsedSkillsList =>
      (_data.value?['skillsList'] as List?)
          ?.map((e) => Skill.fromJson(e))
          .toList() ??
      [];

  static List<ClubActivity> get clubActivities => to!._parsedClubActivities;
  List<ClubActivity> get _parsedClubActivities =>
      (_data.value?['clubActivities'] as List?)
          ?.map((e) => ClubActivity.fromJson(e))
          .toList() ??
      [];

  static List<String> get roles => to!._parsedRoles;
  List<String> get _parsedRoles {
    final rolesData = _data.value?['roles'];
    if (rolesData == null) return [];
    return List<String>.from(rolesData);
  }

  static List<String> get personalTraits => to!._parsedPersonalTraits;
  List<String> get _parsedPersonalTraits {
    final traitsData = _data.value?['personalTraits'];
    if (traitsData == null) return [];
    return List<String>.from(traitsData);
  }
}
