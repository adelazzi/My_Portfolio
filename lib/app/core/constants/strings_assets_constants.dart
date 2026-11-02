import 'package:get/get.dart';

/// Interface text. Values live in assets/translations/language_<code>.json.
class StringsAssetsConstants {
  // Personal info
  static String get fullName => "fullName".tr;
  static String get location => "location".tr;
  static String get aboutMe => "aboutMe".tr;
  static String get from => "ui_from".tr;

  // Navigation
  static String get navAbout => "ui_nav_about".tr;
  static String get navPath => "ui_nav_path".tr;
  static String get navProjects => "ui_nav_projects".tr;
  static String get navSkills => "ui_nav_skills".tr;
  static String get navContact => "ui_nav_contact".tr;
  static String get menu => "ui_menu".tr;
  static String get language => "ui_language".tr;
  static String get themeDark => "ui_theme_dark".tr;
  static String get themeLight => "ui_theme_light".tr;

  // Hero
  static String get heroIntro => "ui_hero_intro".tr;
  static String get emailMe => "ui_cta_email".tr;
  static String get downloadCv => "ui_cta_cv".tr;
  static String get since => "ui_since".tr;

  // Sections
  static String get aboutTitle => "ui_about_title".tr;
  static String get pathTitle => "ui_path_title".tr;
  static String get pathHint => "ui_path_hint".tr;
  static String get legendStudy => "ui_legend_study".tr;
  static String get legendRole => "ui_legend_role".tr;
  static String get legendNow => "ui_legend_now".tr;
  static String get present => "ui_present".tr;
  static String get visitSite => "ui_visit_site".tr;
  static String get projectsTitle => "ui_projects_title".tr;
  static String get filterAll => "ui_filter_all".tr;
  static String get filterLabel => "ui_filter_label".tr;
  static String get skillsTitle => "ui_skills_title".tr;
  static String get skillsDaily => "ui_skills_daily".tr;
  static String get skillsFamiliar => "ui_skills_familiar".tr;
  static String get skillsHint => "ui_skills_hint".tr;
  static String projectsCount(int n) => "ui_projects_count".trParams({'n': '$n'});
  static String showProjects(String name) => "ui_show_projects".trParams({'name': name});
  static String get footer => "ui_footer".tr;

  // Contact
  static String get contactTitle => "ui_contact_title".tr;
  static String get contactIntro => "ui_contact_intro".tr;
  static String get copyEmail => "ui_copy_email".tr;
  static String get copied => "ui_copied".tr;
  static String get yourName => "yourName".tr;
  static String get pleaseEnterName => "pleaseEnterName".tr;
  static String get yourEmail => "yourEmail".tr;
  static String get pleaseEnterEmail => "pleaseEnterEmail".tr;
  static String get pleaseEnterValidEmail => "pleaseEnterValidEmail".tr;
  static String get yourMessage => "yourMessage".tr;
  static String get pleaseEnterMessage => "pleaseEnterMessage".tr;
  static String get sendMessage => "sendMessage".tr;
  static String get sending => "ui_sending".tr;
  static String get sent => "ui_sent".tr;
  static String get sendFailed => "ui_send_failed".tr;
}
