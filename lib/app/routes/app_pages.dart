// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import 'package:my_portfolio/app/modules/mainpage/bindings/mainpage_binding.dart';
import 'package:my_portfolio/app/modules/mainpage/controllers/mainpage_controller.dart';
import 'package:my_portfolio/app/modules/mainpage/views/mainpage_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.MAINPAGE;

  /// Everything lives on one scrolling page. The older section routes still
  /// work as links and open the page scrolled to that section.
  static const _sectionRoutes = {
    _Paths.MAINPAGE: Section.top,
    _Paths.HOME: Section.top,
    _Paths.ABOUT: Section.about,
    _Paths.EDUCATION: Section.path,
    _Paths.EXPERIANCE: Section.path,
    _Paths.PROJECTS: Section.projects,
    _Paths.SKILLS: Section.skills,
    _Paths.CONTACT: Section.contact,
  };

  static final routes = [
    for (final entry in _sectionRoutes.entries)
      GetPage(
        name: entry.key,
        page: () => MainpageView(initialSection: entry.value),
        binding: MainpageBinding(),
      ),
  ];
}
