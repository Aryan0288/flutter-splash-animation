import 'package:blinkit_money_wallet/core/constants/app_strings.dart';
import 'package:blinkit_money_wallet/presentation/wallet/viewmodels/wallet_animation_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'animated_fade_slide_wrapper.dart';
import 'animated_feature_card.dart';

class GiftCardSection extends StatelessWidget {
  final VoidCallback? onTap;

  const GiftCardSection({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<WalletAnimationViewModel, bool>(
      selector: (_, viewModel) => viewModel.isClaimGiftVisible,
      builder: (context, isVisible, _) {
        return AnimatedFadeSlideWrapper(
          isVisible: isVisible,
          duration: const Duration(milliseconds: 600),
          startOffset: const Offset(
            0.0,
            0.2,
          ), // Matches standard bottom reveal rising offset
          curve: Curves.easeOutQuart,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AnimatedFeatureCard(
                imagePath: 'assets/images/png/claim_gift_card.png',
                title: AppStrings.claimGiftCard,
                subtitle: AppStrings.claimGiftCardSubtitle,
                onTap: onTap,
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Color(
                    0xFF6E727E,
                  ), // Polished chevron matching reference design
                  size: 14.0,
                ),
              ),
              const SizedBox(height: 32.0),
            ],
          ),
        );
      },
    );
  }
}
