
import 'package:equatable/equatable.dart';
// equatable is used to compare the equality of objects basen on their properties not on their refrence 
abstract class LoginEvent extends Equatable {
  //constructor
  const LoginEvent();

  @override
  // getter method hre we spacify on which propertieds we have to compare the content 
  List<Object> get props => [];
}

class LoginSubmitted extends LoginEvent {
  final String email;
  final String password;

  const LoginSubmitted({required this.email, required this.password});
  // overriding getter method of equatable class 
  @override
  List<Object> get props => [email, password];
}



