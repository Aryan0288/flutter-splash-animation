import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class AnimatedFeatureCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final Widget? trailing;
  final VoidCallback? onTap;

  const AnimatedFeatureCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    this.trailing,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Premium dark charcoal container representation
    final Widget cardContent = Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
      decoration: BoxDecoration(
        color: const Color(
          0xFF2C2C2E,
        ), // Precise Blinkit dark grey card background
        borderRadius: BorderRadius.circular(20.0), // Elegant high-radius curves
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center, // Centered vertically
        children: [
          // 1. Visual Solid Black Separated Inner Icon Box
          Container(
            width: 56.0,
            height: 56.0,
            decoration: BoxDecoration(
              color: const Color(0xFF111111), // Pure black inner background
              borderRadius: BorderRadius.circular(
                14.0,
              ), // High-fidelity visual separation
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14.0),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(
                    10.0,
                  ), // Balanced aspect-ratio padding
                  child: Image.asset(imagePath, fit: BoxFit.contain),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16.0),

          // 2. Right Text Metadata Block
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: 16.0,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  subtitle,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12.5,
                    height: 1.35,
                    color: const Color(
                      0xFF9E9E9E,
                    ), // Lighter muted visual text weight
                  ),
                ),
              ],
            ),
          ),

          // 3. Optional Trailing Navigation Chevron
          if (trailing != null) ...[const SizedBox(width: 12.0), trailing!],
        ],
      ),
    );

    // Ink-ripple wrapper only if click actions are registered
    if (onTap != null) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 7.0),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(20.0),
            splashColor: Colors.white.withOpacity(0.06),
            highlightColor: Colors.white.withOpacity(0.03),
            child: cardContent,
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: cardContent,
    );
  }
}
