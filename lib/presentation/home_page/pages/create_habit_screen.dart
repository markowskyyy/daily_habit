import 'package:daily_habit/core/consts/design.dart';
import 'package:daily_habit/domain/enums/habit_icon.dart';
import 'package:daily_habit/presentation/home_page/view_model/home_viewmodel.dart';
import 'package:daily_habit/presentation/home_page/widgets/create_habit_app_bar.dart';
import 'package:daily_habit/presentation/home_page/widgets/create_habit_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class CreateHabitScreen extends ConsumerStatefulWidget {
  const CreateHabitScreen({super.key});

  @override
  ConsumerState<CreateHabitScreen> createState() => _CreateHabitScreenState();
}

class _CreateHabitScreenState extends ConsumerState<CreateHabitScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  HabitIcon _selectedIcon = HabitIcon.book;
  String _selectedColor = '#29B6F6';

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeViewModelProvider);
    final notifier = ref.read(homeViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CreateHabitAppBar(),
      body: CreateHabitForm(
        formKey: _formKey,
        nameController: _nameController,
        selectedIcon: _selectedIcon,
        selectedColor: _selectedColor,
        validator: notifier.validateHabitName,
        availableIcons: notifier.availableIcons,
        availableColors: notifier.availableColorHexCodes,
        onIconSelected: (icon) => setState(() => _selectedIcon = icon),
        onColorSelected: (color) => setState(() => _selectedColor = color),
        onSubmit: _handleSubmit,
      ),
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      ref.read(homeViewModelProvider.notifier).createHabit(
        name: _nameController.text.trim(),
        icon: _selectedIcon,
        accentColor: _selectedColor,
      );
      Navigator.pop(context);
    }
  }
}