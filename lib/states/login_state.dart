import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}
// initial state of login page when first loaded 
class LoginInitial extends LoginState {}
//login process is in progress 
class LoginLoading extends LoginState {}
//to represent the succesfull lgin
class LoginSuccess extends LoginState {}
//when request foor login is failed 
class LoginFailure extends LoginState {
  final String error;

  const LoginFailure({required this.error});
  // it repsents the error msg here we are overrrding the getter method 
  @override
  List<Object> get props => [error];
}


