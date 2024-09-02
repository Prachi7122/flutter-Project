import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}


// Event to fetch the list of users
class FetchUsers extends HomeEvent {}

// Event to fetch details of a specific user
class FetchUserDetails extends HomeEvent {
  final int userId;

  FetchUserDetails(this.userId);

  @override
  List<Object?> get props => [userId];
}
