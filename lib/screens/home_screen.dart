import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../widgets/welcome_card.dart';
import 'login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? _userData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final user = authService.currentUser;
    
    if (user != null) {
      final data = await authService.getUserData(user.uid);
      setState(() {
        _userData = data;
        _isLoading = false;
      });
    }
  }

  Future<void> _logout() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    await authService.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UniHub Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Welcome Card with user data
                  WelcomeCard(
                    studentName: _userData?['name'] ?? 'Student',
                    department: _userData?['department'] ?? 'Department',
                    year: _userData?['year'] ?? 1,
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // User Info Section
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Your Information',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          _buildInfoRow('Email', _userData?['email'] ?? ''),
                          _buildInfoRow('Department', _userData?['department'] ?? ''),
                          _buildInfoRow('Year', 'Year ${_userData?['year'] ?? 1}'),
                          _buildInfoRow('Semester', 'Semester ${_userData?['semester'] ?? 1}'),
                          if (_userData?['createdAt'] != null)
                            _buildInfoRow(
                              'Member Since',
                              _formatDate(_userData!['createdAt']),
                            ),
                        ],
                      ),
                    ),
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

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(dynamic date) {
    if (date is Timestamp) {
      return date.toDate().toString().split(' ')[0];
    } else if (date is String) {
      return date.split('T')[0];
    }
    return 'Unknown';
  }

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