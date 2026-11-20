import 'dart:html';
import 'dart:js';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Tasklist(),
    );
  }
}

class Tasklist extends StatefulWidget {
  const Tasklist({super.key});
  @override
  State<Tasklist> createState() => _Tasklist();
}

class _Tasklist extends State<Tasklist> {
  List<Task> tasks = [
    Task("DO THE DISHES", false),
    Task("STUDY FLUTTER", false),
    Task("STUDY DB", true),
    Task("READ 10 pages FROM A BOOK", true)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("MY TASKS:")),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return TaskItem(
                    item: tasks[index],
                    onchange: (value) {
                      setState(() {
                        tasks[index].isComp = value!;
                      });
                    },
                  );
                },
              ),
            ),
            Text((tasks.where((b) => b.isComp).length).toString() +
                "/" +
                tasks.length.toString()),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CompTask(
                        comptask: tasks.where((c) => c.isComp).toList()),
                  ),
                );
              },
              child: Text("COMPLETED TASKS"),
            ),
          ],
        ),
      ),
    );
  }
}

class Task {
  String title;
  bool isComp;
  Task(this.title, this.isComp);
}

class TaskItem extends StatelessWidget {
  final Task item;
  final ValueChanged<bool?> onchange;
  const TaskItem({super.key, required this.item, required this.onchange});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.title),
      leading: Icon(Icons.home_max),
      trailing: Checkbox(onChanged: onchange, value: item.isComp),
    );
  }
}

class CompTask extends StatelessWidget {
  final List<Task> comptask;
  const CompTask({super.key, required this.comptask});

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("COMPLETED TASKS"),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: comptask.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(comptask[index].title),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("RETURN BACK"),
            ),
          ],
        ),
      ),
    );
  }
}
