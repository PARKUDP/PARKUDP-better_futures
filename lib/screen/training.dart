import 'package:flutter/material.dart';

class TrainingPage extends StatelessWidget {
  const TrainingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 229, 255, 0),
          title: const Text('トレーニング'),
          automaticallyImplyLeading: false,
        ),
        body: const Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center, children: [])));
  }
}
