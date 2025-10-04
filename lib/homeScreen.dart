import 'package:flutter/material.dart';
import 'package:todo_app/utils/todo_list.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final TextEditingController _controller = TextEditingController();
  final List<List<dynamic>> todolist = [
    ['Learn Flutter', false],
    ['Drink Coffee', false],
    ['Drink energy drink', false],
  ];

  void checkboxChanged(int index) {
    setState(() {
      if (index >= 0 && index < todolist.length && todolist[index][1] is bool) {
        todolist[index][1] = !(todolist[index][1] as bool);
      }
    });
  }

  void saveNewTask() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        todolist.add([text, false]);
        _controller.clear();
      });
    }
  }

  void deleteTask(int index) {
    setState(() {
      if (index >= 0 && index < todolist.length) {
        todolist.removeAt(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade200,
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        title: const Text("Todo App"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: todolist.length,
        itemBuilder: (BuildContext context, int index) {
          final task = todolist[index];
          final taskName =
              (task.isNotEmpty && task[0] != null) ? task[0].toString() : '';
          final taskCompleted =
              (task.length > 1 && task[1] is bool) ? task[1] as bool : false;
          return TodoList(
            taskName: taskName,
            taskCompleted: taskCompleted,
            onChanged: (_) => checkboxChanged(index),
            deleteFunction: (_) => deleteTask(index),
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Add a new todo item',
                    filled: true,
                    fillColor: Colors.deepPurple.shade100,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onSubmitted: (_) => saveNewTask(),
                ),
              ),
            ),
            FloatingActionButton(
              onPressed: saveNewTask,
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
