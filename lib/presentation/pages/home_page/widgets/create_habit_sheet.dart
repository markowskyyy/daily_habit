import 'package:daily_habit/core/consts/design.dart';
import 'package:daily_habit/domain/enums/habit_icon.dart';
import 'package:flutter/material.dart';

class CreateHabitSheet extends StatefulWidget {
  final List<HabitIcon> availableIcons;
  final List<String> availableColors;
  final String? Function(String?) validator;
  final void Function(String name, HabitIcon icon, String color) onCreate;

  const CreateHabitSheet({
    super.key,
    required this.availableIcons,
    required this.availableColors,
    required this.validator,
    required this.onCreate,
  });

  @override
  State<CreateHabitSheet> createState() => _CreateHabitSheetState();
}

class _CreateHabitSheetState extends State<CreateHabitSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  late HabitIcon _selectedIcon;
  late String _selectedColor;

  @override
  void initState() {
    super.initState();
    _selectedIcon = widget.availableIcons.first;
    _selectedColor = widget.availableColors.first;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _SheetHandle(),
              const SizedBox(height: 20),
              const _SheetTitle(),
              const SizedBox(height: 24),
              _HabitNameField(
                controller: _nameController,
                validator: widget.validator,
              ),
              const SizedBox(height: 24),
              _IconSelector(
                icons: widget.availableIcons,
                selectedIcon: _selectedIcon,
                selectedColor: _selectedColor,
                onIconSelected: (icon) => setState(() => _selectedIcon = icon),
              ),
              const SizedBox(height: 24),
              _ColorSelector(
                colors: widget.availableColors,
                selectedColor: _selectedColor,
                onColorSelected: (color) => setState(() => _selectedColor = color),
              ),
              const SizedBox(height: 32),
              _SheetActions(
                onSubmit: _handleSubmit,
                onCancel: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      widget.onCreate(
        _nameController.text.trim(),
        _selectedIcon,
        _selectedColor,
      );
      Navigator.pop(context);
    }
  }
}

class _SheetHandle extends StatelessWidget {
  const _SheetHandle();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: AppColors.lightGrey,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}

class _SheetTitle extends StatelessWidget {
  const _SheetTitle();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Новая привычка',
      style: AppTextStyles.screenTitle,
    );
  }
}

class _HabitNameField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?) validator;

  const _HabitNameField({
    required this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Привычка', style: AppTextStyles.formLabel),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          style: AppTextStyles.formInput,
          decoration: InputDecoration(
            hintText: 'e.g. Read 20 mins',
            hintStyle: AppTextStyles.formHint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: AppColors.lightGrey,
            contentPadding: const EdgeInsets.all(16),
          ),
          validator: validator,
          autofocus: true,
        ),
      ],
    );
  }
}

class _IconSelector extends StatelessWidget {
  final List<HabitIcon> icons;
  final HabitIcon selectedIcon;
  final String selectedColor;
  final ValueChanged<HabitIcon> onIconSelected;

  const _IconSelector({
    required this.icons,
    required this.selectedIcon,
    required this.selectedColor,
    required this.onIconSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Занятие', style: AppTextStyles.formLabel),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: icons.map((icon) {
            return _IconItem(
              icon: icon,
              isSelected: icon == selectedIcon,
              selectedColor: selectedColor,
              onTap: () => onIconSelected(icon),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _IconItem extends StatelessWidget {
  final HabitIcon icon;
  final bool isSelected;
  final String selectedColor;
  final VoidCallback onTap;

  const _IconItem({
    required this.icon,
    required this.isSelected,
    required this.selectedColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = _getColorFromHex(selectedColor);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : AppColors.lightGrey,
          borderRadius: BorderRadius.circular(12),
          border: isSelected ? Border.all(color: color, width: 2) : null,
        ),
        child: Icon(
          _getIconData(icon),
          color: isSelected ? color : AppColors.grey,
          size: 28,
        ),
      ),
    );
  }

  Color _getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexColor', radix: 16));
  }

  IconData _getIconData(HabitIcon icon) {
    switch (icon) {
      case HabitIcon.yoga: return Icons.self_improvement;
      case HabitIcon.book: return Icons.menu_book;
      case HabitIcon.water: return Icons.water_drop;
      case HabitIcon.meditation: return Icons.self_improvement;
      case HabitIcon.workout: return Icons.fitness_center;
      case HabitIcon.running: return Icons.directions_run;
      case HabitIcon.sleep: return Icons.night_shelter;
      case HabitIcon.healthyFood: return Icons.restaurant;
    }
  }
}

class _ColorSelector extends StatelessWidget {
  final List<String> colors;
  final String selectedColor;
  final ValueChanged<String> onColorSelected;

  const _ColorSelector({
    required this.colors,
    required this.selectedColor,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Выберите цвет', style: AppTextStyles.formLabel),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: colors.map((hexColor) {
            return _ColorItem(
              hexColor: hexColor,
              isSelected: hexColor == selectedColor,
              onTap: () => onColorSelected(hexColor),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _ColorItem extends StatelessWidget {
  final String hexColor;
  final bool isSelected;
  final VoidCallback onTap;

  const _ColorItem({
    required this.hexColor,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = _getColorFromHex(hexColor);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: isSelected
              ? Border.all(color: AppColors.darkText, width: 3)
              : null,
        ),
        child: isSelected
            ? const Center(
          child: Icon(Icons.check, color: Colors.white, size: 24),
        )
            : null,
      ),
    );
  }

  Color _getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexColor', radix: 16));
  }
}

class _SheetActions extends StatelessWidget {
  final VoidCallback onSubmit;
  final VoidCallback onCancel;

  const _SheetActions({
    required this.onSubmit,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onCancel,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: const BorderSide(color: AppColors.lightGrey),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text('Отмена', style: AppTextStyles.buttonLight),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: onSubmit,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.green,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text('Создать привычку', style: AppTextStyles.buttonText),
          ),
        ),
      ],
    );
  }
}