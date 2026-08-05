import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/user.dart';

class ApiService {
  Future<List<User>> fetchUsers() async {
    final response = await http.get(
      Uri.parse('https://dummyjson.com/users'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final users = data['users'] as List;

      return users.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Could not load users');
    }
  }
}
