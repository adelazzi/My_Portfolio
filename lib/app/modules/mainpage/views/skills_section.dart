import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/app/core/constants/strings_assets_constants.dart';
import 'package:my_portfolio/app/core/design/palette.dart';
import 'package:my_portfolio/app/data/career_data.dart';
import 'package:my_portfolio/app/data/career_repository.dart';
import 'package:my_portfolio/app/modules/mainpage/views/shared.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = CareerRepository.to;
    return SectionFrame(
      top: 120,
      child: Obx(() {
        final skills = repo.data.value.skills;
        final daily = skills.where((s) => s.level == SkillLevel.daily).toList();
        final familiar = skills.where((s) => s.level == SkillLevel.familiar).toList();
        final columns = [
          _SkillColumn(title: StringsAssetsConstants.skillsDaily, skills: daily, strong: true),
          _SkillColumn(title: StringsAssetsConstants.skillsFamiliar, skills: familiar, strong: false),
        ];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeading(title: StringsAssetsConstants.skillsTitle),
            const SizedBox(height: 36),
            if (Layout.isCompact(context))
              Column(children: [columns[0], const SizedBox(height: 40), columns[1]])
            else
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: columns[0]),
                  const SizedBox(width: 56),
                  Expanded(child: columns[1]),
                ],
              ),
          ],
        );
      }),
    );
  }
}

class _SkillColumn extends StatelessWidget {
  const _SkillColumn({required this.title, required this.skills, required this.strong});

  final String title;
  final List<Skill> skills;

  /// Daily tools are set larger than the ones used now and then.
  final bool strong;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final nameStyle = strong
        ? AppType.h3(context)
        : AppType.label(context).copyWith(fontSize: 17, fontWeight: FontWeight.w400);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title, style: AppType.label(context).copyWith(color: strong ? p.forest : p.muted)),
        const SizedBox(height: 12),
        for (final s in skills)
          Container(
            padding: EdgeInsets.symmetric(vertical: strong ? 12 : 10),
            decoration: BoxDecoration(border: Border(top: BorderSide(color: p.mist))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Expanded(child: Text(s.name, style: nameStyle)),
                Text(s.area, style: AppType.caption(context)),
              ],
            ),
          ),
      ],
    );
  }
}
