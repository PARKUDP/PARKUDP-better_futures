import 'package:flutter/material.dart';
import 'listup.dart';
import 'task_preferences.dart';

class Todopage extends StatefulWidget {
  const Todopage({super.key});

  @override
  _TodopageState createState() => _TodopageState();
}

class _TodopageState extends State<Todopage> {
  List<Task> _tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final tasks = await TaskPreferences.loadTasks();
    setState(() {
      _tasks = tasks;
    });
  }

  void _addTask(Task task) async {
    setState(() {
      _tasks.add(task);
    });
    await TaskPreferences.saveTasks(_tasks);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 229, 255, 0),
        title: const Text('タスク'),
        automaticallyImplyLeading: false,
        actions: [],
      ),
      body: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_tasks[index].name),
            subtitle: Text(_tasks[index].dueDate),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Listup(onAddTask: _addTask),
            ),
          );
        },
        tooltip: 'listup',
        backgroundColor: const Color.fromARGB(255, 229, 255, 0),
        child: const Icon(Icons.add),
      ),
    );
  }
}
