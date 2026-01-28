import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_ad_2/view_model/task_view_model.dart';

import '../data/models/user_model.dart';
import '../data/models/task_model.dart';

class TaskScreen extends StatefulWidget {
  final User user;

  const TaskScreen({super.key, required this.user});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final _taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<TaskViewModel>().fetchTasks(widget.user.id!);
  }

  void _addTask() {
    final title = _taskController.text.trim();
    if (title.isEmpty) return;

    context.read<TaskViewModel>().addTask(
      Task(title: title, isCompleted: false, userId: widget.user.id!),
    );

    _taskController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final taskVM = context.watch<TaskViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.user.name} Tasks',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xff116b98),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 10),
            child: Text('Add task here:', style: TextStyle(fontSize: 12)),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _taskController,
                    decoration: const InputDecoration(
                      hintText: 'New Task',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),

                  child: IconButton(
                    icon: const Icon(Icons.add, color: Colors.white),
                    onPressed: _addTask,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Expanded(
            child: ListView.builder(
              itemCount: taskVM.tasks.length,
              itemBuilder: (context, index) {
                final task = taskVM.tasks[index];

                return Container(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  decoration: BoxDecoration(color: Color(0xff116b98)),
                  child: ListTile(
                    title: Text(
                      task.title,
                      style: TextStyle(
                        decorationColor: Colors.white,
                        color: Colors.white,
                        decoration: task.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    leading: Checkbox(
                      value: task.isCompleted,
                      onChanged: (value) {
                        taskVM.updateTask(
                          Task(
                            id: task.id,
                            title: task.title,
                            isCompleted: value!,
                            userId: task.userId,
                          ),
                        );
                      },
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        taskVM.deleteTask(task.id!, widget.user.id!);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
