import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../../../data/models/student_model.dart';
import '../../home/controllers/student_controller.dart';
import '../../../core/constants/app_strings.dart';

class AddStudentController extends GetxController {
  final StudentController _studentController = Get.find<StudentController>();

  final formKey = GlobalKey<FormState>();
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

      final newStudent = StudentModel(
        id: const Uuid().v4(),
        name: nameController.text.trim(),
        age: int.parse(ageController.text.trim()),
        course: selectedCourse.value,
      );

      final success = await _studentController.addStudent(newStudent);
      if (success) {
        Get.back();
        Get.snackbar(
          'Success',
          AppStrings.studentAdded,
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
