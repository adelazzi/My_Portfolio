import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/app/core/constants/strings_assets_constants.dart';
import 'package:my_portfolio/app/core/design/palette.dart';
import 'package:my_portfolio/app/data/career_data.dart';
import 'package:my_portfolio/app/data/career_repository.dart';
import 'package:my_portfolio/app/modules/mainpage/controllers/mainpage_controller.dart';
import 'package:my_portfolio/app/modules/mainpage/views/shared.dart';

/// Projects as a release index: every project listed at once, a live preview
/// beside the list on wide screens, and filters built from each project's tech.
class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  String? _selectedId;

  static bool _twoPane(BuildContext context) => MediaQuery.sizeOf(context).width >= 900;

  /// Technologies with how many projects use them, most used first.
  List<MapEntry<String, int>> _techCounts(List<Project> projects) {
    final counts = <String, int>{};
    for (final p in projects) {
      for (final t in p.tech.toSet()) {
        counts[t] = (counts[t] ?? 0) + 1;
      }
    }
    return counts.entries.toList()
      ..sort((a, b) => b.value != a.value ? b.value.compareTo(a.value) : a.key.compareTo(b.key));
  }

  @override
  Widget build(BuildContext context) {
    final repo = CareerRepository.to;
    final page = Get.find<MainpageController>();
    return SectionFrame(
      top: 120,
      child: Obx(() {
        final all = repo.data.value.projects;
        final lang = repo.lang.value;
        final filter = page.projectFilter.value;
        final visible = filter == null ? all : all.where((p) => p.tech.contains(filter)).toList();
        final twoPane = _twoPane(context);

        // Keep the selection inside the current filter. On phones nothing is
        // open until a row is tapped, except the newest project to start with.
        Project? selected;
        for (final p in visible) {
          if (p.id == _selectedId) selected = p;
        }
        if (selected == null && visible.isNotEmpty && (twoPane || _selectedId == null)) {
          selected = visible.first;
        }

        final filters = _Filters(
          counts: _techCounts(all),
          total: all.length,
          active: filter,
          onChanged: (f) => page.projectFilter.value = f,
        );
        final index = Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (final p in visible)
              _IndexRow(
                project: p,
                lang: lang,
                selected: p == selected,
                expanded: !twoPane && p == selected,
                selectOnHover: twoPane,
                onSelect: () => setState(() {
                  // Tapping the open row on a phone closes it.
                  _selectedId = !twoPane && p == selected ? '' : p.id;
                }),
              ),
            Container(height: 1, color: Palette.of(context).mist),
          ],
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.end,
              spacing: 24,
              runSpacing: 20,
              children: [SectionHeading(title: StringsAssetsConstants.projectsTitle), filters],
            ),
            const SizedBox(height: 32),
            if (twoPane)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 9, child: index),
                  const SizedBox(width: 40),
                  Expanded(
                    flex: 11,
                    child: AnimatedSwitcher(
                      duration: Layout.reduceMotion(context)
                          ? Duration.zero
                          : const Duration(milliseconds: 220),
                      switchInCurve: Curves.easeOut,
                      switchOutCurve: Curves.easeIn,
                      layoutBuilder: (current, previous) => Stack(
                        alignment: AlignmentDirectional.topStart,
                        children: [...previous, if (current != null) current],
                      ),
                      child: selected == null
                          ? const SizedBox.shrink()
                          : _Preview(key: ValueKey(selected.id), project: selected, lang: lang),
                    ),
                  ),
                ],
              )
            else
              index,
          ],
        );
      }),
    );
  }
}

class _Filters extends StatelessWidget {
  const _Filters({
    required this.counts,
    required this.total,
    required this.active,
    required this.onChanged,
  });

  final List<MapEntry<String, int>> counts;
  final int total;
  final String? active;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: StringsAssetsConstants.filterLabel,
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          _FilterChip(
            label: StringsAssetsConstants.filterAll,
            count: total,
            selected: active == null,
            onTap: () => onChanged(null),
          ),
          for (final c in counts)
            _FilterChip(
              label: c.key,
              count: c.value,
              selected: active == c.key,
              // Tapping the active filter again goes back to all projects.
              onTap: () => onChanged(active == c.key ? null : c.key),
            ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatefulWidget {
  const _FilterChip({
    required this.label,
    required this.count,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final int count;
  final bool selected;
  final VoidCallback onTap;

  @override
  State<_FilterChip> createState() => _FilterChipState();
}

class _FilterChipState extends State<_FilterChip> {
  bool _hover = false;
  bool _focus = false;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final fg = widget.selected ? p.paper : p.ink;
    return Semantics(
      button: true,
      selected: widget.selected,
      label: '${widget.label}, ${widget.count}',
      excludeSemantics: true,
      child: FocusableActionDetector(
        mouseCursor: SystemMouseCursors.click,
        onShowHoverHighlight: (v) => setState(() => _hover = v),
        onShowFocusHighlight: (v) => setState(() => _focus = v),
        actions: {
          ActivateIntent: CallbackAction<ActivateIntent>(onInvoke: (_) {
            widget.onTap();
            return null;
          }),
        },
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: widget.selected
                  ? p.ink
                  : _hover
                      ? p.surface
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(3),
              border: Border.all(
                color: _focus ? p.brass : (widget.selected ? p.ink : p.mist),
                width: _focus ? 2 : 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(widget.label,
                    style: AppType.caption(context).copyWith(color: fg, fontWeight: FontWeight.w500)),
                const SizedBox(width: 6),
                Text('${widget.count}',
                    style: AppType.caption(context)
                        .copyWith(color: widget.selected ? p.paper.withValues(alpha: 0.7) : p.muted)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// One line of the index. On wide screens it drives the preview; on phones it
/// opens in place.
class _IndexRow extends StatefulWidget {
  const _IndexRow({
    required this.project,
    required this.lang,
    required this.selected,
    required this.expanded,
    required this.selectOnHover,
    required this.onSelect,
  });

  final Project project;
  final String lang;
  final bool selected;
  final bool expanded;
  final bool selectOnHover;
  final VoidCallback onSelect;

  @override
  State<_IndexRow> createState() => _IndexRowState();
}

class _IndexRowState extends State<_IndexRow> {
  bool _hover = false;
  bool _focus = false;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final pr = widget.project;
    final active = widget.selected || _hover;
    final year = '${pr.date.year}';

    return Semantics(
      button: true,
      selected: widget.selected,
      expanded: widget.selectOnHover ? null : widget.expanded,
      label: '${pr.title.of(widget.lang)}, $year',
      child: FocusableActionDetector(
        mouseCursor: SystemMouseCursors.click,
        onShowHoverHighlight: (v) {
          setState(() => _hover = v);
          if (v && widget.selectOnHover && !widget.selected) widget.onSelect();
        },
        onShowFocusHighlight: (v) {
          setState(() => _focus = v);
          if (v && widget.selectOnHover && !widget.selected) widget.onSelect();
        },
        actions: {
          ActivateIntent: CallbackAction<ActivateIntent>(onInvoke: (_) {
            widget.onSelect();
            return null;
          }),
        },
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: widget.onSelect,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            decoration: BoxDecoration(
              color: widget.selected ? p.surface : (_hover ? p.surface.withValues(alpha: 0.5) : null),
              border: Border(
                top: BorderSide(color: p.mist),
              ),
            ),
            foregroundDecoration: _focus
                ? BoxDecoration(border: Border.all(color: p.brass, width: 2))
                : null,
            padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
            child: ExcludeSemantics(
              excluding: !widget.expanded,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 56,
                        child: Text(
                          "'${year.substring(2)}",
                          // Keeps the apostrophe before the digits in Arabic too.
                          textDirection: TextDirection.ltr,
                          textAlign: Directionality.of(context) == TextDirection.rtl
                              ? TextAlign.right
                              : TextAlign.left,
                          style: AppType.h2(context).copyWith(
                            fontSize: 28,
                            height: 1,
                            color: widget.selected ? p.forest : p.muted,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text.rich(
                              TextSpan(children: [
                                TextSpan(text: pr.title.of(widget.lang)),
                                if (pr.award != null)
                                  WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.only(start: 8),
                                      child: Container(width: 8, height: 8, color: p.brass),
                                    ),
                                  ),
                              ]),
                              style: AppType.label(context).copyWith(
                                fontSize: 17,
                                color: active ? p.forest : p.ink,
                              ),
                            ),
                            if (pr.tech.isNotEmpty) ...[
                              const SizedBox(height: 4),
                              Text(pr.tech.take(4).join('   '), style: AppType.caption(context)),
                            ],
                          ],
                        ),
                      ),
                      if (!widget.selectOnHover)
                        AnimatedRotation(
                          turns: widget.expanded ? 0.5 : 0,
                          duration: Layout.reduceMotion(context)
                              ? Duration.zero
                              : const Duration(milliseconds: 180),
                          child: Icon(Icons.expand_more, color: p.muted),
                        ),
                    ],
                  ),
                  AnimatedSize(
                    duration: Layout.reduceMotion(context)
                        ? Duration.zero
                        : const Duration(milliseconds: 220),
                    curve: Curves.easeOut,
                    alignment: AlignmentDirectional.topStart,
                    child: widget.expanded
                        ? Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: _ProjectBody(project: pr, lang: widget.lang, showTitle: false),
                          )
                        : const SizedBox(width: double.infinity),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// The large preview beside the index on wide screens.
class _Preview extends StatelessWidget {
  const _Preview({super.key, required this.project, required this.lang});

  final Project project;
  final String lang;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      liveRegion: true,
      child: _ProjectBody(project: project, lang: lang, showTitle: true),
    );
  }
}

/// Image, facts and description of one project.
class _ProjectBody extends StatefulWidget {
  const _ProjectBody({required this.project, required this.lang, required this.showTitle});

  final Project project;
  final String lang;
  final bool showTitle;

  @override
  State<_ProjectBody> createState() => _ProjectBodyState();
}

class _ProjectBodyState extends State<_ProjectBody> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final pr = widget.project;
    final summary = pr.summary.of(widget.lang);
    final long = summary.length > 300 || '\n'.allMatches(summary).length > 3;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: AspectRatio(
            aspectRatio: 16 / 10,
            child: Semantics(
              image: true,
              label: pr.title.of(widget.lang),
              child: AssetPicture(pr.image),
            ),
          ),
        ),
        const SizedBox(height: 18),
        Text(
          [pr.date.year.toString(), if (pr.tech.isNotEmpty) pr.tech.join(', ')].join('   '),
          style: AppType.caption(context),
        ),
        if (widget.showTitle) ...[
          const SizedBox(height: 6),
          Text(pr.title.of(widget.lang), style: AppType.h3(context)),
        ],
        if (pr.award != null) ...[
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 6),
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
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: Text(
            summary,
            style: AppType.body(context),
            maxLines: _expanded || !long ? null : 5,
            overflow: _expanded || !long ? TextOverflow.visible : TextOverflow.ellipsis,
          ),
        ),
        if (long) ...[
          const SizedBox(height: 4),
          ReadMoreButton(
            expanded: _expanded,
            lang: widget.lang,
            onTap: () => setState(() => _expanded = !_expanded),
          ),
        ],
        if (pr.links.isNotEmpty) ...[
          SizedBox(height: long ? 8 : 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              for (final l in pr.links) ExternalLinkButton(label: l.label.of(widget.lang), url: l.url),
            ],
          ),
        ],
      ],
    );
  }

}
