// // import 'package:assignment2/model/home_user_model.dart';

// // import 'package:equatable/equatable.dart';

// // abstract class HomeState extends Equatable {
// //   @override
// //   List<Object?> get props => [];
// // }

// // // State when HomePage is first loaded
// // class HomeInitial extends HomeState {}

// // // State when data is being loaded
// // class HomeLoading extends HomeState {}

// // // State when user data is successfully loaded
// // class HomeLoaded extends HomeState {
// //   // here it represents list of users 
// //   final List<User> users;

// //   HomeLoaded(this.users, {required List<User> users});
  
// //   @override
// //   List<Object?> get props => [users];
// // }

// // // State when there is an error loading users
// // class HomeError extends HomeState {
// //   final String error;

// //   HomeError(this.error, {required String message});
  
// //   @override
// //   List<Object?> get props => [error];

// //   get message => null;
// // }

// // // State when HomeDetailsPage is first loaded
// // class HomeDetailsInitial extends HomeState {}

// // // State when details of a user are being loaded
// // class HomeDetailsLoading extends HomeState {}

// // // State when user details are successfully loaded
// // class HomeDetailsLoaded extends HomeState {
// //   final User user;

// //   HomeDetailsLoaded(this.user);
// //   //overriding getter of equatable 
// //   @override
// //   List<Object?> get props => [user];
// // }

// // // State when there is an error loading user details
// // class HomeDetailsError extends HomeState {
// //   final String error;
  
// //   HomeDetailsError(this.error);

// //   @override
// //   List<Object?> get props => [error];
// // }
// import 'package:assignment2/model/home_user_model.dart';
// import 'package:equatable/equatable.dart';


// abstract class HomeState extends Equatable {
//   @override
//   List<Object?> get props => [];
// }

// // State when HomePage is first loaded
// class HomeInitial extends HomeState {}

// // State when data is being loaded
// class HomeLoading extends HomeState {}

// // State when user data is successfully loaded
// class HomeLoaded extends HomeState {
//   final List<User> users;

//   HomeLoaded(this.users);  // Correct constructor definition

//   @override
//   List<Object?> get props => [users];
// }

// // State when there is an error loading users
// class HomeError extends HomeState {
//   final String error;

//   HomeError(this.error);
  
//   @override
//   List<Object?> get props => [error];

//   get message => null;
// }

// // State when HomeDetailsPage is first loaded
// class HomeDetailsInitial extends HomeState {}

// // State when details of a user are being loaded
// class HomeDetailsLoading extends HomeState {}

// // State when user details are successfully loaded
// class HomeDetailsLoaded extends HomeState {
//   final User user;

//   HomeDetailsLoaded(this.user);

//   @override
//   List<Object?> get props => [user];
// }

// // State when there is an error loading user details
// class HomeDetailsError extends HomeState {
//   final String error;
  
//   HomeDetailsError(this.error);

//   @override
//   List<Object?> get props => [error];
// }
 import 'package:assignment2/model/home_user_model.dart';

abstract class HomeEvent {}

class LoadUsers extends HomeEvent {
  final int? page;

  LoadUsers({this.page});
}

class LoadUserDetails extends HomeEvent {
  final int userId;

  LoadUserDetails(this.userId);
}

// States
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<User> users;

  HomeLoaded(this.users);
}

class HomeDetailsLoaded extends HomeState {
  final User user;

  HomeDetailsLoaded(this.user);
}

class HomeError extends HomeState {
  final String error;

  HomeError(this.error);
}
