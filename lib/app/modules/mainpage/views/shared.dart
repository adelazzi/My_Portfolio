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
