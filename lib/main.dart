import 'package:flutter/material.dart';

void main() {
  runApp(const TaskListApp());
}

class Task {
  String title;
  String description;
  bool isComplete;

  Task({required this.title, required this.description, this.isComplete = false});
}

class TaskListApp extends StatelessWidget {
  const TaskListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:  'Task List App',
      home: const TaskListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = [];
  
  void _addTask() async {
    
//***** Activity 4 *****
    final newTask = await showDialog<Task>(
      context: context,
      builder: (context) => AddTaskDialog(),
    );

    if (newTask != null) {
      setState(() {
        tasks.add(newTask);
      });
    }
//**********************

//***** Activity 2 ***** (Transition from this to Activity 4)
    // setState(() {
    //     tasks.add(Task(
    //       title: "Hello",
    //       description: "Goodbye",
    //     )
      
    //     );
    //   });
//**********************
  }

//***** Activity 3 *****
  void _deleteTask(Task task) {
    setState(() {
      tasks.remove(task);
    });
  }
//**********************

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task List'),
        backgroundColor: const Color.fromARGB(255, 255, 220, 158),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return Card(
            color: const Color.fromARGB(255, 255, 254, 252),
        //***** Activity 1 *****
            elevation: 2,   //add elevation
            //margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 150),
        //**********************
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            child: ListTile(
              title: Text(
                task.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(task.description),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
      //***** Activity 1 *****
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deleteTask(task),
                  ),
      //**********************
                  Checkbox(
                    value: task.isComplete,
                    onChanged: (value) {
                      setState(() {
                        task.isComplete = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 255, 220, 158),
        onPressed: _addTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}


class AddTaskDialog extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  AddTaskDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: 'Title',
              hintText: 'Enter task title',
            ),
          ),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(
              labelText: 'Description',
              hintText: 'Enter task description',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final newTask = Task(
              title: titleController.text,
              description: descriptionController.text,
            );
            Navigator.pop(context, newTask);
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
