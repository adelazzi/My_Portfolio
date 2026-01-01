import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/app/core/utils/portfolio_data.dart';
import 'package:my_portfolio/app/models/portfolio_models.dart';
class ExperianceController extends GetxController {
  var experienceList = <Experience>[].obs;
  var clubActivities = <ClubActivity>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadExperienceData();
    // ever(TranslationUtil.rxCurrentLocale, (_) => loadExperienceData());
  }

  Future<void> loadExperienceData() async {
    isLoading.value = true;
    experienceList.value = PortfolioData.experienceList;
    clubActivities.value = PortfolioData.clubActivities;
    await Future.delayed(500.ms);
    isLoading.value = false;
  }
}
