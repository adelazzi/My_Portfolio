import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/app/modules/mainpage/controllers/mainpage_controller.dart';
import 'package:my_portfolio/app/modules/mainpage/views/about_section.dart';
import 'package:my_portfolio/app/modules/mainpage/views/contact_section.dart';
import 'package:my_portfolio/app/modules/mainpage/views/hero_section.dart';
import 'package:my_portfolio/app/modules/mainpage/views/path_section.dart';
import 'package:my_portfolio/app/modules/mainpage/views/projects_section.dart';
import 'package:my_portfolio/app/modules/mainpage/views/skills_section.dart';
import 'package:my_portfolio/app/modules/mainpage/views/top_bar.dart';

/// The whole portfolio on one scrolling page, on every screen size.
class MainpageView extends StatefulWidget {
  const MainpageView({super.key, this.initialSection = Section.top});

  final Section initialSection;

  @override
  State<MainpageView> createState() => _MainpageViewState();
}

class _MainpageViewState extends State<MainpageView> {
  final controller = Get.find<MainpageController>();

  @override
  void initState() {
    super.initState();
    if (widget.initialSection != Section.top) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => controller.scrollTo(widget.initialSection, animate: false),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget anchored(Section s, Widget child) => KeyedSubtree(key: controller.keys[s], child: child);

    return Scaffold(
      body: Column(
        children: [
          const TopBar(),
          Expanded(
            child: SingleChildScrollView(
              controller: controller.scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  anchored(Section.top, const HeroSection()),
                  anchored(Section.about, const AboutSection()),
                  anchored(Section.path, const PathSection()),
                  anchored(Section.projects, const ProjectsSection()),
                  anchored(Section.skills, const SkillsSection()),
                  anchored(Section.contact, const ContactSection()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
