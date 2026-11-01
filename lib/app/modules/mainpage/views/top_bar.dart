import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/app/core/constants/strings_assets_constants.dart';
import 'package:my_portfolio/app/core/design/palette.dart';
import 'package:my_portfolio/app/core/utils/theme_util.dart';
import 'package:my_portfolio/app/core/utils/translation_util.dart';
import 'package:my_portfolio/app/modules/mainpage/controllers/mainpage_controller.dart';

Map<Section, String> navLabels() => {
      Section.about: StringsAssetsConstants.navAbout,
      Section.path: StringsAssetsConstants.navPath,
      Section.projects: StringsAssetsConstants.navProjects,
      Section.skills: StringsAssetsConstants.navSkills,
      Section.contact: StringsAssetsConstants.navContact,
    };

class TopBar extends GetView<MainpageController> {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final compact = MediaQuery.sizeOf(context).width < 900;
    return Container(
      height: MainpageController.topBarHeight,
      decoration: BoxDecoration(
        color: p.paper,
        border: Border(bottom: BorderSide(color: p.mist)),
      ),
      padding: EdgeInsets.symmetric(horizontal: Layout.gutter(context)),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: Layout.maxWidth),
          child: Row(
            children: [
              TextButton(
                onPressed: () => controller.scrollTo(Section.top),
                style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 4)),
                child: Text(StringsAssetsConstants.fullName,
                    style: AppType.label(context).copyWith(fontWeight: FontWeight.w600)),
              ),
              const Spacer(),
              if (!compact) ...[
                for (final e in navLabels().entries) _NavItem(section: e.key, label: e.value),
                const SizedBox(width: 20),
                const LanguageSwitcher(),
                const SizedBox(width: 4),
              ],
              const _ThemeToggle(),
              if (compact)
                IconButton(
                  tooltip: StringsAssetsConstants.menu,
                  icon: Icon(Icons.menu, color: p.ink),
                  onPressed: () => _openMenu(context),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _openMenu(BuildContext context) {
    final p = Palette.of(context);
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: p.paper,
      shape: const RoundedRectangleBorder(),
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final e in navLabels().entries)
                TextButton(
                  style: TextButton.styleFrom(
                    alignment: AlignmentDirectional.centerStart,
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                  ),
                  onPressed: () {
                    Navigator.of(sheetContext).pop();
                    controller.scrollTo(e.key);
                  },
                  child: Text(e.value, style: AppType.h3(context)),
                ),
              const SizedBox(height: 12),
              Divider(color: p.mist),
              const SizedBox(height: 12),
              const LanguageSwitcher(),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends GetView<MainpageController> {
  const _NavItem({required this.section, required this.label});

  final Section section;
  final String label;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    return Obx(() {
      final selected = controller.active.value == section;
      return Semantics(
        selected: selected,
        child: TextButton(
          onPressed: () => controller.scrollTo(section),
          style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10)),
          child: Container(
            padding: const EdgeInsets.only(bottom: 4),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: selected ? p.forest : Colors.transparent, width: 2),
              ),
            ),
            child: Text(
              label,
              style: AppType.label(context).copyWith(
                color: selected ? p.ink : p.muted,
              ),
            ),
          ),
        ),
      );
    });
  }
}

/// EN AR FR RU as plain codes; the active one is underlined.
class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    return Semantics(
      label: StringsAssetsConstants.language,
      container: true,
      child: Obx(() => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final lang in AppLanguage.values)
                Tooltip(
                  message: TranslationUtil.names[lang]!,
                  child: Semantics(
                    selected: TranslationUtil.isCurrentLanguage(lang),
                    label: TranslationUtil.names[lang],
                    excludeSemantics: true,
                    button: true,
                    child: TextButton(
                      onPressed: () => TranslationUtil.changeLanguage(lang),
                      style: TextButton.styleFrom(
                        minimumSize: const Size(40, 40),
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                      ),
                      child: Text(
                        TranslationUtil.codes[lang]!,
                        style: AppType.caption(context).copyWith(
                          fontWeight: TranslationUtil.isCurrentLanguage(lang)
                              ? FontWeight.w600
                              : FontWeight.w400,
                          color: TranslationUtil.isCurrentLanguage(lang) ? p.ink : p.muted,
                          decoration: TranslationUtil.isCurrentLanguage(lang)
                              ? TextDecoration.underline
                              : null,
                          decorationColor: p.forest,
                          decorationThickness: 2,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          )),
    );
  }
}

class _ThemeToggle extends StatelessWidget {
  const _ThemeToggle();

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    return Obx(() {
      final dark = ThemeUtil.mode.value == ThemeMode.dark;
      return IconButton(
        tooltip: dark ? StringsAssetsConstants.themeLight : StringsAssetsConstants.themeDark,
        onPressed: ThemeUtil.toggle,
        icon: Icon(dark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
            color: p.ink, size: 20),
      );
    });
  }
}
