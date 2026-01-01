import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/app/core/styles/colors.dart';
import 'package:my_portfolio/app/core/styles/text_styles.dart';
import 'package:my_portfolio/app/modules/loading/controllers/loading_controller.dart';

class LoadingView extends GetView<LoadingController> {
  LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'loading',
          style: TextStyles.labelLarge(context)
              .copyWith(color: MainColors.primaryColor(context)),
        ),
      ),
      body: Center(
        child: Text('This is the Loading page.'),
      ),
    );
  }
}
