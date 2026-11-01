import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/app/core/constants/strings_assets_constants.dart';
import 'package:my_portfolio/app/core/design/palette.dart';
import 'package:my_portfolio/app/data/career_repository.dart';
import 'package:my_portfolio/app/modules/mainpage/views/shared.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final compact = Layout.isCompact(context);
    final text = ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 640),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final para in StringsAssetsConstants.aboutMe.split('\n\n'))
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(para.trim(), style: AppType.body(context).copyWith(fontSize: 17)),
            ),
        ],
      ),
    );

    return SectionFrame(
      top: 120,
      child: Obx(() {
        final photoPath = CareerRepository.to.data.value.photo;
        final photo = photoPath == null
            ? null
            : ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: AspectRatio(
                  aspectRatio: 4 / 5,
                  child: Semantics(
                    image: true,
                    label: StringsAssetsConstants.fullName,
                    child: AssetPicture(photoPath, cacheWidth: 900),
                  ),
                ),
              );
        final heading = SectionHeading(title: StringsAssetsConstants.aboutTitle);

        if (compact) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heading,
              const SizedBox(height: 20),
              if (photo != null) ...[
                SizedBox(width: 220, child: photo),
                const SizedBox(height: 24),
              ],
              text,
            ],
          );
        }
        // The heading sits in a side column, like a margin note, with the
        // portrait under it when there is one.
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: Layout.isWide(context) ? 320 : 240,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  heading,
                  if (photo != null) ...[const SizedBox(height: 28), photo],
                ],
              ),
            ),
            const SizedBox(width: 56),
            Expanded(
              child: Padding(padding: const EdgeInsets.only(top: 6), child: text),
            ),
          ],
        );
      }),
    );
  }
}
