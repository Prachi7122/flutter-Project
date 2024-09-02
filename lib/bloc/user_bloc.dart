import 'package:assignment2/model/home_user_model.dart';
import 'package:assignment2/service/user_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:assignment2/events/user_event.dart';
import 'package:assignment2/states/user_state.dart';


class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService userService;
  int _currentPage = 1;
  bool _hasNextPage = true;
                              // setting bloc initial state as user initial state 
  UserBloc(this.userService) : super(UserInitial()) {
    on<LoadUsers>((event, emit) async {
      try {
        // Determine which page to load if event page is null current pafge will be loaded 
        final pageToLoad = event.page ?? _currentPage;

        // Fetch users based on the current page
        final response = await userService.fetchUsers(page: pageToLoad);
        // extracting users from api response 
        final users = response['users'] as List<User>;
        //updating hasNext page 
        _hasNextPage = response['hasNextPage'] as bool;

        // Update pagination state
        if (pageToLoad == 1) {
          emit(UserLoaded(
            users: users,
            currentPage: _currentPage,
            hasNextPage: _hasNextPage,
          ));
        } else {
          //if page is not 1 subsequent page will be load 
          final currentState = state;
          if (currentState is UserLoaded) {
            emit(UserLoaded(
              users: [...currentState.users, ...users],
              currentPage: pageToLoad,
              hasNextPage: _hasNextPage,
            ));
          }
        }
        _currentPage = pageToLoad;
      } catch (error) {
        emit(UserError('Failed to load users: $error'));
      }
    });

    on<LoadUserDetails>((event, emit) async {
      emit(UserLoading());
      try {
        // on the basis of user id fetching user details 
        final user = await userService.fetchUserDetails(event.userId);
        //emitting state t show user details after loading 
        emit(UserDetailsLoaded(user));
      } catch (error) {
        emit(UserError('Failed to load user details: $error'));
      }
    });
  }
}
