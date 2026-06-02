import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../core/constants/app_strings.dart';
import '../viewmodels/wallet_animation_viewmodel.dart';
import 'animated_fade_slide_wrapper.dart';

class AnimatedCtaButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const AnimatedCtaButton({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color parrotGreen = Color(0xFF388E2C);

    return Selector<WalletAnimationViewModel, bool>(
      selector: (_, viewModel) => viewModel.isAddMoneyVisible,
      builder: (context, isVisible, _) {
        return AnimatedFadeSlideWrapper(
          isVisible: isVisible,
          duration: const Duration(milliseconds: 600),
          startOffset: const Offset(0.0, 0.2),
          curve: Curves.easeOutQuart,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: onPressed ?? () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: parrotGreen,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    elevation: 4.0,
                    shadowColor: parrotGreen.withOpacity(0.3),
                  ),
                  child: Text(
                    AppStrings.addMoney,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14.0),
            ],
          ),
        );
      },
    );
  }
}
