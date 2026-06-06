import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/student_model.dart';
import '../../../data/repositories/student_repository.dart';

class StudentController extends GetxController {
  final StudentRepository _studentRepository;

  StudentController(this._studentRepository);

  final RxList<StudentModel> students = <StudentModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString searchQuery = ''.obs;
  
  // Controller for search text field
  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadStudents();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void loadStudents() {
    isLoading.value = true;
    try {
      final results = _studentRepository.getAllStudents();
      students.assignAll(results);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load student records',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> addStudent(StudentModel student) async {
    try {
      await _studentRepository.addStudent(student);
      if (searchQuery.isNotEmpty) {
        search(searchQuery.value);
      } else {
        loadStudents();
      }
      return true;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to add student record',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  Future<bool> updateStudent(StudentModel student) async {
    try {
      await _studentRepository.updateStudent(student);
      if (searchQuery.isNotEmpty) {
        search(searchQuery.value);
      } else {
        loadStudents();
      }
      return true;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update student record',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  Future<void> deleteStudent(String id) async {
    try {
      await _studentRepository.deleteStudent(id);
      if (searchQuery.isNotEmpty) {
        search(searchQuery.value);
      } else {
        loadStudents();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to delete student record',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void search(String query) {
    searchQuery.value = query;
    if (query.trim().isEmpty) {
      loadStudents();
    } else {
      final results = _studentRepository.searchStudents(query);
      students.assignAll(results);
    }
  }

  void clearSearch() {
    searchController.clear();
    search('');
  }

  // Dashboard calculations
  int get totalStudentsCount => students.length;

  double get averageAge {
    if (students.isEmpty) return 0.0;
    final total = students.fold<num>(0, (sum, student) => sum + student.age);
    return total / students.length;
  }

  int get courseCount {
    if (students.isEmpty) return 0;
    return students.map((student) => student.course.trim().toLowerCase()).toSet().length;
  }
}
