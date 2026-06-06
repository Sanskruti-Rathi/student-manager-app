import 'package:get/get.dart';
import '../../modules/add_student/bindings/add_student_binding.dart';
import '../../modules/add_student/views/add_student_screen.dart';
import '../../modules/edit_student/bindings/edit_student_binding.dart';
import '../../modules/edit_student/views/edit_student_screen.dart';
import '../../modules/home/bindings/home_binding.dart';
import '../../modules/home/views/home_screen.dart';
import 'app_routes.dart';

class AppPages {
  static const String initial = AppRoutes.home;

  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.addStudent,
      page: () => const AddStudentScreen(),
      binding: AddStudentBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.editStudent,
      page: () => const EditStudentScreen(),
      binding: EditStudentBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
  ];
}
