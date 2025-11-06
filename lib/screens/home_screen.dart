import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final routines = [
      {'time': '8:00 AM', 'task': 'Take Blood Pressure Medicine'},
      {'time': '12:30 PM', 'task': 'Lunch - Diabetes Pill'},
      {'time': '6:00 PM', 'task': 'Evening Walk - 20 min'},
      {'time': '9:00 PM', 'task': 'Vitamin D Capsule'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Aayi'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: routines.length,
          itemBuilder: (context, index) {
            final routine = routines[index];
            return Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: const Icon(Icons.access_time, color: Colors.teal),
                title: Text(
                  routine['task']!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(routine['time']!),
                trailing: const Icon(
                  Icons.notifications_active,
                  color: Colors.grey,
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Add Routine pressed')));
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
