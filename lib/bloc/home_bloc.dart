import 'package:assignment2/service/home_service.dart';
import 'package:assignment2/states/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Bloc
class HomeBloc extends Bloc<HomeEvent, HomeState> 
//implementation of bloc to convert home even into home state 
{
  final HomeService homeService;
   // initializing home service : intializing bloc with home homeinitial
  HomeBloc(this.homeService) : super(HomeInitial()) {
    on<LoadUsers>((event, emit) async {
      emit(HomeLoading());
      try {
        //calling api to fetch users list
        final users = await homeService.fetchUsers(page: event.page);
        //if we found users then this loaded state emit 
        emit(HomeLoaded(users));
      } catch (error) {
        // if found error printt it 
        emit(HomeError('Failed to load users'));
      }
    });

    on<LoadUserDetails>((event, emit) async {
      emit(HomeLoading());
      try {//it will fetch the users detai;s as per user id 
        final user = await homeService.fetchUserDetails(event.userId);
        // after succesfully getting user details 
        emit(HomeDetailsLoaded(user));
      } catch (error) {
        emit(HomeError('Failed to load user details'));
      }
    });
  }
}
