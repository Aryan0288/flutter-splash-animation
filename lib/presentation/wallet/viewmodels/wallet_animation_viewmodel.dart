import 'dart:async';
import 'package:blinkit_money_wallet/core/constants/animation_constants.dart';
import 'package:flutter/foundation.dart';

/// WalletAnimationViewModel orchestrates the sequential staged timeline events
/// and visibility flags for the wallet landing page view.
class WalletAnimationViewModel extends ChangeNotifier {
  // Staged visibility flags
  bool _isBlinkitVisible = false;
  bool _isMoneyVisible = false;
  bool _isFeature1Visible = false;
  bool _isFeature2Visible = false;
  bool _isFeature3Visible = false;
  bool _isAddMoneyVisible = false;
  bool _isClaimGiftVisible = false;
  bool _isFooterVisible = false;

  // Header position stages
  bool _logoMovedToMiddle = false;
  bool _logoMovedToFinal = false;

  // Confetti overlay lifecycle - instantly active on screen load
  double _confettiOpacity = 1.0;
  bool _isConfettiActive = true; 

  // Active timers tracking list for clean disposal
  final List<Timer> _timers = [];

  bool _isCelebrationStarted = true;

  // Getters
  bool get isBlinkitVisible => _isBlinkitVisible;
  bool get isMoneyVisible => _isMoneyVisible;
  bool get isFeature1Visible => _isFeature1Visible;
  bool get isFeature2Visible => _isFeature2Visible;
  bool get isFeature3Visible => _isFeature3Visible;
  bool get isAddMoneyVisible => _isAddMoneyVisible;
  bool get isClaimGiftVisible => _isClaimGiftVisible;
  bool get isFooterVisible => _isFooterVisible;

  bool get logoMovedToMiddle => _logoMovedToMiddle;
  bool get logoMovedToFinal => _logoMovedToFinal;

  double get confettiOpacity => _confettiOpacity;
  bool get isConfettiActive => _isConfettiActive;
  bool get isCelebrationStarted => _isCelebrationStarted;

  WalletAnimationViewModel() {
    // Start the sequential staged animation timers instantly on load
    _triggerSequentialTimers();
  }

  /// Starts the animation celebration sequence once the wallet icon has fully loaded.
  void startCelebration() {
    if (_isCelebrationStarted) return;
    _isCelebrationStarted = true;
    _isConfettiActive = true;
    _confettiOpacity = 1.0;
    notifyListeners();

    _triggerSequentialTimers();
  }

  /// Triggers the entire sequential staged animation sequence driven by AnimationConstants.
  void _triggerSequentialTimers() {
    // 1. Confetti starts fading out
    _timers.add(Timer(AnimationConstants.confettiOpacityDelay, () {
      _confettiOpacity = 0.0;
      notifyListeners();
    }));

    // 2. Confetti overlay gets unmounted completely
    _timers.add(Timer(AnimationConstants.confettiUnmountDelay, () {
      _isConfettiActive = false;
      notifyListeners();
    }));

    // 3. Stage 2: Logo moves to middle position and 'blinkit' text is revealed
    _timers.add(Timer(AnimationConstants.logoShift1Delay, () {
      _logoMovedToMiddle = true;
      _isBlinkitVisible = true;
      notifyListeners();
    }));

    // 4. Stage 3: 'Money' subtitle text is revealed
    _timers.add(Timer(AnimationConstants.moneyDelay, () {
      _isMoneyVisible = true;
      notifyListeners();
    }));

    // 5. Stage 4: Feature Card 1 is revealed & Logo shifts to final top header
    _timers.add(Timer(AnimationConstants.card1Delay, () {
      _logoMovedToFinal = true;
      _isFeature1Visible = true;
      notifyListeners();
    }));

    // 6. Stage 4 Stagger: Feature Card 2 is revealed
    _timers.add(Timer(AnimationConstants.card2Delay, () {
      _isFeature2Visible = true;
      notifyListeners();
    }));

    // 7. Stage 4 Stagger: Feature Card 3 is revealed
    _timers.add(Timer(AnimationConstants.card3Delay, () {
      _isFeature3Visible = true;
      notifyListeners();
    }));

    // 8. Stage 5: Add Money CTA button is revealed
    _timers.add(Timer(AnimationConstants.ctaDelay, () {
      _isAddMoneyVisible = true;
      notifyListeners();
    }));

    // 9. Stage 5 Stagger: Claim Gift Card container is revealed
    _timers.add(Timer(AnimationConstants.giftCardDelay, () {
      _isClaimGiftVisible = true;
      notifyListeners();
    }));

    // 10. Stage 5 Stagger: Footer copyright text is revealed
    _timers.add(Timer(AnimationConstants.footerDelay, () {
      _isFooterVisible = true;
      notifyListeners();
    }));
  }

  @override
  void dispose() {
    // Prevent memory leaks by cleaning up all registered timers on unmount
    for (final timer in _timers) {
      timer.cancel();
    }
    super.dispose();
  }
}
