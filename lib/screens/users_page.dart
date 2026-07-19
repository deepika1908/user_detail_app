import 'package:flutter/material.dart';
import 'user_details_page.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final List<Map<String, String>> students = [
  {
    "name": "User 1",
    "email": "user1@gmail.com",
    "phone": "9876543210",
    "education": "B.Tech CSE",
    "gender": "Male",
  },
  {
    "name": "User 2",
    "email": "user2@gmail.com",
    "phone": "9876543211",
    "education": "BCA",
    "gender": "Female",
  },
  {
    "name": "User 3",
    "email": "user3@gmail.com",
    "phone": "9876543212",
    "education": "MCA",
    "gender": "Male",
  },
  {
    "name": "User 4",
    "email": "user4@gmail.com",
    "phone": "9876543213",
    "education": "B.Sc",
    "gender": "Female",
  },
  {
    "name": "User 5",
    "email": "user5@gmail.com",
    "phone": "9876543214",
    "education": "MBA",
    "gender": "Male",
  },
  {
    "name": "User 6",
    "email": "user6@gmail.com",
    "phone": "9876543215",
    "education": "B.Com",
    "gender": "Female",
  },
   {
    "name": "User 6",
    "email": "user6@gmail.com",
    "phone": "9876543215",
    "education": "B.Com",
    "gender": "Female",
  },
   {
    "name": "User 7",
    "email": "user7@gmail.com",
    "phone": "9876543216",
    "education": "B.A",
    "gender": "Male",
  },
   {
    "name": "User 8",
    "email": "user8@gmail.com",
    "phone": "9876543215",
    "education": "B.Com",
    "gender": "Female",
  },
   {
    "name": "User 9",
    "email": "user9@gmail.com",
    "phone": "9876543217",
    "education": "M.Sc",
    "gender": "Male",
  },
];

  String searchText = "";

  @override
  Widget build(BuildContext context) {
    final filteredStudents = students.where((student) {
      return student["name"]!
          .toLowerCase()
          .contains(searchText.toLowerCase());
    }).toList();

    return Column(
      children: [
        // Search Bar
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search users...",
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onChanged: (value) {
              setState(() {
                searchText = value;
              });
            },
          ),
        ),

        // User List
        Expanded(
          child: ListView.builder(
            itemCount: filteredStudents.length,
            itemBuilder: (context, index) {
              final student = filteredStudents[index];

              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.deepPurple.shade100,
                    child: Text(
                      student["name"]![0],
                      style: const TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    student["name"]!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => UserDetailsPage(student: student),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}