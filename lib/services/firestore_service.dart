import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // Simple test method
  Future<void> testConnection() async {
    try {
      await _firestore.collection('test').doc('connection').set({
        'timestamp': DateTime.now(),
        'message': 'Firestore connection successful!',
      });
      print('✅ Firestore connection test passed!');
    } catch (e) {
      print('❌ Firestore error: $e');
    }
  }
  
  // Add a user to Firestore
  Future<void> addUser({
    required String name,
    required String email,
    required String department,
    required int year,
    required int semester,
  }) async {
    try {
      await _firestore.collection('users').add({
        'name': name,
        'email': email,
        'department': department,
        'year': year,
        'semester': semester,
        'createdAt': FieldValue.serverTimestamp(),
      });
      print('✅ User added successfully!');
    } catch (e) {
      print('❌ Error adding user: $e');
    }
  }
}