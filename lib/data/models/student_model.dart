import 'package:hive/hive.dart';

part 'student_model.g.dart';

@HiveType(typeId: 0)
class StudentModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int age;

  @HiveField(3)
  final String course;

  StudentModel({
    required this.id,
    required this.name,
    required this.age,
    required this.course,
  });

  StudentModel copyWith({
    String? id,
    String? name,
    int? age,
    String? course,
  }) {
    return StudentModel(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      course: course ?? this.course,
    );
  }
}
