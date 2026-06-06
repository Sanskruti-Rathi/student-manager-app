import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_theme.dart';
import '../controllers/student_controller.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/student_card.dart';
import '../widgets/empty_state.dart';

class HomeScreen extends GetView<StudentController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // We observe theme brightness dynamically
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        gradient: isDark ? AppColors.darkBgGradient : AppColors.lightBgGradient,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text(AppStrings.appName),
          actions: [
            // Premium Theme Toggle Button
            IconButton(
              icon: Icon(
                isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                color: isDark ? AppColors.accent : AppColors.primary,
              ),
              onPressed: () {
                if (Get.isDarkMode) {
                  Get.changeTheme(AppTheme.lightTheme);
                } else {
                  Get.changeTheme(AppTheme.darkTheme);
                }
              },
              style: IconButton.styleFrom(
                backgroundColor: isDark 
                    ? AppColors.darkBorder.withOpacity(0.3) 
                    : AppColors.primary.withOpacity(0.06),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome Back,',
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Portal Administrator',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: isDark ? AppColors.darkText : AppColors.lightText,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ).animate().fade(duration: 400.ms).slideY(begin: -0.15, end: 0),
              
              // Statistics / Dashboard Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Obx(() {
                  return DashboardCard(
                    totalStudents: controller.totalStudentsCount,
                    averageAge: controller.averageAge,
                    totalCourses: controller.courseCount,
                  );
                }),
              ),
              
              // Search Input Field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Obx(() {
                  return TextField(
                    controller: controller.searchController,
                    onChanged: controller.search,
                    style: TextStyle(
                      color: isDark ? AppColors.darkText : AppColors.lightText,
                    ),
                    decoration: InputDecoration(
                      hintText: AppStrings.searchPlaceholder,
                      prefixIcon: const Icon(Icons.search_rounded),
                      suffixIcon: controller.searchQuery.isEmpty
                          ? null
                          : IconButton(
                              icon: const Icon(Icons.clear_rounded),
                              onPressed: controller.clearSearch,
                            ),
                    ),
                  );
                }),
              ).animate().fade(delay: 150.ms, duration: 400.ms).slideY(begin: 0.1, end: 0),
              
              // Animated Student List Label
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Text(
                  'Student Records',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.darkText : AppColors.lightText,
                  ),
                ),
              ).animate().fade(delay: 200.ms, duration: 300.ms),
              
              // Reactive List View
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  
                  if (controller.students.isEmpty) {
                    return const EmptyState();
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 80),
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.students.length,
                    itemBuilder: (context, index) {
                      final student = controller.students[index];
                      return StudentCard(
                        student: student,
                        onEdit: () {
                          Get.toNamed(AppRoutes.editStudent, arguments: student);
                        },
                        onDelete: () {
                          final studentName = student.name;
                          controller.deleteStudent(student.id);
                          Get.snackbar(
                            'Record Removed',
                            '$studentName has been deleted.',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: AppColors.error,
                            colorText: Colors.white,
                            margin: const EdgeInsets.all(16),
                            borderRadius: 12,
                            icon: const Icon(Icons.delete_forever_rounded, color: Colors.white),
                            duration: const Duration(seconds: 3),
                          );
                        },
                      ).animate().fade(
                            delay: (index * 50).ms, 
                            duration: 350.ms,
                          ).slideX(
                            begin: 0.1, 
                            end: 0, 
                            curve: Curves.easeOutQuad,
                          );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.toNamed(AppRoutes.addStudent);
          },
          icon: const Icon(Icons.add_rounded),
          label: const Text('Add Student'),
        ).animate().scale(delay: 400.ms, duration: 400.ms, curve: Curves.elasticOut),
      ),
    );
  }
}
