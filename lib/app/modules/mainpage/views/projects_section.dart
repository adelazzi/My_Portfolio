import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/app/core/constants/strings_assets_constants.dart';
import 'package:my_portfolio/app/core/design/palette.dart';
import 'package:my_portfolio/app/data/career_data.dart';
import 'package:my_portfolio/app/data/career_repository.dart';
import 'package:my_portfolio/app/modules/mainpage/views/shared.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = CareerRepository.to;
    return SectionFrame(
      top: 120,
      child: Obx(() {
        final projects = repo.data.value.projects;
        final lang = repo.lang.value;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeading(title: StringsAssetsConstants.projectsTitle),
            const SizedBox(height: 40),
            for (var i = 0; i < projects.length; i++) ...[
              if (i > 0) Divider(color: Palette.of(context).mist, height: 72),
              _ProjectRow(project: projects[i], lang: lang, imageFirst: i.isEven),
            ],
          ],
        );
      }),
    );
  }
}

class _ProjectRow extends StatefulWidget {
  const _ProjectRow({required this.project, required this.lang, required this.imageFirst});

  final Project project;
  final String lang;
  final bool imageFirst;

  @override
  State<_ProjectRow> createState() => _ProjectRowState();
}

class _ProjectRowState extends State<_ProjectRow> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final pr = widget.project;
    final compact = Layout.isCompact(context);
    final summary = pr.summary.of(widget.lang);
    final long = summary.length > 320 || '\n'.allMatches(summary).length > 3;

    final image = ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Semantics(
          image: true,
          label: pr.title.of(widget.lang),
          child: AssetPicture(pr.image),
        ),
      ),
    );

    final text = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${pr.date.year}', style: AppType.caption(context)),
        const SizedBox(height: 6),
        Text(pr.title.of(widget.lang), style: AppType.h3(context)),
        if (pr.award != null) ...[
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Container(width: 8, height: 8, color: p.brass),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(pr.award!.of(widget.lang),
                    style: AppType.label(context).copyWith(color: p.brassText)),
              ),
            ],
          ),
        ],
        const SizedBox(height: 12),
        AnimatedSize(
          duration: Layout.reduceMotion(context) ? Duration.zero : const Duration(milliseconds: 200),
          alignment: AlignmentDirectional.topStart,
          child: Text(
            summary,
            style: AppType.body(context),
            maxLines: _expanded || !long ? null : 5,
            overflow: _expanded || !long ? TextOverflow.visible : TextOverflow.ellipsis,
          ),
        ),
        if (long) ...[
          const SizedBox(height: 6),
          InlineLink(
            label: _expanded ? _less(widget.lang) : _more(widget.lang),
            style: AppType.caption(context).copyWith(color: p.ink),
            onTap: () => setState(() => _expanded = !_expanded),
          ),
        ],
        if (pr.tech.isNotEmpty) ...[
          const SizedBox(height: 14),
          Text(pr.tech.join(', '), style: AppType.caption(context)),
        ],
        if (pr.links.isNotEmpty) ...[
          const SizedBox(height: 12),
          Wrap(spacing: 24, children: [
            for (final l in pr.links) InlineLink(label: l.label.of(widget.lang), onTap: () => openUrl(l.url)),
          ]),
        ],
      ],
    );

    if (compact) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [image, const SizedBox(height: 20), text],
      );
    }
    final children = [
      Expanded(flex: 11, child: image),
      const SizedBox(width: 48),
      Expanded(flex: 9, child: text),
    ];
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.imageFirst ? children : children.reversed.toList(),
    );
  }

  // Kept local: only this toggle needs them.
  String _more(String lang) =>
      const {'ar': 'اقرأ المزيد', 'fr': 'Lire la suite', 'ru': 'Читать дальше'}[lang] ?? 'Read more';
  String _less(String lang) =>
      const {'ar': 'عرض أقل', 'fr': 'Réduire', 'ru': 'Свернуть'}[lang] ?? 'Show less';
}
