class User {
  String name;
  String email;
  String department;
  int year;
  int semester;
  
  User({
    required this.name,
    required this.email,
    required this.department,
    required this.year,
    required this.semester,
  });
  
  // Convert User to Map (for Firestore)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'department': department,
      'year': year,
      'semester': semester,
    };
  }
  
  // Create User from Map (from Firestore)
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      department: map['department'] ?? '',
      year: map['year'] ?? 1,
      semester: map['semester'] ?? 1,
    );
  }
}