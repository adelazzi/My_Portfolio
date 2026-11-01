import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/app/core/constants/constant_url.dart';
import 'package:my_portfolio/app/core/constants/strings_assets_constants.dart';
import 'package:my_portfolio/app/core/design/palette.dart';
import 'package:my_portfolio/app/modules/contact/controllers/contact_controller.dart';
import 'package:my_portfolio/app/modules/mainpage/views/shared.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final compact = Layout.isCompact(context);
    const direct = _DirectContact();
    const form = _ContactForm();
    return SectionFrame(
      top: 120,
      bottom: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeading(
            title: StringsAssetsConstants.contactTitle,
            intro: StringsAssetsConstants.contactIntro,
          ),
          const SizedBox(height: 40),
          if (compact)
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [direct, SizedBox(height: 48), form],
            )
          else
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 5, child: direct),
                SizedBox(width: 64),
                Expanded(flex: 5, child: form),
              ],
            ),
          const SizedBox(height: 96),
          const _Footer(),
        ],
      ),
    );
  }
}

class _DirectContact extends StatelessWidget {
  const _DirectContact();

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final emailStyle = AppType.h2(context).copyWith(
      fontSize: Layout.isCompact(context) ? 26 : 34,
      color: p.forest,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: AlignmentDirectional.centerStart,
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: InlineLink(
              label: UrlsConstants.email,
              style: emailStyle,
              onTap: () => openUrl('mailto:${UrlsConstants.email}'),
            ),
          ),
        ),
        const SizedBox(height: 12),
        TextButton.icon(
          onPressed: () {
            Clipboard.setData(const ClipboardData(text: UrlsConstants.email));
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text(StringsAssetsConstants.copied),
                behavior: SnackBarBehavior.floating,
                width: 280,
                duration: const Duration(seconds: 2),
              ));
          },
          icon: Icon(Icons.copy_outlined, size: 18, color: p.muted),
          label: Text(StringsAssetsConstants.copyEmail, style: AppType.caption(context).copyWith(color: p.ink)),
        ),
        const SizedBox(height: 36),
        Wrap(
          spacing: 28,
          runSpacing: 12,
          children: [
            InlineLink(label: 'GitHub', onTap: () => openUrl(UrlsConstants.github)),
            InlineLink(label: 'LinkedIn', onTap: () => openUrl(UrlsConstants.linkedin)),
            InlineLink(label: StringsAssetsConstants.downloadCv, onTap: () => openUrl(UrlsConstants.cvUrl)),
          ],
        ),
      ],
    );
  }
}

class _ContactForm extends GetView<ContactController> {
  const _ContactForm();

  static final _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: controller.nameController,
            decoration: InputDecoration(labelText: StringsAssetsConstants.yourName),
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.name],
            onChanged: (_) => controller.clearResult(),
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? StringsAssetsConstants.pleaseEnterName : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: controller.emailController,
            decoration: InputDecoration(labelText: StringsAssetsConstants.yourEmail),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.email],
            onChanged: (_) => controller.clearResult(),
            validator: (v) {
              if (v == null || v.trim().isEmpty) return StringsAssetsConstants.pleaseEnterEmail;
              if (!_emailPattern.hasMatch(v.trim())) return StringsAssetsConstants.pleaseEnterValidEmail;
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: controller.messageController,
            decoration: InputDecoration(
              labelText: StringsAssetsConstants.yourMessage,
              alignLabelWithHint: true,
            ),
            minLines: 5,
            maxLines: 10,
            onChanged: (_) => controller.clearResult(),
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? StringsAssetsConstants.pleaseEnterMessage : null,
          ),
          const SizedBox(height: 20),
          Obx(() {
            final status = controller.status.value;
            final sending = status == SendStatus.sending;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FilledButton(
                  onPressed: sending ? () {} : controller.submitForm,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (sending) ...[
                        SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2, color: p.onForest),
                        ),
                        const SizedBox(width: 10),
                      ],
                      Text(sending ? StringsAssetsConstants.sending : StringsAssetsConstants.sendMessage),
                    ],
                  ),
                ),
                if (status == SendStatus.sent || status == SendStatus.failed) ...[
                  const SizedBox(height: 16),
                  Semantics(
                    liveRegion: true,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          status == SendStatus.sent ? Icons.check_circle_outline : Icons.error_outline,
                          size: 20,
                          color: status == SendStatus.sent ? p.forest : p.danger,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            status == SendStatus.sent
                                ? StringsAssetsConstants.sent
                                : StringsAssetsConstants.sendFailed,
                            style: AppType.body(context).copyWith(
                              color: status == SendStatus.sent ? p.ink : p.danger,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            );
          }),
        ],
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28),
      decoration: BoxDecoration(border: Border(top: BorderSide(color: p.mist))),
      child: Text(
        '© ${DateTime.now().year} ${StringsAssetsConstants.fullName}. ${StringsAssetsConstants.footer}',
        style: AppType.caption(context),
      ),
    );
  }
}
