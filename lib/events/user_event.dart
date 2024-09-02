// abstract class UserEvent {}

// class LoadUsers extends UserEvent {
//   final int? page;

//   LoadUsers({this.page});
// }

// class LoadUserDetails extends UserEvent {
//   final int userId;

//   LoadUserDetails(this.userId);
// }
abstract class UserEvent {}

class LoadUsers extends UserEvent {
  final int? page;

  LoadUsers({this.page});
}

class LoadUserDetails extends UserEvent {
  final int userId;

  LoadUserDetails(this.userId);
}

class LoadNextPage extends UserEvent {}
