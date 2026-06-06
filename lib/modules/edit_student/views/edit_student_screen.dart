import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../data/models/student_model.dart';
import '../controllers/edit_student_controller.dart';

class EditStudentScreen extends GetView<EditStudentController> {
  const EditStudentScreen({super.key});

  List<Color> _getAvatarGradient(StudentModel student) {
    final nameHash = student.name.hashCode;
    final List<List<Color>> gradients = [
      [Colors.deepPurple, Colors.indigo],
      [Colors.indigo, Colors.cyan],
      [Colors.teal, Colors.cyan],
      [Colors.pink, Colors.purple],
      [Colors.orange, Colors.pink],
      [Colors.blue, Colors.teal],
    ];
    return gradients[nameHash.abs() % gradients.length];
  }

  String _getInitials(StudentModel student) {
    final names = student.name.trim().split(RegExp(r'\s+'));
    if (names.isEmpty) return 'S';
    if (names.length == 1) {
      return names[0].substring(0, names[0].length >= 2 ? 2 : 1).toUpperCase();
    }
    return (names[0][0] + names[1][0]).toUpperCase();
  }

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
          title: const Text(AppStrings.editStudent),
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
                  // Hero avatar transition from list view
                  Center(
                    child: Hero(
                      tag: 'avatar-${controller.student.id}',
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: _getAvatarGradient(controller.student),
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: _getAvatarGradient(controller.student)[0].withOpacity(0.4),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            )
                          ],
                        ),
                        alignment: Alignment.center,
                        child: Material(
                          type: MaterialType.transparency,
                          child: Text(
                            _getInitials(controller.student),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ).animate().scale(duration: 400.ms, curve: Curves.easeOutBack),
                  
                  const SizedBox(height: 20),
                  
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Edit Records: ${controller.student.name}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: isDark ? AppColors.darkText : AppColors.lightText,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Modify academic info and save changes.',
                          style: TextStyle(
                            fontSize: 13,
                            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                          ),
                        ),
                      ],
                    ),
                  ).animate().fade(delay: 100.ms, duration: 300.ms),

                  const SizedBox(height: 28),

                  // Form Container
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
                        // Name Field
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
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Age Field
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
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Course Selector
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

                  // Save Changes button
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
                            AppStrings.update,
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
