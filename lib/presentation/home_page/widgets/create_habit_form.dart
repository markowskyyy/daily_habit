import 'package:daily_habit/domain/enums/habit_icon.dart';
import 'package:daily_habit/presentation/home_page/widgets/habit_name_field.dart';
import 'package:daily_habit/presentation/home_page/widgets/icon_selector_section.dart';
import 'package:flutter/material.dart';
import 'color_selector_section.dart';
import 'submit_button.dart';

class CreateHabitForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final HabitIcon selectedIcon;
  final String selectedColor;
  final String? Function(String?) validator;
  final List<HabitIcon> availableIcons;
  final List<String> availableColors;
  final ValueChanged<HabitIcon> onIconSelected;
  final ValueChanged<String> onColorSelected;
  final VoidCallback onSubmit;

  const CreateHabitForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.selectedIcon,
    required this.selectedColor,
    required this.validator,
    required this.availableIcons,
    required this.availableColors,
    required this.onIconSelected,
    required this.onColorSelected,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HabitNameField(
              controller: nameController,
              validator: validator,
            ),
            const SizedBox(height: 32),
            IconSelectorSection(
              icons: availableIcons,
              selectedIcon: selectedIcon,
              selectedColor: selectedColor,
              onIconSelected: onIconSelected,
            ),
            const SizedBox(height: 32),
            ColorSelectorSection(
              colors: availableColors,
              selectedColor: selectedColor,
              onColorSelected: onColorSelected,
            ),
            const SizedBox(height: 48),
            SubmitButton(onSubmit: onSubmit),
          ],
        ),
      ),
    );
  }
}