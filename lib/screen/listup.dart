import 'package:flutter/material.dart';

class listup extends StatefulWidget {
  const listup({super.key});

  @override
  _listupState createState() => _listupState();
}

class _listupState extends State<listup> {
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
      _dateController.text = picked.toString().split(' ')[0].split(' ')[0];
    }
  }

  void _validateInputs() {
    setState(() {
      _isTaskNameError = _taskNameController.text.isEmpty;
      _isDateError = _dateController.text.isEmpty;
    });
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
              onPressed: () {
                _validateInputs();
              },
              child: const Text('登録'),
            ),
          ],
        ),
      ),
    );
  }
}
