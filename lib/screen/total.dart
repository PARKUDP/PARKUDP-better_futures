import 'package:flutter/material.dart';
import 'accout.dart';
import 'training.dart';
import 'todolist.dart';

class TotalPage extends StatelessWidget {
  const TotalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do list',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  static const _screens = [
    Todopage(),
    TrainingPage(),
    AccountPage(),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ToDoリスト'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'トレーニング'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'アカウント')
          ],
          type: BottomNavigationBarType.fixed,
        ));
  }
}
