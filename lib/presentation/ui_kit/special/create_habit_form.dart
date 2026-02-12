// import 'package:daily_habit/core/consts/design.dart';
// import 'package:daily_habit/domain/enums/habit_icon.dart';
// // import 'package:daily_habit/presentation/view_models/habit_viewmodel.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// class CreateHabitForm extends ConsumerStatefulWidget {
//   final Function(String name, HabitIcon icon, String color) onSubmit;
//   final VoidCallback? onCancel;
//
//   const CreateHabitForm({
//     super.key,
//     required this.onSubmit,
//     this.onCancel,
//   });
//
//   @override
//   ConsumerState<CreateHabitForm> createState() => _CreateHabitFormState();
// }
//
// class _CreateHabitFormState extends ConsumerState<CreateHabitForm> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//
//   HabitIcon _selectedIcon = HabitIcon.book;
//   String _selectedColor = '#29B6F6'; // blue default
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final viewModel = ref.read(habitViewModelProvider);
//
//     return Container(
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: const BorderRadius.vertical(
//           top: Radius.circular(24),
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(
//                 child: Container(
//                   width: 40,
//                   height: 4,
//                   decoration: BoxDecoration(
//                     color: AppColors.lightGrey,
//                     borderRadius: BorderRadius.circular(2),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Text(
//                 'New Habit',
//                 style: AppTextStyles.screenTitle,
//               ),
//               const SizedBox(height: 24),
//               Text(
//                 'HABIT NAME',
//                 style: AppTextStyles.formLabel,
//               ),
//               const SizedBox(height: 8),
//               TextFormField(
//                 controller: _nameController,
//                 style: AppTextStyles.formInput,
//                 decoration: InputDecoration(
//                   hintText: 'e.g. Read 20 mins',
//                   hintStyle: AppTextStyles.formHint,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide.none,
//                   ),
//                   filled: true,
//                   fillColor: AppColors.lightGrey,
//                   contentPadding: const EdgeInsets.all(16),
//                 ),
//                 validator: (value) => viewModel.validateHabitName(value),
//                 autofocus: true,
//               ),
//               const SizedBox(height: 24),
//               Text(
//                 'ICON',
//                 style: AppTextStyles.formLabel,
//               ),
//               const SizedBox(height: 12),
//               _buildIconSelector(viewModel),
//               const SizedBox(height: 24),
//               Text(
//                 'ACCENT COLOR',
//                 style: AppTextStyles.formLabel,
//               ),
//               const SizedBox(height: 12),
//               _buildColorSelector(viewModel),
//               const SizedBox(height: 32),
//               Row(
//                 children: [
//                   if (widget.onCancel != null)
//                     Expanded(
//                       child: OutlinedButton(
//                         onPressed: widget.onCancel,
//                         style: OutlinedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(vertical: 16),
//                           side: const BorderSide(color: AppColors.lightGrey),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         child: Text(
//                           'Cancel',
//                           style: AppTextStyles.buttonLight,
//                         ),
//                       ),
//                     ),
//                   if (widget.onCancel != null)
//                     const SizedBox(width: 12),
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: _handleSubmit,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColors.green,
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       child: Text(
//                         'Create Habit',
//                         style: AppTextStyles.buttonText,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildIconSelector(HabitViewModel viewModel) {
//     return Wrap(
//       spacing: 12,
//       runSpacing: 12,
//       children: viewModel.availableIcons.map((icon) {
//         final isSelected = icon == _selectedIcon;
//         final color = _getColorFromHex(_selectedColor);
//
//         return GestureDetector(
//           onTap: () {
//             setState(() {
//               _selectedIcon = icon;
//             });
//           },
//           child: Container(
//             width: 56,
//             height: 56,
//             decoration: BoxDecoration(
//               color: isSelected
//                   ? color.withOpacity(0.1)
//                   : AppColors.lightGrey,
//               borderRadius: BorderRadius.circular(12),
//               border: isSelected
//                   ? Border.all(color: color, width: 2)
//                   : null,
//             ),
//             child: Icon(
//               _getIconData(icon),
//               color: isSelected ? color : AppColors.grey,
//               size: 28,
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   }
//
//   Widget _buildColorSelector(HabitViewModel viewModel) {
//     return Wrap(
//       spacing: 12,
//       runSpacing: 12,
//       children: viewModel.availableColorHexCodes.map((hexColor) {
//         final color = _getColorFromHex(hexColor);
//         final isSelected = hexColor == _selectedColor;
//
//         return GestureDetector(
//           onTap: () {
//             setState(() {
//               _selectedColor = hexColor;
//             });
//           },
//           child: Container(
//             width: 48,
//             height: 48,
//             decoration: BoxDecoration(
//               color: color,
//               shape: BoxShape.circle,
//               border: isSelected
//                   ? Border.all(
//                 color: AppColors.darkText,
//                 width: 3,
//               )
//                   : null,
//             ),
//             child: isSelected
//                 ? const Center(
//               child: Icon(
//                 Icons.check,
//                 color: Colors.white,
//                 size: 24,
//               ),
//             )
//                 : null,
//           ),
//         );
//       }).toList(),
//     );
//   }
//
//   void _handleSubmit() {
//     if (_formKey.currentState!.validate()) {
//       widget.onSubmit(
//         _nameController.text.trim(),
//         _selectedIcon,
//         _selectedColor,
//       );
//     }
//   }
//
//   Color _getColorFromHex(String hexColor) {
//     hexColor = hexColor.replaceAll('#', '');
//     return Color(int.parse('FF$hexColor', radix: 16));
//   }
//
//   IconData _getIconData(HabitIcon icon) {
//     switch (icon) {
//       case HabitIcon.yoga:
//         return Icons.self_improvement;
//       case HabitIcon.book:
//         return Icons.menu_book;
//       case HabitIcon.water:
//         return Icons.water_drop;
//       case HabitIcon.meditation:
//         return Icons.self_improvement;
//       case HabitIcon.workout:
//         return Icons.fitness_center;
//       case HabitIcon.running:
//         return Icons.directions_run;
//       case HabitIcon.sleep:
//         return Icons.night_shelter;
//       case HabitIcon.healthyFood:
//         return Icons.restaurant;
//     }
//   }
// }