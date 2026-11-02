import 'package:flutter/material.dart';
import 'package:my_portfolio/app/core/constants/strings_assets_constants.dart';
import 'package:my_portfolio/app/core/design/palette.dart';
import 'package:my_portfolio/app/data/career_data.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openUrl(String url) async {
  final uri = Uri.tryParse(url);
  if (uri == null) return;
  await launchUrl(uri, mode: LaunchMode.externalApplication);
}

/// "2022 – now", "2020 – 2024" or "2023".
String formatRange(YearMonth start, YearMonth? end) {
  if (end == null) return '${start.year} – ${StringsAssetsConstants.present}';
  if (end.year == start.year) return '${start.year}';
  return '${start.year} – ${end.year}';
}

class SectionHeading extends StatelessWidget {
  const SectionHeading({super.key, required this.title, this.intro});

  final String title;
  final String? intro;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semantics(header: true, child: Text(title, style: AppType.h2(context))),
        if (intro != null) ...[
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620),
            child: Text(intro!, style: AppType.body(context)),
          ),
        ],
      ],
    );
  }
}

/// A plain text link with an underline that thickens on hover and a focus ring.
class InlineLink extends StatefulWidget {
  const InlineLink({super.key, required this.label, required this.onTap, this.style});

  final String label;
  final VoidCallback onTap;
  final TextStyle? style;

  @override
  State<InlineLink> createState() => _InlineLinkState();
}

class _InlineLinkState extends State<InlineLink> {
  bool _hover = false;
  bool _focus = false;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final base = widget.style ?? AppType.label(context);
    return Semantics(
      link: true,
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
          child: Container(
            decoration: BoxDecoration(
              border: _focus ? Border.all(color: p.brass, width: 2) : null,
              borderRadius: BorderRadius.circular(2),
            ),
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Text(
              widget.label,
              style: base.copyWith(
                decoration: TextDecoration.underline,
                decorationColor: _hover ? p.forest : p.mist,
                decorationThickness: _hover ? 2.5 : 1.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Image from assets that keeps its space and stays quiet if the file is missing.
class AssetPicture extends StatelessWidget {
  const AssetPicture(this.path, {super.key, this.fit = BoxFit.cover, this.cacheWidth = 1200});

  final String? path;
  final BoxFit fit;
  final int cacheWidth;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final fallback = ColoredBox(color: p.surface);
    if (path == null) return fallback;
    return Image.asset(
      path!,
      fit: fit,
      cacheWidth: cacheWidth,
      errorBuilder: (_, __, ___) => fallback,
    );
  }
}

/// Compact outlined button for links that leave the site (certificate,
/// website). The arrow says it opens somewhere else.
class ExternalLinkButton extends StatelessWidget {
  const ExternalLinkButton({super.key, required this.label, required this.url});

  final String label;
  final String url;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    return Semantics(
      link: true,
      child: OutlinedButton.icon(
        onPressed: () => openUrl(url),
        icon: Icon(
          Directionality.of(context) == TextDirection.rtl ? Icons.north_west : Icons.north_east,
          size: 16,
        ),
        iconAlignment: IconAlignment.end,
        label: Text(label),
        style: OutlinedButton.styleFrom(
          foregroundColor: p.ink,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          minimumSize: const Size(0, 40),
          textStyle: AppType.label(context).copyWith(fontSize: 14),
        ).copyWith(
          side: WidgetStateProperty.resolveWith((s) {
            if (s.contains(WidgetState.focused)) return BorderSide(color: p.brass, width: 2);
            if (s.contains(WidgetState.hovered)) return BorderSide(color: p.forest, width: 1.5);
            return BorderSide(color: p.mist, width: 1.5);
          }),
          backgroundColor: WidgetStateProperty.resolveWith(
              (s) => s.contains(WidgetState.hovered) ? p.surface : Colors.transparent),
        ),
      ),
    );
  }
}

/// "Read more" / "Show less" toggle for long descriptions.
class ReadMoreButton extends StatelessWidget {
  const ReadMoreButton({super.key, required this.expanded, required this.lang, required this.onTap});

  final bool expanded;
  final String lang;
  final VoidCallback onTap;

  static const _more = {'ar': 'اقرأ المزيد', 'fr': 'Lire la suite', 'ru': 'Читать дальше'};
  static const _less = {'ar': 'عرض أقل', 'fr': 'Réduire', 'ru': 'Свернуть'};

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    return Semantics(
      expanded: expanded,
      child: TextButton.icon(
        onPressed: onTap,
        icon: Icon(expanded ? Icons.expand_less : Icons.expand_more, size: 20),
        iconAlignment: IconAlignment.end,
        label: Text(expanded ? (_less[lang] ?? 'Show less') : (_more[lang] ?? 'Read more')),
        style: TextButton.styleFrom(
          foregroundColor: p.forest,
          padding: const EdgeInsetsDirectional.only(start: 0, end: 8, top: 10, bottom: 10),
          minimumSize: const Size(0, 40),
          textStyle: AppType.label(context).copyWith(fontSize: 14),
        ),
      ),
    );
  }
}
