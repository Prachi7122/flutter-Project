
// import 'package:assignment2/model/home_user_model.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class UserService {
//   final http.Client httpClient;

//   UserService(this.httpClient);

//   Future<Map<String, Object>> fetchUsers(int page, {required int page}) async {
//     final url = page != null ? 'https://reqres.in/api/users?page=$page' : 'https://reqres.in/api/users?page=1';
//     final response = await httpClient.get(Uri.parse(url));

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       final List<dynamic> usersJson = data['data'];
//       final int totalPages = data['total_pages'];
//       final bool hasNextPage = page == null ? totalPages > 1 : page < totalPages;

//       return {
//         'users': usersJson.map((json) => User.fromJson(json)).toList(),
//         'hasNextPage': hasNextPage,
//       };
//     } else {
//       throw Exception('Failed to load users');
//     }
//   }

//   Future<User> fetchUserDetails(int userId) async {
//     final response = await httpClient.get(Uri.parse('https://reqres.in/api/users/$userId'));

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       return User.fromJson(data['data']);
//     } else {
//       throw Exception('Failed to load user details');
//     }
//   }
// }
import 'package:assignment2/model/home_user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserService {
  final http.Client httpClient;

  UserService(this.httpClient);

  Future<Map<String, Object>> fetchUsers({int? page}) async {
    final url = page != null ? 'https://reqres.in/api/users?page=$page' : 'https://reqres.in/api/users?page=1';
    final response = await httpClient.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> usersJson = data['data'];
      final int totalPages = data['total_pages'];
      final bool hasNextPage = page == null ? totalPages > 1 : page < totalPages;

      return {
        'users': usersJson.map((json) => User.fromJson(json)).toList(),
        'hasNextPage': hasNextPage,
      };
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<User> fetchUserDetails(int userId) async {
    final response = await httpClient.get(Uri.parse('https://reqres.in/api/users/$userId'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return User.fromJson(data['data']);
    } else {
      throw Exception('Failed to load user details');
    }
  }
}
