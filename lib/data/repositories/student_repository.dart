import '../models/student_model.dart';
import '../services/hive_service.dart';

abstract class StudentRepository {
  List<StudentModel> getAllStudents();
  Future<void> addStudent(StudentModel student);
  Future<void> updateStudent(StudentModel student);
  Future<void> deleteStudent(String id);
  List<StudentModel> searchStudents(String query);
}

class StudentRepositoryImpl implements StudentRepository {
  final HiveService _hiveService;

  StudentRepositoryImpl(this._hiveService);

  @override
  List<StudentModel> getAllStudents() {
    return _hiveService.studentBox.values.toList();
  }

  @override
  Future<void> addStudent(StudentModel student) async {
    await _hiveService.studentBox.put(student.id, student);
  }

  @override
  Future<void> updateStudent(StudentModel student) async {
    await _hiveService.studentBox.put(student.id, student);
  }

  @override
  Future<void> deleteStudent(String id) async {
    await _hiveService.studentBox.delete(id);
  }

  @override
  List<StudentModel> searchStudents(String query) {
    if (query.trim().isEmpty) return getAllStudents();
    final lowercaseQuery = query.trim().toLowerCase();
    return _hiveService.studentBox.values.where((student) {
      return student.name.toLowerCase().contains(lowercaseQuery) ||
             student.course.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }
}
