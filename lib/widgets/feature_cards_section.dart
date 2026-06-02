import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constants/app_strings.dart';
import '../viewmodels/wallet_animation_viewmodel.dart';
import 'animated_fade_slide_wrapper.dart';
import 'animated_feature_card.dart';

/// FeatureCardsSection builds the list of premium value proposition cards,
/// stagger-mounting them driven by separate selectors.
class FeatureCardsSection extends StatelessWidget {
  const FeatureCardsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Granular Selector for Feature Card 1
        Selector<WalletAnimationViewModel, bool>(
          selector: (_, viewModel) => viewModel.isFeature1Visible,
          builder: (context, isVisible, _) {
            return AnimatedFadeSlideWrapper(
              isVisible: isVisible,
              duration: const Duration(milliseconds: 900),
              startOffset: const Offset(0.0, 0.3),
              curve: Curves.easeOutQuart,
              child: const AnimatedFeatureCard(
                imagePath: 'assets/images/png/single_tap_payment.png',
                title: AppStrings.feature1Title,
                subtitle: AppStrings.feature1Subtitle,
              ),
            );
          },
        ),

        // Granular Selector for Feature Card 2
        Selector<WalletAnimationViewModel, bool>(
          selector: (_, viewModel) => viewModel.isFeature2Visible,
          builder: (context, isVisible, _) {
            return AnimatedFadeSlideWrapper(
              isVisible: isVisible,
              duration: const Duration(milliseconds: 900),
              startOffset: const Offset(0.0, 0.3),
              curve: Curves.easeOutQuart,
              child: const AnimatedFeatureCard(
                imagePath: 'assets/images/png/zero_failure.png',
                title: AppStrings.feature2Title,
                subtitle: AppStrings.feature2Subtitle,
              ),
            );
          },
        ),

        // Granular Selector for Feature Card 3
        Selector<WalletAnimationViewModel, bool>(
          selector: (_, viewModel) => viewModel.isFeature3Visible,
          builder: (context, isVisible, _) {
            return AnimatedFadeSlideWrapper(
              isVisible: isVisible,
              duration: const Duration(milliseconds: 900),
              startOffset: const Offset(0.0, 0.3),
              curve: Curves.easeOutQuart,
              child: const AnimatedFeatureCard(
                imagePath: 'assets/images/png/real_time_refund.png',
                title: AppStrings.feature3Title,
                subtitle: AppStrings.feature3Subtitle,
              ),
            );
          },
        ),
      ],
    );
  }
}
