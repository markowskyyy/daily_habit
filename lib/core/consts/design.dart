import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  // Базовые цвета
  static const Color background = Color(0xFFFAF9F6);
  static const Color white = Colors.white;
  static const Color black = Color(0xFF000000);

  // Текст
  static const Color darkText = Color(0xFF333333);
  static const Color lightText = Color(0xFF666666);
  static const Color greyText = Color(0xFF9E9E9E);

  // Серые
  static const Color lightGrey = Color(0xFFF5F5F5);
  static const Color grey = Color(0xFF9E9E9E);
  static const Color darkGrey = Color(0xFF757575);

  // Акцентные цвета для привычек
  static const Color purple = Color(0xFF9C27B0); // Йога
  static const Color blue = Color(0xFF29B6F6);   // Чтение
  static const Color green = Color(0xFF66BB6A);  // Вода
  static const Color orange = Color(0xFFFFA726); // Медитация
  static const Color red = Color(0xFFEF5350);    // Тренировка
  static const Color pink = Color(0xFFEC407A);   // Бег
  static const Color indigo = Color(0xFF5C6BC0); // Сон
  static const Color teal = Color(0xFF26A69A);   // Здоровое питание

  // Системные
  static const Color success = green;
  static const Color error = red;
  static const Color warning = orange;
}

class AppTextStyles {
  const AppTextStyles._();

  static const String fontFamily = 'Nunito';

  // Заголовки экранов
  static const TextStyle screenTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.bold,
    height: 1.2,
    color: AppColors.darkText,
  );

  static const TextStyle screenSubtitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.3,
    color: AppColors.greyText,
  );

  // Заголовки (добавлено для empty_state)
  static const TextStyle headlineMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    height: 1.3,
    color: AppColors.darkText,
  );

  // Карточка привычки
  static const TextStyle habitName = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.3,
    color: AppColors.darkText,
  );

  // Календарь
  static const TextStyle calendarDay = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.2,
    color: AppColors.darkText,
  );

  static const TextStyle calendarWeekday = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.normal,
    height: 1.2,
    color: AppColors.greyText,
  );

  // Статистика
  static const TextStyle statNumber = TextStyle(
    fontFamily: fontFamily,
    fontSize: 48,
    fontWeight: FontWeight.bold,
    height: 1.1,
    color: AppColors.darkText,
  );

  static const TextStyle statLabel = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.4,
    color: AppColors.greyText,
  );

  static const TextStyle bestDay = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.3,
    color: AppColors.darkText,
  );

  static const TextStyle totalCheckins = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.3,
    color: AppColors.darkText,
  );

  // Кнопки
  static const TextStyle buttonText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: AppColors.white,
  );

  static const TextStyle buttonLight = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: AppColors.darkText,
  );

  static const TextStyle createButtonText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: AppColors.white,
  );

  // Форма создания привычки
  static const TextStyle formLabel = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: AppColors.darkText,
  );

  static const TextStyle formHint = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.4,
    color: AppColors.greyText,
  );

  static const TextStyle formInput = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.4,
    color: AppColors.darkText,
  );

  // Навигация
  static const TextStyle navLabel = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.2,
    color: AppColors.greyText,
  );

  static const TextStyle navLabelActive = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.2,
    color: AppColors.green,
  );

  // Body текст (добавлено для empty_state)
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.5,
    color: AppColors.darkText,
  );
}