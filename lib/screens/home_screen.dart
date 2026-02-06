import 'package:flutter/material.dart';
import '../widgets/welcome_card.dart';
import '../services/firestore_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

   // Create instance of FirestoreService
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UniHub'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Use our custom widget
            WelcomeCard(
              studentName: 'John Doe',
              department: 'Software Engineering',
              year: 3,
            ),
            // Test Firebase Button
            ElevatedButton(
              onPressed: () async {
                print('Testing Firebase connection...');
                await _firestoreService.testConnection();
              },
              child: const Text('Test Firebase Connection'),
            ),
            const SizedBox(height: 20),

                        // Add Sample User Button
            ElevatedButton(
              onPressed: () async {
                await _firestoreService.addUser(
                  name: 'Test Student',
                  email: 'test@university.edu',
                  department: 'Software Engineering',
                  year: 2,
                  semester: 1,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text('Add Sample User to Firestore'),
            ),
            
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            
            Expanded(
              child: ListView(
                children: [
                  _buildFeatureCard(
                    icon: Icons.schedule,
                    title: 'Timetable',
                    description: 'View your weekly schedule',
                    color: Colors.blue,
                  ),
                  _buildFeatureCard(
                    icon: Icons.assignment,
                    title: 'Assignments',
                    description: 'Track deadlines & submissions',
                    color: Colors.green,
                  ),
                  _buildFeatureCard(
                    icon: Icons.note,
                    title: 'Notes',
                    description: 'Access course materials',
                    color: Colors.orange,
                  ),
                  _buildFeatureCard(
                    icon: Icons.quiz,
                    title: 'Exams',
                    description: 'Check exam schedules',
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // Helper method to build feature cards
  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          print('$title tapped');
        },
      ),
    );
  }
}