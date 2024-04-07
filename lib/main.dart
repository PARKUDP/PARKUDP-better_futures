import 'package:flutter/material.dart';
import 'screen/total.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: "To Do List", home: TotalPage());
  }
}
