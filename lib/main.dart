import 'package:flutter/material.dart';
import 'package:todo_app/screen/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screen/total.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "To Do List",
      home: Loginpage(),
    );
  }
}
