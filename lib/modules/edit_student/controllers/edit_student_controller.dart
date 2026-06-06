import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/student_model.dart';
import '../../home/controllers/student_controller.dart';
import '../../../core/constants/app_strings.dart';

class EditStudentController extends GetxController {
  final StudentController _studentController = Get.find<StudentController>();

  final formKey = GlobalKey<FormState>();
  late final StudentModel student;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final RxString selectedCourse = ''.obs;

  final List<String> courses = [
    'Computer Science',
    'Data Science',
    'Business Administration',
    'Mechanical Engineering',
    'Graphic Design',
    'Cyber Security',
  ];

  @override
  void onInit() {
    super.onInit();
    // Retrieve target student object passed as argument
    student = Get.arguments as StudentModel;
    
    // Pre-populate fields
    nameController.text = student.name;
    ageController.text = student.age.toString();
    selectedCourse.value = student.course;
  }

  @override
  void onClose() {
    nameController.dispose();
    ageController.dispose();
    super.onClose();
  }

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.nameRequired;
    }
    if (value.trim().length < 3) {
      return AppStrings.nameMinLength;
    }
    return null;
  }

  String? validateAge(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.ageRequired;
    }
    final age = int.tryParse(value.trim());
    if (age == null || age < 5 || age > 99) {
      return AppStrings.ageInvalid;
    }
    return null;
  }

  void selectCourse(String course) {
    selectedCourse.value = course;
  }

  Future<void> submitForm() async {
    if (formKey.currentState!.validate()) {
      if (selectedCourse.value.isEmpty) {
        Get.snackbar(
          'Required Field',
          AppStrings.courseRequired,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.amber[800],
          colorText: Colors.white,
        );
        return;
      }

      // Re-compile student details using copyWith approach / same ID
      final updatedStudent = StudentModel(
        id: student.id,
        name: nameController.text.trim(),
        age: int.parse(ageController.text.trim()),
        course: selectedCourse.value,
      );

      final success = await _studentController.updateStudent(updatedStudent);
      if (success) {
        Get.back();
        Get.snackbar(
          'Success',
          AppStrings.studentUpdated,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF10B981),
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          borderRadius: 12,
          icon: const Icon(Icons.check_circle_outline_rounded, color: Colors.white),
        );
      }
    }
  }
}
