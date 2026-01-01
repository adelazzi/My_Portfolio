import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/app/core/constants/strings_assets_constants.dart';
import 'package:my_portfolio/app/core/utils/portfolio_data.dart';
import 'package:my_portfolio/app/core/utils/translation_util.dart';
import 'package:my_portfolio/app/models/portfolio_models.dart';

class EducationController extends GetxController {
  var educationList = <Education>[].obs;
  var certifications = <Certafication>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadEducationData();
  }

Future<void> loadEducationData() async {
  isLoading.value = true;
  
  certifications.clear();
  
  // ✅ Use .tr strings that change with language!
  certifications.assignAll([
    Certafication(  // Fixed typo
      name: StringsAssetsConstants.licensedComputerScientist,  // "licentiate_computer_science".tr
      issuer: 'USTHB',
      date: 'June 2024',  // Fixed dates
      credential: 'https://drive.google.com/file/d/1TRhmmKkNHx_toEhfd8XvQ33pbhOnLwaY/view?usp=drive_link',
    ),
    Certafication(
      name: StringsAssetsConstants.valteerArabGames,
      issuer: 'Algeria',
      date: 'July 2023',
      credential: 'https://drive.google.com/file/d/1TTnSF_7Z5bXIhf-0Pb97UOdDXy-B6aQQ/view?usp=drive_link',
    ),
    Certafication(
      name: StringsAssetsConstants.hoskaDevTraining,
      issuer: 'Hoska Dev',
      date: '2023 - 2025',
      credential: 'https://drive.google.com/file/d/1TTkK1Swgf5DdmtcWS5jjf50DYq3xiArq/view?usp=drive_link',
    ),
  ]);

  educationList.value = PortfolioData.educationList;
  isLoading.value = false;
}

}
