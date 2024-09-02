// import 'package:assignment2/model/home_user_model.dart'; // Ensure correct import
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class HomeService {
//   //it keeps the instance of http client which is used or request 
//   final http.Client httpClient;
//  // constructor 
//   HomeService(this.httpClient);
//   // here fetchuser will return the lit of users
//   Future<List<User>> fetchUsers({required int page}) async {
//     //here we send the request to fetch the user list using get
//     final response = await httpClient.get(Uri.parse('https://reqres.in/api/users?page=1'));
//     // here we check the response code 
//     if (response.statusCode == 200) {
//       //response body is decoxded by json
//       final data = jsonDecode(response.body);
//       // here json extracts theuser data
//       final List<dynamic> usersJson = data['data'];
//       //converting json data to users list
//       return usersJson.map((json) => User.fromJson(json)).toList();
//     } else {
//       //handling exception 
//       throw Exception('Failed to load users');
//     }
//   }
//  // here we will fetch data of based on user ID
//   Future<User> fetchUserDetails(int userId) async {
//     //again we make a request 
//     final response = await httpClient.get(Uri.parse('https://reqres.in/api/users/$userId'));
//     // check the response code 
//     if (response.statusCode == 200) {
//       //json decodes response body 
//       final data = jsonDecode(response.body);
//       // converting json into user 
//       return User.fromJson(data['data']);
//     } else {
//       // trowing exception when exception generated generated 
//       throw Exception('Failed to load user details');
//     }
//   }
// }
// // import 'dart:convert';
// // import 'package:assignment2/model/home_user_model.dart';
// // import 'package:http/http.dart' as http;
// // // import 'package:assignment2/models/user.dart'; // Import the User model

// // class HomeService {
// //   final http.Client client;

// //   HomeService(this.client);

// //   Future<List<User>> fetchUsers({int page = 1}) async {
// //     final response = await client.get(Uri.parse('https://reqres.in/api/users?page=$page'));

// //     if (response.statusCode == 200) {
// //       final data = json.decode(response.body);
// //       final List<dynamic> usersJson = data['data'];
// //       return usersJson.map((json) => User.fromJson(json)).toList();
// //     } else {
// //       throw Exception('Failed to load users');
// //     }
// //   }
// // }
import 'package:assignment2/model/home_user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeService {
  final http.Client httpClient;

  HomeService(this.httpClient);

  Future<List<User>> fetchUsers({int? page}) async {
    final url = page != null 
      ? 'https://reqres.in/api/users?page=$page'
      : 'https://reqres.in/api/users?page=1';
    
    final response = await httpClient.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> usersJson = data['data'];
      return usersJson.map((json) => User.fromJson(json)).toList();
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
