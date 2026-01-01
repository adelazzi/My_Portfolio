// ignore_for_file: constant_identifier_names

//here add  nesesary imports
import 'package:get/get.dart';
import 'package:my_portfolio/app/modules/loading/bindings/loading_binding.dart';
import 'package:my_portfolio/app/modules/loading/views/loading_view.dart';
import 'package:my_portfolio/app/modules/mainpage/bindings/mainpage_binding.dart';
import 'package:my_portfolio/app/modules/mainpage/views/mainpage_view.dart';
import 'package:my_portfolio/app/modules/home/bindings/home_binding.dart';
import 'package:my_portfolio/app/modules/home/views/home_view.dart';
import 'package:my_portfolio/app/modules/about/bindings/about_binding.dart';
import 'package:my_portfolio/app/modules/about/views/about_view.dart';
import 'package:my_portfolio/app/modules/contact/bindings/contact_binding.dart';
import 'package:my_portfolio/app/modules/contact/views/contact_view.dart';
import 'package:my_portfolio/app/modules/education/bindings/education_binding.dart';
import 'package:my_portfolio/app/modules/education/views/education_view.dart';
import 'package:my_portfolio/app/modules/experiance/bindings/experiance_binding.dart';
import 'package:my_portfolio/app/modules/experiance/views/experiance_view.dart';
import 'package:my_portfolio/app/modules/projects/bindings/projects_binding.dart';
import 'package:my_portfolio/app/modules/projects/views/projects_view.dart';
import 'package:my_portfolio/app/modules/skills/bindings/skills_binding.dart';
import 'package:my_portfolio/app/modules/skills/views/skills_view.dart';


part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.MAINPAGE;
  static final routes = [
    // hereadd the new files like the others
    GetPage(
      name: _Paths.LOADING,
      page: () => LoadingView(),
      binding: LoadingBinding(),
    ),
    GetPage(
      name: _Paths.MAINPAGE,
      page: () => MainpageView(),
      binding: MainpageBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ABOUT,
      page: () => AboutView(),
      binding: AboutBinding(),
    ),
    GetPage(
      name: _Paths.CONTACT,
      page: () => ContactView(),
      binding: ContactBinding(),
    ),
    GetPage(
      name: _Paths.EDUCATION,
      page: () => EducationView(),
      binding: EducationBinding(),
    ),
    GetPage(
      name: _Paths.EXPERIANCE,
      page: () => ExperianceView(),
      binding: ExperianceBinding(),
    ),
    GetPage(
      name: _Paths.PROJECTS,
      page: () => ProjectsView(),
      binding: ProjectsBinding(),
    ),
    GetPage(
      name: _Paths.SKILLS,
      page: () => SkillsView(),
      binding: SkillsBinding(),
    ),

  
  ];
}
