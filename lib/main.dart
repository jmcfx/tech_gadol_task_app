import 'package:flutter/material.dart';
import 'package:tech_gadol_task_app/src/app/app.dart';
import 'package:tech_gadol_task_app/src/core/di/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const TechGadolTaskApp());
}
