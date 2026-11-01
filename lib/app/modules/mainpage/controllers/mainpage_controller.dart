import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum Section { top, about, path, projects, skills, contact }

class MainpageController extends GetxController {
  static const topBarHeight = 68.0;

  /// Skips most of a section's top padding when jumping to it.
  static const sectionLead = 64.0;

  final scrollController = ScrollController();
  final Map<Section, GlobalKey> keys = {
    for (final s in Section.values) s: GlobalKey(debugLabel: s.name),
  };

  /// The section currently under the top bar, highlighted in the navigation.
  final Rx<Section> active = Section.top.obs;

  /// Index of the selected point in the career tree; -1 picks the current one.
  final RxInt selectedPathIndex = (-1).obs;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_updateActive);
  }

  void _updateActive() {
    var current = Section.top;
    for (final section in Section.values) {
      final box = keys[section]!.currentContext?.findRenderObject() as RenderBox?;
      if (box == null || !box.attached) continue;
      final top = box.localToGlobal(Offset.zero).dy;
      if (top <= topBarHeight + 140) current = section;
    }
    if (scrollController.position.extentAfter < 40) current = Section.contact;
    if (active.value != current) active.value = current;
  }

  Future<void> scrollTo(Section section, {bool animate = true}) async {
    final context = keys[section]!.currentContext;
    if (context == null) return;
    if (section == Section.top) {
      animate
          ? await scrollController.animateTo(0,
              duration: const Duration(milliseconds: 450), curve: Curves.easeInOutCubic)
          : scrollController.jumpTo(0);
      return;
    }
    final box = context.findRenderObject() as RenderBox;
    final target = (scrollController.offset +
            box.localToGlobal(Offset.zero).dy -
            topBarHeight +
            sectionLead)
        .clamp(0.0, scrollController.position.maxScrollExtent);
    animate
        ? await scrollController.animateTo(target,
            duration: const Duration(milliseconds: 450), curve: Curves.easeInOutCubic)
        : scrollController.jumpTo(target);
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
