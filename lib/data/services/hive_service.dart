import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import '../models/student_model.dart';

class HiveService {
  static const String studentBoxName = 'students_box';

  Future<void> init() async {
    // Initialize hive with application documents directory
    final directory = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(directory.path);
    
    // Register the StudentModel adapter
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(StudentModelAdapter());
    }

    // Open student storage box
    await Hive.openBox<StudentModel>(studentBoxName);
  }

  Box<StudentModel> get studentBox => Hive.box<StudentModel>(studentBoxName);
}
