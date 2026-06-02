import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/wallet_animation_viewmodel.dart';

class ConfettiOverlayWidget extends StatelessWidget {
  const ConfettiOverlayWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Highly targeted Selector observing only confetti visibility and opacity state
    return Selector<WalletAnimationViewModel, (bool, double)>(
      selector: (_, viewModel) =>
          (viewModel.isConfettiActive, viewModel.confettiOpacity),
      builder: (context, data, _) {
        final bool isConfettiActive = data.$1;
        final double confettiOpacity = data.$2;

        if (!isConfettiActive) {
          return const SizedBox.shrink();
        }

        return Positioned(
          top: -180,
          left: -150,
          right: -150,
          bottom: -100,
          child: IgnorePointer(
            child: AnimatedOpacity(
              opacity: confettiOpacity,
              duration: const Duration(
                milliseconds: 8000,
              ),
              curve: Curves.easeOut,
              child: Image.asset(
                'assets/images/gif/confetti.gif',
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
  }
}
