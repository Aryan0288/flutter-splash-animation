import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../core/constants/app_strings.dart';
import '../core/theme/app_colors.dart';
import '../viewmodels/wallet_animation_viewmodel.dart';
import '../viewmodels/wallet_viewmodel.dart';
import '../widgets/animated_cta_button.dart';
import '../widgets/feature_cards_section.dart';
import '../widgets/gift_card_section.dart';
import '../widgets/wallet_footer_widget.dart';
import '../widgets/wallet_header_widget.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(
        const AssetImage('assets/images/gif/confetti.gif'),
        context,
      );
      precacheImage(const AssetImage('assets/images/gif/wallet.gif'), context);
      context.read<WalletViewModel>().loadWalletData();
    });
  }

  void _handleAlerts(BuildContext context, WalletViewModel viewModel) {
    if (viewModel.successAlert != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle_rounded, color: Colors.white),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Text(
                    viewModel.successAlert!,
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: AppColors.successGreen,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        );
        viewModel.clearAlerts();
      });
    }

    if (viewModel.errorAlert != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error_outline_rounded, color: Colors.white),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Text(
                    viewModel.errorAlert!,
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: AppColors.errorRed,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        );
        viewModel.clearAlerts();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final walletViewModel = context.watch<WalletViewModel>();

    // Trigger alert snackbar handler
    _handleAlerts(context, walletViewModel);

    return ChangeNotifierProvider<WalletAnimationViewModel>(
      create: (_) => WalletAnimationViewModel(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: const Color(
              0xFF121214,
            ), // Solid dark charcoal canvas background
            body: Stack(
              children: [
                // 1. Beautiful Halftone Golden Gradient Background
                const Positioned.fill(
                  child: CustomPaint(painter: HalftonePainter()),
                ),

                // 2. Scrollable Body
                Positioned.fill(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Staged migrating header containing logo stack & text branding
                        const WalletHeaderWidget(),

                        // Stiff Spacer when cards start to mount
                        Selector<WalletAnimationViewModel, bool>(
                          selector: (_, viewModel) =>
                              viewModel.isFeature1Visible,
                          builder: (context, isVisible, _) {
                            return SizedBox(height: isVisible ? 24.0 : 0.0);
                          },
                        ),

                        // Staggered value proposition card stack section
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: FeatureCardsSection(),
                        ),

                        // Stiff Spacer when bottom triggers start to mount
                        Selector<WalletAnimationViewModel, bool>(
                          selector: (_, viewModel) =>
                              viewModel.isAddMoneyVisible,
                          builder: (context, isVisible, _) {
                            return SizedBox(height: isVisible ? 28.0 : 0.0);
                          },
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              AnimatedCtaButton(),
                              GiftCardSection(),
                              const WalletFooterWidget(),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24.0),
                      ],
                    ),
                  ),
                ),

                if (walletViewModel.isProcessingAction)
                  const _ProcessingOverlay(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class HalftonePainter extends CustomPainter {
  const HalftonePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final Paint bgPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF28210A), Color(0xFF1C1A14), Color(0xFF121214)],
        stops: [0.0, 0.20, 0.45],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(rect);
    canvas.drawRect(rect, bgPaint);

    final Paint dotPaint = Paint()..style = PaintingStyle.fill;
    const double spacing = 18.0;
    final int rows = (size.height * 0.28 / spacing).ceil();
    final int cols = (size.width / spacing).ceil() + 1;

    for (int r = 0; r < rows; r++) {
      final double y = r * spacing + 12.0;
      final double progress = y / (size.height * 0.28);
      if (progress >= 1.0) continue;

      final double opacity = math.max(0.0, 0.22 * (1.0 - progress));
      final double radius = math.max(0.5, 2.5 * (1.0 - progress));

      dotPaint.color = AppColors.blinkitYellow.withOpacity(opacity);
      final double xOffset = (r % 2 == 1) ? spacing / 2 : 0.0;

      for (int c = 0; c < cols; c++) {
        final double x = c * spacing + xOffset;
        if (x <= size.width) {
          canvas.drawCircle(Offset(x, y), radius, dotPaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ProcessingOverlay extends StatelessWidget {
  const _ProcessingOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<WalletViewModel>();

    return Container(
      color: Colors.black.withOpacity(0.65),
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 32.0),
          padding: const EdgeInsets.all(28.0),
          decoration: BoxDecoration(
            color: const Color(0xFF181A20),
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: const Color(0xFF2C2F3A), width: 1.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black38,
                blurRadius: 20.0,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(
                color: AppColors.walletGreen,
                strokeWidth: 4.0,
              ),
              const SizedBox(height: 24.0),
              Text(
                viewModel.statusMessage ?? AppStrings.processing,
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
