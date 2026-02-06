import 'package:flutter/material.dart';

class WelcomeCard extends StatelessWidget {
  final String studentName;
  final String department;
  final int year;
  
  const WelcomeCard({
    super.key,
    required this.studentName,
    required this.department,
    required this.year,
  });
  
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.person, color: Colors.blue),
                const SizedBox(width: 10),
                Text(
                  'Welcome, $studentName!',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.school, size: 16, color: Colors.grey),
                const SizedBox(width: 5),
                Text('$department - Year $year'),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                const SizedBox(width: 5),
                Text('Semester ${(DateTime.now().month <= 6) ? 2 : 1}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}