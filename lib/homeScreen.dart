import 'package:flutter/material.dart';
import 'package:todo_app/utils/todo_list.dart';

// ignore: must_be_immutable
class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final _controller = TextEditingController();
  List todolist = [
    ['Learn Fluttter', false],
    ['Drink Coffee', false],
    ['Drink energy drink', false],
  ];

  void checkboxChanged(int index) {
    setState(() {
      todolist[index][1] = !todolist[index][1];
    });
  }

  void saveNewTask() {
    setState(() {
      todolist.add([_controller.text, false]);
      _controller.clear();
    });
  }

  void deleteTask(int index) {
    setState(() {
      todolist.removeAt(index);
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
            itemBuilder: (BuildContext context, index) {
              return TodoList(
                taskName: todolist[index][0],
                taskCompleted: todolist[index][1],
                onChanged: (value) => checkboxChanged(index),
                deleteFunction: (context) => deleteTask(index),
              );
            }),
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
                      )),
                ),
              )),
              FloatingActionButton(
                onPressed: saveNewTask,
                child: const Icon(Icons.add),
              ),
            ],
          ),
        ));
  }
}
