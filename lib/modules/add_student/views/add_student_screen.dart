import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../controllers/add_student_controller.dart';

class AddStudentScreen extends GetView<AddStudentController> {
  const AddStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        gradient: isDark ? AppColors.darkBgGradient : AppColors.lightBgGradient,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text(AppStrings.addStudent),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () => Get.back(),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    'Register New Student',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.darkText : AppColors.lightText,
                    ),
                  ).animate().fade(duration: 300.ms).slideX(begin: -0.1, end: 0),
                  const SizedBox(height: 6),
                  Text(
                    'Enter academic and personal credentials below.',
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                    ),
                  ).animate().fade(delay: 100.ms, duration: 300.ms).slideX(begin: -0.1, end: 0),
                  const SizedBox(height: 28),

                  // Glassmorphic Card Form Container
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.darkCard.withOpacity(0.4)
                          : Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: isDark
                            ? AppColors.darkBorder.withOpacity(0.5)
                            : AppColors.lightBorder.withOpacity(0.7),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name Input Field
                        TextFormField(
                          controller: controller.nameController,
                          validator: controller.validateName,
                          keyboardType: TextInputType.name,
                          textCapitalization: TextCapitalization.words,
                          style: TextStyle(
                            color: isDark ? AppColors.darkText : AppColors.lightText,
                          ),
                          decoration: const InputDecoration(
                            labelText: AppStrings.nameLabel,
                            prefixIcon: Icon(Icons.person_outline_rounded),
                            hintText: 'John Doe',
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Age Input Field
                        TextFormField(
                          controller: controller.ageController,
                          validator: controller.validateAge,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(2),
                          ],
                          style: TextStyle(
                            color: isDark ? AppColors.darkText : AppColors.lightText,
                          ),
                          decoration: const InputDecoration(
                            labelText: AppStrings.ageLabel,
                            prefixIcon: Icon(Icons.calendar_today_rounded),
                            hintText: '21',
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Course Dropdown Selector
                        Text(
                          AppStrings.courseLabel,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Obx(() {
                          return DropdownButtonFormField<String>(
                            value: controller.selectedCourse.value.isEmpty
                                ? null
                                : controller.selectedCourse.value,
                            hint: Text(
                              'Select registered course',
                              style: TextStyle(
                                color: isDark
                                    ? AppColors.darkTextSecondary.withOpacity(0.6)
                                    : AppColors.lightTextSecondary.withOpacity(0.6),
                              ),
                            ),
                            style: TextStyle(
                              color: isDark ? AppColors.darkText : AppColors.lightText,
                              fontSize: 15,
                            ),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              prefixIcon: Icon(
                                Icons.school_outlined,
                                color: isDark ? AppColors.accent : AppColors.primary,
                              ),
                            ),
                            dropdownColor: isDark ? AppColors.darkCard : Colors.white,
                            items: controller.courses.map((String course) {
                              return DropdownMenuItem<String>(
                                value: course,
                                child: Text(course),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                controller.selectCourse(value);
                              }
                            },
                          );
                        }),
                      ],
                    ),
                  ).animate().fade(delay: 200.ms, duration: 400.ms).slideY(begin: 0.1, end: 0),

                  const SizedBox(height: 36),

                  // Animated Save Button
                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: ElevatedButton(
                      onPressed: controller.submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDark ? AppColors.primaryAccent : AppColors.primary,
                        foregroundColor: Colors.white,
                        shadowColor: isDark
                            ? AppColors.primaryAccent.withOpacity(0.4)
                            : AppColors.primary.withOpacity(0.4),
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.save_rounded),
                          SizedBox(width: 10),
                          Text(
                            AppStrings.save,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ).animate(onPlay: (c) => c.repeat(reverse: true))
                   .shimmer(delay: 3000.ms, duration: 1800.ms, color: Colors.white.withOpacity(0.15))
                   .animate()
                   .fade(delay: 300.ms, duration: 400.ms)
                   .scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1), curve: Curves.easeOutBack),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
