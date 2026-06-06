import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/routes/app_pages.dart';
import 'core/theme/app_theme.dart';
import 'data/services/hive_service.dart';

void main() async {
  // Ensure Flutter engine is initialized before Hive storage operations
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize and open Hive local storage
  final hiveService = HiveService();
  await hiveService.init();

  // Register HiveService globally to be accessible across bindings
  Get.put<HiveService>(hiveService, permanent: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Student Manager',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // Synchronizes with system settings by default
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    );
  }
}
