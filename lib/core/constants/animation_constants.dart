/// AnimationConstants houses all presentation and staged timings
/// for the digital wallet landing page to ensure zero inline magic numbers.
class AnimationConstants {
  AnimationConstants._();

  // Header and branding migration delays
  static const Duration logoShift1Delay = Duration(milliseconds: 3000);
  static const Duration moneyDelay = Duration(milliseconds: 3700);

  // Staggered value proposition card delays
  static const Duration card1Delay = Duration(milliseconds: 6000);
  static const Duration card2Delay = Duration(milliseconds: 6500);
  static const Duration card3Delay = Duration(milliseconds: 7000);

  // Staggered top-up triggers and copyright delays
  static const Duration ctaDelay = Duration(milliseconds: 8000);
  static const Duration giftCardDelay = Duration(milliseconds: 8250);
  static const Duration footerDelay = Duration(milliseconds: 8500);

  // Confetti overlay visual timings
  static const Duration confettiOpacityDuration = Duration(milliseconds: 6000);
  static const Duration confettiOpacityDelay = Duration(milliseconds: 6000);
  static const Duration confettiUnmountDelay = Duration(milliseconds: 6000);
}
