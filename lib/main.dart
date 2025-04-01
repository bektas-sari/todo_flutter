import 'package:flutter/material.dart';

void main() {
  runApp(const SimpleTodoApp());
}

class SimpleTodoApp extends StatelessWidget {
  const SimpleTodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple To-Do App',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const TodoHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key});

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  final List<TodoItem> _todoItems = [];
  final TextEditingController _controller = TextEditingController();

  void _addTodoItem() {
    if (_controller.text.trim().isNotEmpty) {
      setState(() {
        _todoItems.add(TodoItem(title: _controller.text));
        _controller.clear();
      });
    }
  }

  void _toggleDone(int index) {
    setState(() {
      _todoItems[index].isDone = !_todoItems[index].isDone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My To-Do List'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Enter a task...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addTodoItem,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onSubmitted: (value) => _addTodoItem(),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _todoItems.length,
                itemBuilder: (context, index) {
                  final item = _todoItems[index];
                  return ListTile(
                    title: Text(
                      item.title,
                      style: TextStyle(
                        fontSize: 18,
                        decoration:
                            item.isDone ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    onTap: () => _toggleDone(index),
                    trailing: Icon(
                      item.isDone
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                      color: item.isDone ? Colors.teal : null,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TodoItem {
  String title;
  bool isDone;

  TodoItem({required this.title, this.isDone = false});
}
