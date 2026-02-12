import 'package:daily_habit/core/consts/design.dart';
import 'package:flutter/material.dart';


class DateNavigationBar extends StatelessWidget {
  final String weekday;
  final String dateShort;
  final bool canGoPrevious;
  final bool canGoNext;
  final VoidCallback onPreviousPressed;
  final VoidCallback onNextPressed;

  const DateNavigationBar({
    super.key,
    required this.weekday,
    required this.dateShort,
    required this.canGoPrevious,
    required this.canGoNext,
    required this.onPreviousPressed,
    required this.onNextPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _PreviousDayButton(
            enabled: canGoPrevious,
            onPressed: onPreviousPressed,
          ),
          _DateDisplay(
            weekday: weekday,
            dateShort: dateShort,
          ),
          _NextDayButton(
            enabled: canGoNext,
            onPressed: onNextPressed,
          ),
        ],
      ),
    );
  }
}

class _PreviousDayButton extends StatelessWidget {
  final bool enabled;
  final VoidCallback onPressed;

  const _PreviousDayButton({
    required this.enabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.chevron_left),
      color: enabled ? AppColors.darkText : AppColors.grey,
      onPressed: enabled ? onPressed : null,
    );
  }
}

class _NextDayButton extends StatelessWidget {
  final bool enabled;
  final VoidCallback onPressed;

  const _NextDayButton({
    required this.enabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.chevron_right),
      color: enabled ? AppColors.darkText : AppColors.grey,
      onPressed: enabled ? onPressed : null,
    );
  }
}

class _DateDisplay extends StatelessWidget {
  final String weekday;
  final String dateShort;

  const _DateDisplay({
    required this.weekday,
    required this.dateShort,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          weekday,
          style: AppTextStyles.screenTitle,
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.lightGrey,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            dateShort,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.darkText,
            ),
          ),
        ),
      ],
    );
  }
}