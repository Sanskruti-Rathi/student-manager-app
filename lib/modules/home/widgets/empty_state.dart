import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_assets.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Lottie with fallback animation using flutter_animate
          Lottie.network(
            AppAssets.emptyStateLottieUrl,
            height: 180,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              // High-fidelity fallback illustration built entirely in Flutter
              return Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.darkBorder.withOpacity(0.4)
                      : AppColors.primary.withOpacity(0.06),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isDark
                        ? AppColors.accent.withOpacity(0.2)
                        : AppColors.primary.withOpacity(0.1),
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.school_outlined,
                  size: 56,
                  color: isDark ? AppColors.accent : AppColors.primary,
                ),
              )
              .animate(onPlay: (controller) => controller.repeat(reverse: true))
              .scale(
                begin: const Offset(1, 1),
                end: const Offset(1.08, 1.08),
                duration: 1500.ms,
                curve: Curves.easeInOut,
              )
              .shimmer(
                delay: 1000.ms,
                duration: 1200.ms,
                color: isDark
                    ? AppColors.accent.withOpacity(0.25)
                    : AppColors.primary.withOpacity(0.2),
              );
            },
            frameBuilder: (context, child, composition) {
              if (composition == null) {
                return const SizedBox(
                  height: 180,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return child;
            },
          ),
          const SizedBox(height: 24),
          Text(
            AppStrings.emptyStateTitle,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.darkText : AppColors.lightText,
            ),
          ).animate().fade(duration: 400.ms).slideY(begin: 0.15, end: 0),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Text(
              AppStrings.emptyStateSub,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                height: 1.4,
              ),
            ),
          ).animate().fade(delay: 200.ms, duration: 400.ms).slideY(begin: 0.15, end: 0),
        ],
      ),
    );
  }
}
