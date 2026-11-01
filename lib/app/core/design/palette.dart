import 'package:flutter/material.dart';

/// Colour tokens for the "running in parallel" design.
/// Read them with `Palette.of(context)`.
@immutable
class Palette extends ThemeExtension<Palette> {
  const Palette({
    required this.paper,
    required this.surface,
    required this.ink,
    required this.inkSoft,
    required this.muted,
    required this.mist,
    required this.forest,
    required this.onForest,
    required this.brass,
    required this.brassText,
    required this.danger,
  });

  /// Page background.
  final Color paper;

  /// Slightly raised areas: detail panel, inputs.
  final Color surface;

  /// Main text.
  final Color ink;

  /// Body copy that sits under a heading.
  final Color inkSoft;

  /// Captions, dates, hints.
  final Color muted;

  /// Hairlines and inactive tracks.
  final Color mist;

  /// Brand green: primary buttons, finished milestones, branch lines.
  final Color forest;
  final Color onForest;

  /// Only for what is happening now.
  final Color brass;

  /// Brass dark enough to read as text on [paper].
  final Color brassText;
  final Color danger;

  static const light = Palette(
    paper: Color(0xFFF3F5F1),
    surface: Color(0xFFE6EBE4),
    ink: Color(0xFF14201A),
    inkSoft: Color(0xFF2E3D34),
    muted: Color(0xFF55665B),
    mist: Color(0xFFC9D3CB),
    forest: Color(0xFF02522F),
    onForest: Color(0xFFF3F5F1),
    brass: Color(0xFFC9962B),
    brassText: Color(0xFF805C10),
    danger: Color(0xFFB3261E),
  );

  static const dark = Palette(
    paper: Color(0xFF0F1A14),
    surface: Color(0xFF17251D),
    ink: Color(0xFFE6ECE7),
    inkSoft: Color(0xFFC3CEC6),
    muted: Color(0xFF94A59A),
    mist: Color(0xFF2B3B31),
    forest: Color(0xFF63BD8E),
    onForest: Color(0xFF0F1A14),
    brass: Color(0xFFD9A93E),
    brassText: Color(0xFFE2B85A),
    danger: Color(0xFFF2867D),
  );

  static Palette of(BuildContext context) =>
      Theme.of(context).extension<Palette>() ?? light;

  @override
  Palette copyWith() => this;

  @override
  Palette lerp(ThemeExtension<Palette>? other, double t) {
    if (other is! Palette) return this;
    Color l(Color a, Color b) => Color.lerp(a, b, t)!;
    return Palette(
      paper: l(paper, other.paper),
      surface: l(surface, other.surface),
      ink: l(ink, other.ink),
      inkSoft: l(inkSoft, other.inkSoft),
      muted: l(muted, other.muted),
      mist: l(mist, other.mist),
      forest: l(forest, other.forest),
      onForest: l(onForest, other.onForest),
      brass: l(brass, other.brass),
      brassText: l(brassText, other.brassText),
      danger: l(danger, other.danger),
    );
  }
}

/// Type scale. Headings use IBM Plex Sans Condensed, everything else IBM Plex
/// Sans; Arabic falls back to IBM Plex Sans Arabic.
class AppType {
  AppType._();

  static const sans = 'PlexSans';
  static const condensed = 'PlexCondensed';
  static const fallback = ['PlexArabic'];

  static bool _compact(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 720;

  static TextStyle _base(BuildContext context, {String family = sans}) =>
      TextStyle(
        fontFamily: family,
        fontFamilyFallback: fallback,
        color: Palette.of(context).ink,
      );

  static TextStyle display(BuildContext context) =>
      _base(context, family: condensed).copyWith(
        fontSize: _compact(context) ? 60 : 104,
        fontWeight: FontWeight.w600,
        height: 0.92,
        letterSpacing: _compact(context) ? -1 : -2.5,
      );

  static TextStyle h2(BuildContext context) =>
      _base(context, family: condensed).copyWith(
        fontSize: _compact(context) ? 32 : 44,
        fontWeight: FontWeight.w600,
        height: 1.05,
        letterSpacing: -0.5,
      );

  static TextStyle h3(BuildContext context) => _base(context).copyWith(
        fontSize: _compact(context) ? 19 : 22,
        fontWeight: FontWeight.w600,
        height: 1.3,
      );

  static TextStyle lead(BuildContext context) => _base(context).copyWith(
        fontSize: _compact(context) ? 18 : 21,
        height: 1.55,
        color: Palette.of(context).inkSoft,
      );

  static TextStyle body(BuildContext context) => _base(context).copyWith(
        fontSize: 16,
        height: 1.65,
        color: Palette.of(context).inkSoft,
      );

  static TextStyle label(BuildContext context) => _base(context).copyWith(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        height: 1.3,
      );

  static TextStyle caption(BuildContext context) => _base(context).copyWith(
        fontSize: 13,
        height: 1.4,
        color: Palette.of(context).muted,
      );
}

class AppTheme {
  AppTheme._();

  static ThemeData light() => _build(Palette.light, Brightness.light);
  static ThemeData dark() => _build(Palette.dark, Brightness.dark);

  static ThemeData _build(Palette p, Brightness brightness) {
    final scheme = ColorScheme.fromSeed(
      seedColor: p.forest,
      brightness: brightness,
    ).copyWith(
      primary: p.forest,
      onPrimary: p.onForest,
      secondary: p.brass,
      surface: p.paper,
      onSurface: p.ink,
      error: p.danger,
      outline: p.mist,
    );
    const radius = BorderRadius.all(Radius.circular(4));
    final focusRing = BorderSide(color: p.brass, width: 2);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: p.paper,
      canvasColor: p.paper,
      fontFamily: AppType.sans,
      fontFamilyFallback: AppType.fallback,
      extensions: [p],
      dividerTheme: DividerThemeData(color: p.mist, thickness: 1, space: 1),
      focusColor: p.brass.withValues(alpha: 0.25),
      hoverColor: p.forest.withValues(alpha: 0.06),
      splashFactory: NoSplash.splashFactory,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: p.forest,
        selectionColor: p.brass.withValues(alpha: 0.35),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(p.forest),
          foregroundColor: WidgetStatePropertyAll(p.onForest),
          padding: const WidgetStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 22, vertical: 16)),
          shape: const WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: radius)),
          textStyle: const WidgetStatePropertyAll(TextStyle(
              fontFamily: AppType.sans,
              fontFamilyFallback: AppType.fallback,
              fontSize: 15,
              fontWeight: FontWeight.w500)),
          overlayColor: WidgetStatePropertyAll(p.onForest.withValues(alpha: 0.1)),
          side: WidgetStateProperty.resolveWith((s) =>
              s.contains(WidgetState.focused) ? focusRing : BorderSide.none),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(p.ink),
          padding: const WidgetStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 22, vertical: 16)),
          shape: const WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: radius)),
          textStyle: const WidgetStatePropertyAll(TextStyle(
              fontFamily: AppType.sans,
              fontFamilyFallback: AppType.fallback,
              fontSize: 15,
              fontWeight: FontWeight.w500)),
          overlayColor: WidgetStatePropertyAll(p.forest.withValues(alpha: 0.08)),
          side: WidgetStateProperty.resolveWith((s) =>
              s.contains(WidgetState.focused)
                  ? focusRing
                  : BorderSide(color: p.ink.withValues(alpha: 0.6))),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(p.ink),
          shape: const WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: radius)),
          overlayColor: WidgetStatePropertyAll(p.forest.withValues(alpha: 0.08)),
          side: WidgetStateProperty.resolveWith((s) =>
              s.contains(WidgetState.focused) ? focusRing : BorderSide.none),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: p.surface,
        labelStyle: TextStyle(color: p.muted),
        floatingLabelStyle: TextStyle(color: p.forest),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        border: OutlineInputBorder(
            borderRadius: radius, borderSide: BorderSide(color: p.mist)),
        enabledBorder: OutlineInputBorder(
            borderRadius: radius, borderSide: BorderSide(color: p.mist)),
        focusedBorder: OutlineInputBorder(
            borderRadius: radius, borderSide: BorderSide(color: p.forest, width: 2)),
        errorBorder: OutlineInputBorder(
            borderRadius: radius, borderSide: BorderSide(color: p.danger)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: radius, borderSide: BorderSide(color: p.danger, width: 2)),
        errorStyle: TextStyle(color: p.danger, fontSize: 13),
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(color: p.ink, borderRadius: radius),
        textStyle: TextStyle(color: p.paper, fontSize: 13),
      ),
    );
  }
}

/// Max content width and side gutters shared by every section.
class Layout {
  Layout._();

  static const maxWidth = 1120.0;

  static double gutter(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    if (w < 720) return 20;
    if (w < 1080) return 40;
    return 56;
  }

  static bool isCompact(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 720;

  static bool isWide(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 1080;

  /// True when the visitor's system asks for reduced motion.
  static bool reduceMotion(BuildContext context) =>
      MediaQuery.of(context).disableAnimations;
}

/// Centres a section's content and applies the shared gutters.
class SectionFrame extends StatelessWidget {
  const SectionFrame({super.key, required this.child, this.top = 96, this.bottom = 0});

  final Widget child;
  final double top;
  final double bottom;

  @override
  Widget build(BuildContext context) {
    final compact = Layout.isCompact(context);
    return Padding(
      padding: EdgeInsets.only(
        left: Layout.gutter(context),
        right: Layout.gutter(context),
        top: compact ? top * 0.65 : top,
        bottom: bottom,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: Layout.maxWidth),
          child: child,
        ),
      ),
    );
  }
}
