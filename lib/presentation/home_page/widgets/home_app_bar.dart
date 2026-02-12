import 'package:daily_habit/core/consts/design.dart';
import 'package:flutter/material.dart';


class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String formattedDate;
  final String pageTitle;
  final bool showTodayButton;
  final VoidCallback onTodayPressed;

  const HomeAppBar({
    super.key,
    required this.formattedDate,
    required this.pageTitle,
    required this.showTodayButton,
    required this.onTodayPressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            formattedDate,
            style: AppTextStyles.statLabel.copyWith(
              fontSize: 14,
              color: AppColors.greyText,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            pageTitle,
            style: AppTextStyles.screenTitle,
          ),
        ],
      ),
      actions: [
        if (showTodayButton)
          IconButton(
            icon: const Icon(Icons.today_outlined),
            color: AppColors.green,
            onPressed: onTodayPressed,
          ),
      ],
    );
  }
}