import 'package:blinkit_money_wallet/presentation/wallet/viewmodels/wallet_animation_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'animated_fade_slide_wrapper.dart';


class WalletFooterWidget extends StatelessWidget {
  const WalletFooterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<WalletAnimationViewModel, bool>(
      selector: (_, viewModel) => viewModel.isFooterVisible,
      builder: (context, isVisible, _) {
        return AnimatedFadeSlideWrapper(
          isVisible: isVisible,
          duration: const Duration(milliseconds: 600),
          startOffset: const Offset(0.0, 0.2),
          curve: Curves.easeOutQuart,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  'Enjoy seamless\none tap payments',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 28.0, 
                    fontWeight: FontWeight.w700,
                    color: const Color(
                      0xFF6E727E,
                    ), 
                    height: 1.3,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
            ],
          ),
        );
      },
    );
  }
}
