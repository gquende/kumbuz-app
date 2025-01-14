import 'package:flutter/material.dart';
import 'package:kumbuz/configs/config.dart';
import 'package:kumbuz/features/sateva/presenter/viewmodels/startup_view_model.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'stack';
import 'package:stacked/stacked.dart';

import '../../../../../configs/environments/environments.dart';

class StartView extends StatelessWidget {
  const StartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ViewModelBuilder<StartUpViewModel>.reactive(
          viewModelBuilder: () => StartUpViewModel(),
          onViewModelReady: (viewModel) => viewModel.handleStartUpLogic(),
          builder: (context, viewModel, child) {
            return Scaffold(
              body: SafeArea(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 140,
                        height: 140,
                        child: Image.asset(AppEnvironment.env == Environment.dev
                            ? AppFiles.LOGO
                            : AppFiles.LOGO2),
                      ),
                      const SizedBox(height: 20),
                      AppEnvironment.env == Environment.dev
                          ? LoadingAnimationWidget.staggeredDotsWave(
                              color: AppColors.primaryColor, size: 50)
                          : LoadingAnimationWidget.fourRotatingDots(
                              color: AppColors.primaryColor, size: 60),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
