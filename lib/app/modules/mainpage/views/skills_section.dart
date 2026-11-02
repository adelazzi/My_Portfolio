import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/app/core/constants/strings_assets_constants.dart';
import 'package:my_portfolio/app/core/design/palette.dart';
import 'package:my_portfolio/app/data/career_data.dart';
import 'package:my_portfolio/app/data/career_repository.dart';
import 'package:my_portfolio/app/modules/mainpage/controllers/mainpage_controller.dart';
import 'package:my_portfolio/app/modules/mainpage/views/shared.dart';

/// Skills grouped by area. A filled square marks daily tools, an outlined one
/// tools used before. Skills that appear in projects link to that filter.
class SkillsSection extends GetView<MainpageController> {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = CareerRepository.to;
    return SectionFrame(
      top: 120,
      child: Obx(() {
        final data = repo.data.value;

        // Areas in the order they first appear in career.json.
        final areas = <String, List<Skill>>{};
        for (final s in data.skills) {
          areas.putIfAbsent(s.area.isEmpty ? '—' : s.area, () => []).add(s);
        }
        for (final list in areas.values) {
          list.sort((a, b) => a.level.index.compareTo(b.level.index));
        }

        // Project tech names, matched to skills without caring about case.
        final techByKey = <String, String>{};
        final counts = <String, int>{};
        for (final p in data.projects) {
          for (final t in p.tech.toSet()) {
            techByKey[t.toLowerCase()] = t;
            counts[t.toLowerCase()] = (counts[t.toLowerCase()] ?? 0) + 1;
          }
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeading(
              title: StringsAssetsConstants.skillsTitle,
              intro: StringsAssetsConstants.skillsHint,
            ),
            const SizedBox(height: 20),
            const _Legend(),
            const SizedBox(height: 36),
            LayoutBuilder(builder: (context, c) {
              const gap = 40.0;
              final columns = c.maxWidth >= 1000 ? 4 : (c.maxWidth >= 560 ? 2 : 1);
              final width = (c.maxWidth - gap * (columns - 1)) / columns;
              return Wrap(
                spacing: gap,
                runSpacing: 44,
                children: [
                  for (final area in areas.entries)
                    SizedBox(
                      width: width,
                      child: _AreaColumn(
                        area: area.key,
                        skills: area.value,
                        countOf: (s) => counts[s.name.toLowerCase()] ?? 0,
                        onOpen: (s) {
                          controller.projectFilter.value = techByKey[s.name.toLowerCase()];
                          controller.scrollTo(Section.projects);
                        },
                      ),
                    ),
                ],
              );
            }),
          ],
        );
      }),
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend();

  @override
  Widget build(BuildContext context) {
    Widget item(SkillLevel level, String label) => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _LevelMark(level: level),
            const SizedBox(width: 8),
            Text(label, style: AppType.caption(context)),
          ],
        );
    return ExcludeSemantics(
      child: Wrap(
        spacing: 24,
        runSpacing: 8,
        children: [
          item(SkillLevel.daily, StringsAssetsConstants.skillsDaily),
          item(SkillLevel.familiar, StringsAssetsConstants.skillsFamiliar),
        ],
      ),
    );
  }
}

class _LevelMark extends StatelessWidget {
  const _LevelMark({required this.level});

  final SkillLevel level;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final daily = level == SkillLevel.daily;
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: daily ? p.forest : Colors.transparent,
        border: Border.all(color: p.forest, width: 1.5),
      ),
    );
  }
}

class _AreaColumn extends StatelessWidget {
  const _AreaColumn({
    required this.area,
    required this.skills,
    required this.countOf,
    required this.onOpen,
  });

  final String area;
  final List<Skill> skills;
  final int Function(Skill) countOf;
  final ValueChanged<Skill> onOpen;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: p.ink, width: 2))),
          child: Row(
            children: [
              Expanded(child: Text(area, style: AppType.h3(context).copyWith(fontSize: 18))),
              Text('${skills.length}', style: AppType.caption(context)),
            ],
          ),
        ),
        for (final s in skills) _SkillRow(skill: s, count: countOf(s), onOpen: () => onOpen(s)),
      ],
    );
  }
}

class _SkillRow extends StatefulWidget {
  const _SkillRow({required this.skill, required this.count, required this.onOpen});

  final Skill skill;
  final int count;
  final VoidCallback onOpen;

  @override
  State<_SkillRow> createState() => _SkillRowState();
}

class _SkillRowState extends State<_SkillRow> {
  bool _hover = false;
  bool _focus = false;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final s = widget.skill;
    final daily = s.level == SkillLevel.daily;
    final linked = widget.count > 0;

    final row = AnimatedContainer(
      duration: const Duration(milliseconds: 120),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        color: _hover && linked ? p.surface : Colors.transparent,
        border: Border(bottom: BorderSide(color: p.mist)),
      ),
      foregroundDecoration:
          _focus ? BoxDecoration(border: Border.all(color: p.brass, width: 2)) : null,
      child: Row(
        children: [
          _LevelMark(level: s.level),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              s.name,
              style: AppType.label(context).copyWith(
                fontSize: daily ? 17 : 16,
                fontWeight: daily ? FontWeight.w600 : FontWeight.w400,
                color: _hover && linked ? p.forest : (daily ? p.ink : p.inkSoft),
              ),
            ),
          ),
          if (linked) ...[
            Text(StringsAssetsConstants.projectsCount(widget.count),
                style: AppType.caption(context).copyWith(color: _hover ? p.forest : p.muted)),
            const SizedBox(width: 4),
            Icon(Icons.arrow_upward, size: 14, color: _hover ? p.forest : p.muted),
          ],
        ],
      ),
    );

    if (!linked) {
      return Semantics(
        label: '${s.name}, ${daily ? StringsAssetsConstants.skillsDaily : StringsAssetsConstants.skillsFamiliar}',
        excludeSemantics: true,
        child: row,
      );
    }
    return Semantics(
      button: true,
      label: '${s.name}, ${daily ? StringsAssetsConstants.skillsDaily : StringsAssetsConstants.skillsFamiliar}. '
          '${StringsAssetsConstants.showProjects(s.name)}',
      excludeSemantics: true,
      child: Tooltip(
        message: StringsAssetsConstants.showProjects(s.name),
        waitDuration: const Duration(milliseconds: 500),
        excludeFromSemantics: true,
        child: FocusableActionDetector(
          mouseCursor: SystemMouseCursors.click,
          onShowHoverHighlight: (v) => setState(() => _hover = v),
          onShowFocusHighlight: (v) => setState(() => _focus = v),
          actions: {
            ActivateIntent: CallbackAction<ActivateIntent>(onInvoke: (_) {
              widget.onOpen();
              return null;
            }),
          },
          child: GestureDetector(onTap: widget.onOpen, child: row),
        ),
      ),
    );
  }
}
