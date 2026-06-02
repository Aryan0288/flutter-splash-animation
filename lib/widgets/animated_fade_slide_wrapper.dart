import 'package:flutter/material.dart';

/// AnimatedFadeSlideWrapper acts as a standardized presentation-layer wrapper,
/// providing high-fidelity fade and slide stagger effects driven by a custom curve.
class AnimatedFadeSlideWrapper extends StatefulWidget {
  final Widget child;
  final bool isVisible;
  final Duration delay;
  final Duration duration;
  final Offset startOffset;
  final Curve curve;

  const AnimatedFadeSlideWrapper({
    Key? key,
    required this.child,
    required this.isVisible,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 600),
    this.startOffset = const Offset(0.0, 0.25),
    this.curve = Curves.easeOutCubic,
  }) : super(key: key);

  @override
  State<AnimatedFadeSlideWrapper> createState() =>
      _AnimatedFadeSlideWrapperState();
}

class _AnimatedFadeSlideWrapperState extends State<AnimatedFadeSlideWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _hasStarted = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    final curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(curvedAnimation);
    _slideAnimation = Tween<Offset>(
      begin: widget.startOffset,
      end: Offset.zero,
    ).animate(curvedAnimation);

    if (widget.isVisible) {
      _startAnimation();
    }
  }

  void _startAnimation() {
    _hasStarted = true;
    if (widget.delay == Duration.zero) {
      _controller.forward();
    } else {
      Future.delayed(widget.delay, () {
        if (mounted) {
          _controller.forward();
        }
      });
    }
  }

  @override
  void didUpdateWidget(covariant AnimatedFadeSlideWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible && !_hasStarted) {
      _startAnimation();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isVisible && !_hasStarted) {
      return const SizedBox.shrink();
    }
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(position: _slideAnimation, child: widget.child),
    );
  }
}
