import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/app/core/constants/constant_url.dart';
import 'package:my_portfolio/app/core/constants/strings_assets_constants.dart';
import 'package:my_portfolio/app/core/design/palette.dart';
import 'package:my_portfolio/app/data/career_data.dart';
import 'package:my_portfolio/app/data/career_repository.dart';
import 'package:my_portfolio/app/modules/mainpage/views/shared.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final wide = Layout.isWide(context);
    final p = Palette.of(context);

    final intro = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semantics(
          header: true,
          child: Text(
            StringsAssetsConstants.fullName.replaceFirst(' ', '\n'),
            style: AppType.display(context),
          ),
        ),
        const SizedBox(height: 28),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Text(StringsAssetsConstants.heroIntro, style: AppType.lead(context)),
        ),
        const SizedBox(height: 32),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            FilledButton(
              onPressed: () => openUrl('mailto:${UrlsConstants.email}'),
              child: Text(StringsAssetsConstants.emailMe),
            ),
            OutlinedButton(
              onPressed: () => openUrl(UrlsConstants.cvUrl),
              child: Text(StringsAssetsConstants.downloadCv),
            ),
          ],
        ),
        const SizedBox(height: 28),
        Text(StringsAssetsConstants.location, style: AppType.label(context)),
        const SizedBox(height: 2),
        Text(StringsAssetsConstants.from, style: AppType.caption(context)),
      ],
    );

    return SectionFrame(
      top: 88,
      child: wide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(flex: 6, child: intro),
                const SizedBox(width: 56),
                const Expanded(flex: 4, child: RoleThreads()),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                intro,
                const SizedBox(height: 48),
                Divider(color: p.mist),
                const SizedBox(height: 28),
                const RoleThreads(),
              ],
            ),
    );
  }
}

/// Each role is a line that starts in the year it began and runs to today,
/// all on one shared time axis. They draw in together once on load.
class RoleThreads extends StatefulWidget {
  const RoleThreads({super.key});

  @override
  State<RoleThreads> createState() => _RoleThreadsState();
}

class _RoleThreadsState extends State<RoleThreads> with SingleTickerProviderStateMixin {
  late final AnimationController _draw = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1100),
  );
  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;
    if (Layout.reduceMotion(context)) {
      _draw.value = 1;
    } else {
      Future.delayed(const Duration(milliseconds: 250), () {
        if (mounted) _draw.forward();
      });
    }
  }

  @override
  void dispose() {
    _draw.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final repo = CareerRepository.to;
    return Obx(() {
      final lang = repo.lang.value;
      final roles = [...repo.data.value.roles]..sort((a, b) => a.since.compareTo(b.since));
      if (roles.isEmpty) return const SizedBox.shrink();

      final now = YearMonth.now().value;
      final first = roles.first.since.toDouble();
      final span = math.max(now - first, 1.0);
      final newest = roles.last.since;
      final curve = CurvedAnimation(parent: _draw, curve: Curves.easeOutCubic);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final role in roles.reversed)
            Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Semantics(
                label: '${role.title.of(lang)}, ${StringsAssetsConstants.since} ${role.since}',
                excludeSemantics: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(role.title.of(lang),
                              style: AppType.label(context), overflow: TextOverflow.ellipsis),
                        ),
                        Text('${StringsAssetsConstants.since} ${role.since}',
                            style: AppType.caption(context)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    LayoutBuilder(builder: (context, c) {
                      final startFrac = ((role.since - first) / span).clamp(0.0, 1.0);
                      return Container(
                        height: 3,
                        color: p.mist,
                        alignment: AlignmentDirectional.centerStart,
                        padding: EdgeInsetsDirectional.only(start: c.maxWidth * startFrac),
                        child: AnimatedBuilder(
                          animation: curve,
                          builder: (context, _) => FractionallySizedBox(
                            widthFactor: curve.value,
                            child: Container(
                              height: 3,
                              color: role.since == newest ? p.brass : p.forest,
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          Row(
            children: [
              Text('${roles.first.since}', style: AppType.caption(context)),
              const Spacer(),
              Text(StringsAssetsConstants.present, style: AppType.caption(context)),
            ],
          ),
        ],
      );
    });
  }
}
