import 'package:flutter/material.dart';
import 'task_preferences.dart';

class Listup extends StatefulWidget {
  final Function(Task) onAddTask;

  const Listup({super.key, required this.onAddTask});

  @override
  _ListupState createState() => _ListupState();
}

class _ListupState extends State<Listup> {
  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  bool _isTaskNameError = false;
  bool _isDateError = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      _dateController.text = picked.toString().split(' ')[0];
    }
  }

  void _validateInputs() {
    setState(() {
      _isTaskNameError = _taskNameController.text.isEmpty;
      _isDateError = _dateController.text.isEmpty;
    });

    if (!_isTaskNameError && !_isDateError) {
      _addTask();
    }
  }

  void _addTask() {
    final newTask =
        Task(name: _taskNameController.text, dueDate: _dateController.text);
    widget.onAddTask(newTask);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 229, 255, 0),
        title: const Text('タスク登録'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _taskNameController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'タスク名',
                errorText: _isTaskNameError ? 'タスク名を入力してください' : null,
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _dateController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'いつまで',
                suffixIcon: IconButton(
                  onPressed: () => _selectDate(context),
                  icon: const Icon(Icons.calendar_today),
                ),
                errorText: _isDateError ? 'いつまでを入力してください' : null,
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _validateInputs,
              child: const Text('登録'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('キャンセル'),
            ),
          ],
        ),
      ),
    );
  }
}
