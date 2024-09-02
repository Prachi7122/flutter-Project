// import 'package:assignment2/model/home_user_model.dart';

// abstract class UserState {}

// class UserInitial extends UserState {}

// class UserLoading extends UserState {}

// class UserLoaded extends UserState {
//   final List<User> users;

//   UserLoaded(this.users);
// }

// class UserDetailsLoaded extends UserState {
//   final User user;

//   UserDetailsLoaded(this.user);
// }

// class UserError extends UserState {
//   final String error;

//   UserError(this.error);
// }
import 'package:assignment2/model/home_user_model.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<User> users;
  final bool hasNextPage;
  final int currentPage;

  UserLoaded({
    required this.users,
    required this.hasNextPage,
    required this.currentPage,
  });
}


class UserDetailsLoaded extends UserState {
  final User user;

  UserDetailsLoaded(this.user);
}
class UserError extends UserState {
  final String message;

  UserError(this.message);
}

