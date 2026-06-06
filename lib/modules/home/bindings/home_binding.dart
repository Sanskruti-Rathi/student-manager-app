import 'package:get/get.dart';
import '../../../data/repositories/student_repository.dart';
import '../../../data/services/hive_service.dart';
import '../controllers/student_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Inject Repository using HiveService dependency
    Get.lazyPut<StudentRepository>(
      () => StudentRepositoryImpl(Get.find<HiveService>()),
    );
    // Instantiate StudentController directly for immediate load on Home
    Get.put<StudentController>(
      StudentController(Get.find<StudentRepository>()),
    );
  }
}
