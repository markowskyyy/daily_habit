import 'package:daily_habit/core/consts/design.dart';
import 'package:flutter/material.dart';

class HabitNameField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?) validator;

  const HabitNameField({
    super.key,
    required this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Название привычки', style: AppTextStyles.formLabel),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          style: AppTextStyles.formInput,
          decoration: InputDecoration(
            hintText: 'Например читать 20 минут',
            hintStyle: AppTextStyles.formHint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: AppColors.white,
            contentPadding: const EdgeInsets.all(16),
          ),
          validator: validator,
          autofocus: true,
        ),
      ],
    );
  }
}