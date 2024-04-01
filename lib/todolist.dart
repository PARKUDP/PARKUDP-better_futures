import 'package:flutter/material.dart';
import 'listup.dart';
import 'signin.dart';

class Todopage extends StatelessWidget {
  const Todopage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 229, 255, 0),
        title: const Text('To Do List'),
        automaticallyImplyLeading: false,
        actions: [
          // MyPage
          IconButton(icon: const Icon(Icons.account_circle), onPressed: () {})
        ],
      ),
      body: const Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center, children: [])),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const listup()));
          },
          tooltip: 'listup',
          backgroundColor: const Color.fromARGB(255, 229, 255, 0),
          child: const Icon(Icons.add)),
    );
  }
}
