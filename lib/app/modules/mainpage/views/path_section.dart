import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/app/core/constants/strings_assets_constants.dart';
import 'package:my_portfolio/app/core/design/palette.dart';
import 'package:my_portfolio/app/data/career_data.dart';
import 'package:my_portfolio/app/data/career_repository.dart';
import 'package:my_portfolio/app/modules/mainpage/controllers/mainpage_controller.dart';
import 'package:my_portfolio/app/modules/mainpage/views/shared.dart';

/// Career history drawn as a git graph: studies are the main line, the other
/// tracks branch off when something starts and merge back when it ends.
class PathSection extends GetView<MainpageController> {
  const PathSection({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = CareerRepository.to;
    return SectionFrame(
      top: 120,
      child: Obx(() {
        final data = repo.data.value;
        final lang = repo.lang.value;
        final tree = CareerTree.from(data);
        if (tree == null) return const SizedBox.shrink();
        final selected = _resolveSelected(tree, controller.selectedPathIndex.value);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeading(
              title: StringsAssetsConstants.pathTitle,
              intro: StringsAssetsConstants.pathHint,
            ),
            const SizedBox(height: 20),
            const _Legend(),
            const SizedBox(height: 28),
            if (Layout.isCompact(context))
              _VerticalTree(
                tree: tree,
                lang: lang,
                selected: selected,
                onSelect: (i) => controller.selectedPathIndex.value = i,
              )
            else ...[
              _HorizontalTree(
                tree: tree,
                lang: lang,
                selected: selected,
                onSelect: (i) => controller.selectedPathIndex.value = i,
              ),
              const SizedBox(height: 28),
              AnimatedSwitcher(
                duration: Layout.reduceMotion(context)
                    ? Duration.zero
                    : const Duration(milliseconds: 180),
                child: _EntryDetails(
                  key: ValueKey(selected),
                  entry: tree.entries[selected],
                  lang: lang,
                  framed: true,
                ),
              ),
            ],
          ],
        );
      }),
    );
  }

  /// Defaults to the newest ongoing study entry: what you're doing now.
  int _resolveSelected(CareerTree tree, int requested) {
    if (requested >= 0 && requested < tree.entries.length) return requested;
    for (var i = tree.entries.length - 1; i >= 0; i--) {
      final e = tree.entries[i];
      if (e.isCurrent && e.track == tree.mainLane) return i;
    }
    return tree.entries.length - 1;
  }
}

/// Lane geometry shared by both layouts.
class CareerTree {
  CareerTree._({
    required this.lanes,
    required this.mainLane,
    required this.entries,
    required this.intervals,
    required this.goldFrom,
    required this.start,
    required this.now,
  });

  final List<CareerTrack> lanes;
  final String mainLane;

  /// Oldest first.
  final List<PathEntry> entries;

  /// Continuous active stretches per lane, in years.
  final Map<String, List<(double, double)>> intervals;

  /// Where the "happening now" colour starts on each lane, if anything is ongoing.
  final Map<String, double> goldFrom;
  final double start;
  final double now;

  static CareerTree? from(CareerData data) {
    final main = data.mainTrack;
    if (main == null || data.path.isEmpty) return null;
    final laneIds = data.tracks.map((t) => t.id).toSet();
    final entries = data.path.where((e) => laneIds.contains(e.track)).toList();
    if (entries.isEmpty) return null;

    final now = YearMonth.now().value + 1 / 12;
    double endOf(PathEntry e) => math.max(e.end?.value ?? now, e.start.value + 1 / 12);

    final intervals = <String, List<(double, double)>>{};
    final goldFrom = <String, double>{};
    for (final lane in data.tracks) {
      final onLane = entries.where((e) => e.track == lane.id).toList();
      if (onLane.isEmpty) continue;
      final merged = <(double, double)>[];
      if (lane.id == main.id) {
        merged.add((onLane.first.start.value, now));
      } else {
        // Stretches closer than four months read as one continuous branch.
        for (final e in onLane) {
          final s = e.start.value, t = endOf(e);
          if (merged.isNotEmpty && s <= merged.last.$2 + 1 / 3) {
            merged[merged.length - 1] = (merged.last.$1, math.max(merged.last.$2, t));
          } else {
            merged.add((s, t));
          }
        }
      }
      intervals[lane.id] = merged;
      final ongoing = onLane.where((e) => e.isCurrent).map((e) => e.start.value);
      if (ongoing.isNotEmpty) goldFrom[lane.id] = ongoing.reduce(math.max);
    }

    return CareerTree._(
      lanes: data.tracks.where((t) => intervals.containsKey(t.id)).toList(),
      mainLane: main.id,
      entries: entries,
      intervals: intervals,
      goldFrom: goldFrom,
      start: entries.first.start.value,
      now: now,
    );
  }

  bool isActive(String lane, double t) =>
      intervals[lane]?.any((i) => t >= i.$1 && t <= i.$2) ?? false;

  bool isGold(String lane, double from) {
    final g = goldFrom[lane];
    return g != null && from >= g - 1e-6;
  }

  /// The single entry that gets the pulsing "now" marker.
  PathEntry? get headline {
    for (final e in entries.reversed) {
      if (e.isCurrent && e.track == mainLane) return e;
    }
    return null;
  }

  String describe(PathEntry e, String lang) =>
      '${e.title.of(lang)}, ${e.place.of(lang)}, ${formatRange(e.start, e.end)}';
}

enum _NodeKind { study, role, now }

_NodeKind _kindOf(CareerTree tree, PathEntry e) {
  if (e.isCurrent) return _NodeKind.now;
  return e.track == tree.mainLane ? _NodeKind.study : _NodeKind.role;
}

class _Legend extends StatelessWidget {
  const _Legend();

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    Widget item(_NodeKind kind, String label) => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomPaint(size: const Size(14, 14), painter: _DotPainter(kind, p)),
            const SizedBox(width: 8),
            Text(label, style: AppType.caption(context)),
          ],
        );
    return ExcludeSemantics(
      child: Wrap(
        spacing: 24,
        runSpacing: 8,
        children: [
          item(_NodeKind.study, StringsAssetsConstants.legendStudy),
          item(_NodeKind.role, StringsAssetsConstants.legendRole),
          item(_NodeKind.now, StringsAssetsConstants.legendNow),
        ],
      ),
    );
  }
}

void _paintDot(Canvas canvas, Offset c, double r, _NodeKind kind, Palette p) {
  switch (kind) {
    case _NodeKind.study:
      canvas.drawCircle(c, r, Paint()..color = p.forest);
    case _NodeKind.now:
      canvas.drawCircle(c, r, Paint()..color = p.brass);
    case _NodeKind.role:
      canvas.drawCircle(c, r, Paint()..color = p.paper);
      canvas.drawCircle(
          c,
          r - 1.5,
          Paint()
            ..color = p.forest
            ..style = PaintingStyle.stroke
            ..strokeWidth = 3);
  }
}

class _DotPainter extends CustomPainter {
  _DotPainter(this.kind, this.p);

  final _NodeKind kind;
  final Palette p;

  @override
  void paint(Canvas canvas, Size size) =>
      _paintDot(canvas, size.center(Offset.zero), size.shortestSide / 2, kind, p);

  @override
  bool shouldRepaint(_DotPainter old) => old.kind != kind || old.p != p;
}

// ---------------------------------------------------------------------------
// Horizontal layout (tablet and desktop)
// ---------------------------------------------------------------------------

class _HorizontalTree extends StatelessWidget {
  const _HorizontalTree({
    required this.tree,
    required this.lang,
    required this.selected,
    required this.onSelect,
  });

  final CareerTree tree;
  final String lang;
  final int selected;
  final ValueChanged<int> onSelect;

  static const _laneGap = 92.0;
  static const _topPad = 44.0;
  static const _labelWidth = 104.0;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final rtl = Directionality.of(context) == TextDirection.rtl;
    final height = _topPad + (tree.lanes.length - 1) * _laneGap + 76;

    return LayoutBuilder(builder: (context, c) {
      final width = c.maxWidth;
      final geo = _HGeometry(
        tree: tree,
        width: width,
        rtl: rtl,
        left: _labelWidth + 24,
        right: 28,
        laneY: {
          for (var i = 0; i < tree.lanes.length; i++) tree.lanes[i].id: _topPad + i * _laneGap,
        },
      );
      final labels = _placeLabels(geo);
      final headline = tree.headline;

      return SizedBox(
        height: height,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _HTreePainter(geo: geo, p: p, axisY: height - 20, caption: AppType.caption(context)),
              ),
            ),
            for (final lane in tree.lanes)
              Positioned(
                left: rtl ? null : 0,
                right: rtl ? 0 : null,
                top: geo.laneY[lane.id]! - 10,
                width: _labelWidth,
                child: Text(
                  lane.title.of(lang),
                  style: AppType.caption(context).copyWith(
                    color: lane.id == tree.mainLane ? p.ink : p.muted,
                    fontWeight: lane.id == tree.mainLane ? FontWeight.w500 : null,
                  ),
                ),
              ),
            for (var i = 0; i < tree.entries.length; i++) ...[
              Positioned(
                left: geo.x(tree.entries[i].start.value) - 50,
                top: labels[i] ? geo.laneY[tree.entries[i].track]! - 34 : geo.laneY[tree.entries[i].track]! + 16,
                width: 100,
                child: ExcludeSemantics(
                  child: Text(
                    tree.entries[i].label,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppType.caption(context).copyWith(
                      color: i == selected ? p.ink : p.muted,
                      fontWeight: i == selected ? FontWeight.w600 : null,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: geo.x(tree.entries[i].start.value) - 18,
                top: geo.laneY[tree.entries[i].track]! - 18,
                child: _TreeNode(
                  kind: _kindOf(tree, tree.entries[i]),
                  selected: i == selected,
                  pulse: identical(tree.entries[i], headline),
                  semanticLabel: tree.describe(tree.entries[i], lang),
                  onTap: () => onSelect(i),
                ),
              ),
            ],
          ],
        ),
      );
    });
  }

  /// true = label above the node. Flips sides when neighbours would collide.
  List<bool> _placeLabels(_HGeometry geo) {
    final above = List<bool>.filled(tree.entries.length, true);
    final lastX = <String, Map<bool, double>>{};
    final lastLane = tree.lanes.isEmpty ? null : tree.lanes.last.id;
    for (var i = 0; i < tree.entries.length; i++) {
      final e = tree.entries[i];
      final x = geo.x(e.start.value);
      // The lowest lane prefers labels underneath, the rest above.
      var side = e.track != lastLane || e.track == tree.mainLane;
      final seen = lastX.putIfAbsent(e.track, () => {});
      if (seen[side] != null && (x - seen[side]!).abs() < 84) side = !side;
      seen[side] = x;
      above[i] = side;
    }
    return above;
  }
}

class _HGeometry {
  _HGeometry({
    required this.tree,
    required this.width,
    required this.rtl,
    required this.left,
    required this.right,
    required this.laneY,
  });

  final CareerTree tree;
  final double width;
  final bool rtl;
  final double left;
  final double right;
  final Map<String, double> laneY;

  double get t0 => tree.start - 0.15;
  double get t1 => tree.now + 0.1;

  double x(double t) {
    final ltr = left + (t - t0) / (t1 - t0) * (width - left - right);
    return rtl ? width - ltr : ltr;
  }

  /// Direction "later in time" points to on screen.
  double get forward => rtl ? -1 : 1;
}

class _HTreePainter extends CustomPainter {
  _HTreePainter({required this.geo, required this.p, required this.axisY, required this.caption});

  final _HGeometry geo;
  final Palette p;
  final double axisY;
  final TextStyle caption;

  @override
  void paint(Canvas canvas, Size size) {
    final tree = geo.tree;
    final mainY = geo.laneY[tree.mainLane]!;
    Paint stroke(Color c) => Paint()
      ..color = c
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    // Year axis.
    final axis = Paint()
      ..color = p.mist
      ..strokeWidth = 1;
    canvas.drawLine(Offset(geo.x(geo.t0), axisY), Offset(geo.x(geo.t1), axisY), axis);
    for (var y = geo.t0.ceil(); y <= geo.t1; y++) {
      final x = geo.x(y.toDouble());
      canvas.drawLine(Offset(x, axisY - 4), Offset(x, axisY + 4), axis);
      final tp = TextPainter(
        text: TextSpan(text: '$y', style: caption),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(x - tp.width / 2, axisY + 8));
    }

    // Branches first so the main line sits on top where they join it.
    const bend = 40.0;
    for (final lane in tree.lanes) {
      if (lane.id == tree.mainLane) continue;
      final y = geo.laneY[lane.id]!;
      for (final (s, e) in tree.intervals[lane.id]!) {
        final open = e >= tree.now - 1e-6;
        final xs = geo.x(s), xe = geo.x(e);
        final f = geo.forward;
        final path = Path()
          ..moveTo(xs - bend * f, mainY)
          ..cubicTo(xs - bend * f / 2, mainY, xs - bend * f / 2, y, xs, y)
          ..lineTo(xe, y);
        if (!open) {
          path.cubicTo(xe + bend * f / 2, y, xe + bend * f / 2, mainY, xe + bend * f, mainY);
        }
        canvas.drawPath(path, stroke(p.forest));
        if (open && tree.goldFrom[lane.id] != null) {
          final g = math.max(tree.goldFrom[lane.id]!, s);
          canvas.drawLine(Offset(geo.x(g), y), Offset(xe, y), stroke(p.brass));
        }
      }
    }

    final (ms, me) = tree.intervals[tree.mainLane]!.first;
    canvas.drawLine(Offset(geo.x(ms), mainY), Offset(geo.x(me), mainY), stroke(p.forest));
    final g = tree.goldFrom[tree.mainLane];
    if (g != null) {
      canvas.drawLine(Offset(geo.x(g), mainY), Offset(geo.x(me), mainY), stroke(p.brass));
    }
  }

  @override
  bool shouldRepaint(_HTreePainter old) =>
      old.geo.width != geo.width || old.geo.rtl != geo.rtl || old.p != p || old.geo.tree != geo.tree;
}

/// One selectable point on the horizontal tree.
class _TreeNode extends StatefulWidget {
  const _TreeNode({
    required this.kind,
    required this.selected,
    required this.pulse,
    required this.semanticLabel,
    required this.onTap,
  });

  final _NodeKind kind;
  final bool selected;
  final bool pulse;
  final String semanticLabel;
  final VoidCallback onTap;

  @override
  State<_TreeNode> createState() => _TreeNodeState();
}

class _TreeNodeState extends State<_TreeNode> with SingleTickerProviderStateMixin {
  late final AnimationController _pulse =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 2200));
  bool _hover = false;
  bool _focus = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.pulse && !Layout.reduceMotion(context)) {
      if (!_pulse.isAnimating) _pulse.repeat();
    } else {
      _pulse.stop();
    }
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    return Semantics(
      button: true,
      selected: widget.selected,
      label: widget.semanticLabel,
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
          child: Tooltip(
            message: widget.semanticLabel,
            waitDuration: const Duration(milliseconds: 400),
            excludeFromSemantics: true,
            child: SizedBox(
              width: 36,
              height: 36,
              child: AnimatedBuilder(
                animation: _pulse,
                builder: (context, _) => CustomPaint(
                  painter: _NodePainter(
                    kind: widget.kind,
                    p: p,
                    selected: widget.selected,
                    hover: _hover,
                    focus: _focus,
                    pulse: widget.pulse ? _pulse.value : null,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NodePainter extends CustomPainter {
  _NodePainter({
    required this.kind,
    required this.p,
    required this.selected,
    required this.hover,
    required this.focus,
    required this.pulse,
  });

  final _NodeKind kind;
  final Palette p;
  final bool selected;
  final bool hover;
  final bool focus;
  final double? pulse;

  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero);
    if (pulse != null && pulse! > 0) {
      canvas.drawCircle(
          c,
          8 + 10 * pulse!,
          Paint()
            ..color = p.brass.withValues(alpha: (1 - pulse!) * 0.6)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2);
    }
    if (selected || focus) {
      canvas.drawCircle(
          c,
          14,
          Paint()
            ..color = focus ? p.brass : p.ink
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2);
    }
    _paintDot(canvas, c, hover || selected ? 9.5 : 8, kind, p);
  }

  @override
  bool shouldRepaint(_NodePainter old) =>
      old.selected != selected ||
      old.hover != hover ||
      old.focus != focus ||
      old.pulse != pulse ||
      old.p != p ||
      old.kind != kind;
}

// ---------------------------------------------------------------------------
// Vertical layout (phones): newest first, details open under the row
// ---------------------------------------------------------------------------

class _VerticalTree extends StatelessWidget {
  const _VerticalTree({
    required this.tree,
    required this.lang,
    required this.selected,
    required this.onSelect,
  });

  final CareerTree tree;
  final String lang;
  final int selected;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final order = [for (var i = tree.entries.length - 1; i >= 0; i--) i];
    // Main lane hugs the start edge, the others follow in their listed order.
    final laneOrder = [
      tree.mainLane,
      ...tree.lanes.map((l) => l.id).where((id) => id != tree.mainLane),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var r = 0; r < order.length; r++)
          _VerticalRow(
            tree: tree,
            lang: lang,
            entry: tree.entries[order[r]],
            above: r == 0 ? tree.now : tree.entries[order[r - 1]].start.value,
            below: r == order.length - 1 ? null : tree.entries[order[r + 1]].start.value,
            laneOrder: laneOrder,
            selected: order[r] == selected,
            pulse: identical(tree.entries[order[r]], tree.headline),
            onTap: () => onSelect(order[r]),
          ),
      ],
    );
  }
}

class _VerticalRow extends StatefulWidget {
  const _VerticalRow({
    required this.tree,
    required this.lang,
    required this.entry,
    required this.above,
    required this.below,
    required this.laneOrder,
    required this.selected,
    required this.pulse,
    required this.onTap,
  });

  final CareerTree tree;
  final String lang;
  final PathEntry entry;
  final double above;
  final double? below;
  final List<String> laneOrder;
  final bool selected;
  final bool pulse;
  final VoidCallback onTap;

  static const laneStep = 18.0;
  static const nodeY = 22.0;

  @override
  State<_VerticalRow> createState() => _VerticalRowState();
}

class _VerticalRowState extends State<_VerticalRow> {
  bool _focus = false;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final gutter = 14 + (widget.laneOrder.length - 1) * _VerticalRow.laneStep + 22;
    final e = widget.entry;

    return Semantics(
      button: true,
      selected: widget.selected,
      expanded: widget.selected,
      label: widget.tree.describe(e, widget.lang),
      child: FocusableActionDetector(
        mouseCursor: SystemMouseCursors.click,
        onShowFocusHighlight: (v) => setState(() => _focus = v),
        actions: {
          ActivateIntent: CallbackAction<ActivateIntent>(onInvoke: (_) {
            widget.onTap();
            return null;
          }),
        },
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: widget.onTap,
          child: Container(
            decoration: BoxDecoration(
              border: _focus ? Border.all(color: p.brass, width: 2) : null,
            ),
            child: Stack(
              children: [
                PositionedDirectional(
                  start: 0,
                  top: 0,
                  bottom: 0,
                  width: gutter,
                  child: CustomPaint(
                    painter: _VRowPainter(
                      tree: widget.tree,
                      entry: e,
                      above: widget.above,
                      below: widget.below,
                      laneOrder: widget.laneOrder,
                      p: p,
                      selected: widget.selected,
                      rtl: Directionality.of(context) == TextDirection.rtl,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(start: gutter + 4, top: 12, bottom: 20),
                  child: ExcludeSemantics(
                    excluding: !widget.selected,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(e.title.of(widget.lang),
                            style: AppType.label(context).copyWith(
                                fontWeight: widget.selected ? FontWeight.w600 : FontWeight.w500)),
                        const SizedBox(height: 2),
                        Text('${e.place.of(widget.lang)}, ${formatRange(e.start, e.end)}',
                            style: AppType.caption(context)),
                        if (widget.selected) ...[
                          const SizedBox(height: 12),
                          _EntryDetails(entry: e, lang: widget.lang, framed: false),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _VRowPainter extends CustomPainter {
  _VRowPainter({
    required this.tree,
    required this.entry,
    required this.above,
    required this.below,
    required this.laneOrder,
    required this.p,
    required this.selected,
    required this.rtl,
  });

  final CareerTree tree;
  final PathEntry entry;
  final double above;
  final double? below;
  final List<String> laneOrder;
  final Palette p;
  final bool selected;
  final bool rtl;

  @override
  void paint(Canvas canvas, Size size) {
    double laneX(String id) {
      final x = 14 + laneOrder.indexOf(id) * _VerticalRow.laneStep;
      return rtl ? size.width - x : x;
    }

    const ny = _VerticalRow.nodeY;
    final d = entry.start.value;
    final mainX = laneX(tree.mainLane);
    Paint stroke(Color c) => Paint()
      ..color = c
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    for (final lane in laneOrder) {
      final x = laneX(lane);
      final up = tree.isActive(lane, (d + above) / 2);
      final down = below != null && tree.isActive(lane, (d + below!) / 2);
      final upColor = tree.isGold(lane, d) ? p.brass : p.forest;
      final downColor = below != null && tree.isGold(lane, below!) ? p.brass : p.forest;
      final isNodeLane = lane == entry.track;

      final mergesHere = !up && down && lane != tree.mainLane && !isNodeLane;
      if (up) canvas.drawLine(Offset(x, 0), Offset(x, ny), stroke(upColor));
      if (down) {
        // A merge curve below covers the first stretch, so start under it.
        canvas.drawLine(
            Offset(x, mergesHere ? ny + 28 : ny), Offset(x, size.height), stroke(downColor));
      } else if (lane != tree.mainLane && (isNodeLane || up) && below != null) {
        // The branch starts here: curve down into the main line.
        canvas.drawPath(
          Path()
            ..moveTo(x, ny)
            ..cubicTo(x, ny + 18, mainX, size.height - 18, mainX, size.height),
          stroke(p.forest),
        );
      }
      if (mergesHere) {
        // The branch ended between this row and the one above: merge into main.
        canvas.drawPath(
          Path()
            ..moveTo(mainX, ny)
            ..cubicTo(mainX, ny + 18, x, ny + 10, x, ny + 28),
          stroke(p.forest),
        );
      }
    }

    final c = Offset(laneX(entry.track), ny);
    if (selected) {
      canvas.drawCircle(
          c,
          11,
          Paint()
            ..color = p.ink
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2);
    }
    _paintDot(canvas, c, 7, _kindOf(tree, entry), p);
  }

  @override
  bool shouldRepaint(_VRowPainter old) =>
      old.selected != selected || old.p != p || old.entry != entry || old.rtl != rtl;
}

// ---------------------------------------------------------------------------
// Details of one entry
// ---------------------------------------------------------------------------

class _EntryDetails extends StatelessWidget {
  const _EntryDetails({super.key, required this.entry, required this.lang, required this.framed});

  final PathEntry entry;
  final String lang;

  /// Desktop shows a panel; on phones the details sit inside the row.
  final bool framed;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final highlights = entry.highlights.of(lang);
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (framed) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (entry.logo != null) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: SizedBox(
                    width: 48,
                    height: 48,
                    child: ColoredBox(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: AssetPicture(entry.logo, fit: BoxFit.contain, cacheWidth: 160),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(entry.title.of(lang), style: AppType.h3(context)),
                    const SizedBox(height: 4),
                    Text('${entry.place.of(lang)}, ${formatRange(entry.start, entry.end)}',
                        style: AppType.caption(context).copyWith(
                            color: entry.isCurrent ? p.brassText : p.muted,
                            fontWeight: entry.isCurrent ? FontWeight.w500 : null)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
        if (entry.details != null)
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: Text(entry.details!.of(lang), style: AppType.body(context)),
          ),
        if (highlights.isNotEmpty) ...[
          const SizedBox(height: 12),
          for (final h in highlights)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 680),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(width: 10, height: 2, color: p.forest),
                    ),
                    const SizedBox(width: 12),
                    Expanded(child: Text(h, style: AppType.body(context))),
                  ],
                ),
              ),
            ),
        ],
        if (entry.link != null || entry.links.isNotEmpty) ...[
          const SizedBox(height: 12),
          Wrap(
            spacing: 24,
            runSpacing: 8,
            children: [
              if (entry.link != null)
                InlineLink(label: StringsAssetsConstants.visitSite, onTap: () => openUrl(entry.link!)),
              for (final l in entry.links)
                InlineLink(label: l.label.of(lang), onTap: () => openUrl(l.url)),
            ],
          ),
        ],
      ],
    );

    if (!framed) return content;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 22),
      decoration: BoxDecoration(
        color: p.surface,
        border: BorderDirectional(
          start: BorderSide(color: entry.isCurrent ? p.brass : p.forest, width: 3),
        ),
      ),
      child: content,
    );
  }
}
