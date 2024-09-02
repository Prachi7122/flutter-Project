import 'dart:convert'; 
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:assignment2/events/login_event.dart';
import 'package:assignment2/states/login_state.dart';
import 'package:http/http.dart' as http; 

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  // Event handler for LoginSubmitted event
  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    //state for loading is emiting 
    emit(LoginLoading());

    try {

      final response = await _authenticateUser(event.email, event.password);

      if (response.statusCode == 200) {
        // Assuming the API returns a successful status code for valid credentials
        emit(LoginSuccess());
      } else {
        // Handle different API error statuses here
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        //if error key is not fould then this will be print
        final errorMessage = responseBody['error'] ?? 'Unknown error occurred';
        emit(LoginFailure(error: errorMessage));
      }
    } catch (exp) {
      // Handle any exception that occur during the HTTP request
      emit(LoginFailure(error: 'An error occurred while logging in: $exp'));
    }
  }

  // Function to authenticate user via API
  Future<http.Response> _authenticateUser(String email, String password) async {
     // API to sen request 
    final url = Uri.parse('https://reqres.in/api/login'); 
    // sending http post reqrest
    final response = await http.post(
      url,
      // content type is json
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      // it telles which user is trying to login
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    return response;
  }
}
