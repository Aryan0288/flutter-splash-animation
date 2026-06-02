import 'package:blinkit_money_wallet/presentation/wallet/viewmodels/wallet_animation_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'animated_fade_slide_wrapper.dart';
import 'confetti_overlay_widget.dart';


class WalletHeaderWidget extends StatelessWidget {
  const WalletHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    final double centeredTop =
        ((screenHeight - 95.0) / 2) - (screenHeight * 0.10);
    final double middleTop = centeredTop - 30.0;
    const double finalTop = 36.0;

    
    return Selector<WalletAnimationViewModel, (bool, bool, bool, bool)>(
      selector: (_, viewModel) => (
        viewModel.logoMovedToMiddle,
        viewModel.logoMovedToFinal,
        viewModel.isBlinkitVisible,
        viewModel.isMoneyVisible,
      ),
      builder: (context, states, _) {
        final bool logoMovedToMiddle = states.$1;
        final bool logoMovedToFinal = states.$2;
        final bool isBlinkitVisible = states.$3;
        final bool isMoneyVisible = states.$4;

        // Determine current top header offset
        final double logoTop;
        if (logoMovedToFinal) {
          logoTop = finalTop;
        } else if (logoMovedToMiddle) {
          logoTop = middleTop;
        } else {
          logoTop = centeredTop;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [

            AnimatedContainer(
              duration: logoMovedToFinal
                  ? const Duration(milliseconds: 1400) // Elegant final move
                  : const Duration(milliseconds: 1000), // Soft first step
              curve: Curves.easeInOutCubic,
              height: logoTop,
            ),

            // Cinematic Branding Header Column
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  alignment: Alignment.center,
                  clipBehavior:
                      Clip.none, 
                  children: [
                    AnimatedFadeSlideWrapper(
                      isVisible:
                          true, // Instantly starts animation on screen build
                      duration: const Duration(
                        milliseconds: 2400,
                      ), // Premium subtle timing
                      startOffset: const Offset(
                        0.0,
                        -8.0, 
                      ),
                      curve: Curves.easeOutQuart, 
                      child: Image.asset(
                        'assets/images/png/wallet_png.png',
                        height: 80,
                        width: 80,
                      ),
                    ),

                    const ConfettiOverlayWidget(),
                  ],
                ),

                if (isBlinkitVisible || isMoneyVisible)
                  const SizedBox(height: 12.0),

                // Staggered "blinkit" logo
                AnimatedFadeSlideWrapper(
                  isVisible: isBlinkitVisible,
                  duration: const Duration(milliseconds: 750),
                  curve: Curves.easeOutQuart,
                  child: Text(
                    'blinkit',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 28.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: -1.5,
                    ),
                  ),
                ),

                // Staggered "Money" subtitle
                AnimatedFadeSlideWrapper(
                  isVisible: isMoneyVisible,
                  duration: const Duration(milliseconds: 750),
                  curve: Curves.easeOutQuart,
                  child: Text(
                    'Money',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 40.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
