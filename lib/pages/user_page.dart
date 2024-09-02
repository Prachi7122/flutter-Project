

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:assignment2/bloc/user_bloc.dart';
import 'package:assignment2/events/user_event.dart';
import 'package:assignment2/states/user_state.dart';
import 'package:assignment2/service/user_service.dart';
import 'package:assignment2/pages/home_user_details.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class UserPage extends StatefulWidget {
  final VoidCallback showCustomDrawer;

  UserPage({required this.showCustomDrawer});

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late UserBloc _userBloc;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    final httpClient = http.Client();
    final userService = UserService(httpClient);
    _userBloc = UserBloc(userService);

    // Initialize ScrollController
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          final currentState = _userBloc.state;
          if (currentState is UserLoaded && currentState.hasNextPage) {
            _userBloc.add(LoadUsers(page: currentState.currentPage! + 1));
          }
        }
      });

    // Add LoadUsers event to the bloc
    _userBloc.add(LoadUsers());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override





  
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy-MM-dd');
    final currentDate = DateTime.now();
    final formattedDate = dateFormat.format(currentDate);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.amber,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.menu, color: Colors.white),
                  onPressed: widget.showCustomDrawer,
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.search, color: Colors.white),
                      onPressed: () {
                        // Add search functionality if needed
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.tune, color: Colors.white),
                      onPressed: () {
                        // Add filter functionality if needed
                      },
                    ),
                  ],
                ),
              ],
            ),
            Text('VerbeterSuggesties', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
        toolbarHeight: 100,
      ),
      body: BlocProvider(
        create: (context) => _userBloc,
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.circle_outlined,
                            color: Colors.amber,
                            size: 35,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Open',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'assets/in_progress_icon.png',
                            color: Colors.blue,
                            width: 30,
                            height: 30,
                          ),
                          SizedBox(width: 4),
                          const Text(
                            'Loopt',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      const Row(
                        children: [
                          Icon(
                            Icons.check_circle_outline,
                            color: Colors.green,
                            size: 35,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Gereet',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),



                
                Expanded(
  child: Builder(
    builder: (context) {
      // Check if loading the first page or fetching more data
      if (state is UserLoading) {
        if (state is UserInitial || 
            (state is UserLoaded && (state as UserLoaded).currentPage == 1)) {
          // Show CircularProgressIndicator for the initial load
          return Center(child: CircularProgressIndicator());
        } 
      }
      
      // ListView for displaying user data
      return ListView.builder(
        controller: _scrollController,
        itemCount: (state is UserLoaded ? state.users.length : 0) + 1,
        itemBuilder: (context, index) {
          // Show CircularProgressIndicator only when fetching more data
          if (state is UserLoaded && index == (state as UserLoaded).users.length) {
            // Do not show the indicator if it's the second page or later
            if ((state as UserLoaded).currentPage ==2)
            
             {
              return Container(); // Return an empty container instead of the indicator
            }
            return Center(child: CircularProgressIndicator());
          }
          
          if (state is UserLoaded) {
            final user = state.users[index];

            return Card(
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                    ),
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(user.avatar),
                          radius: 20,
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${user.firstName} ${user.lastName}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                user.email,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Start Date:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  formattedDate,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                            SizedBox(width: 50,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'End Date:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  formattedDate,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Analyser lange doorlooptijd',
                              style: TextStyle(fontSize: 16,),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UserDetailsPage(user: user),
                                    ),
                                  );
                                },
                                child: Icon(Icons.arrow_forward_ios, size: 24),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    height: 1,
                    color: Colors.grey, // Color of the line
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Normal icons
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.favorite_border_outlined, size: 30),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.forward_outlined, size: 30),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.supervised_user_circle_outlined, size: 30),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.message_outlined, size: 30),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.more_horiz, size: 30),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      // Spacer to push the yellow icon to the end
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.circle_outlined, color: Colors.amber, size: 30),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            );
          }

          return Container();
        },
      );
    },
  ),
)

              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){}, child: Icon(Icons.add,color: Colors.white,weight: 90, size: 40,),backgroundColor: Colors.amber,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:assignment2/bloc/user_bloc.dart';
// import 'package:assignment2/events/user_event.dart';
// import 'package:assignment2/states/user_state.dart';
// import 'package:assignment2/service/user_service.dart';
// import 'package:assignment2/pages/home_user_details.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';

// class UserPage extends StatefulWidget {
//   final VoidCallback showCustomDrawer;

//   UserPage({required this.showCustomDrawer});

//   @override
//   _UserPageState createState() => _UserPageState();
// }

// class _UserPageState extends State<UserPage> {
//   late UserBloc _userBloc;
//   late ScrollController _scrollController;

//   @override
//   void initState() {
//     super.initState();
//     final httpClient = http.Client();
//     final userService = UserService(httpClient);
//     _userBloc = UserBloc(userService);

//     // Initialize ScrollController
//     _scrollController = ScrollController()
//       ..addListener(() {
//         if (_scrollController.position.pixels ==
//             _scrollController.position.maxScrollExtent) {
//           final currentState = _userBloc.state;
//           if (currentState is UserLoaded && currentState.hasNextPage) {
//             _userBloc.add(LoadUsers(page: currentState.currentPage! + 1));
//           }
//         }
//       });

//     // Add LoadUsers event to the bloc
//     _userBloc.add(LoadUsers());
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override





  
//   Widget build(BuildContext context) {
//     final dateFormat = DateFormat('yyyy-MM-dd');
//     final currentDate = DateTime.now();
//     final formattedDate = dateFormat.format(currentDate);

//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.amber,
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.menu, color: Colors.white),
//                   onPressed: widget.showCustomDrawer,
//                 ),
//                 Row(
//                   children: [
//                     IconButton(
//                       icon: Icon(Icons.search, color: Colors.white),
//                       onPressed: () {
//                         // Add search functionality if needed
//                       },
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.tune, color: Colors.white),
//                       onPressed: () {
//                         // Add filter functionality if needed
//                       },
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             Text('VerbeterSuggesties', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//           ],
//         ),
//         toolbarHeight: 100,
//       ),
//       body: BlocProvider(
//         create: (context) => _userBloc,
//         child: BlocBuilder<UserBloc, UserState>(
//           builder: (context, state) {
//             return Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Row(
//                         children: [
//                           Icon(
//                             Icons.circle_outlined,
//                             color: Colors.amber,
//                             size: 35,
//                           ),
//                           SizedBox(width: 4),
//                           Text(
//                             'Open',
//                             style: TextStyle(fontSize: 20),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Image.asset(
//                             'assets/in_progress_icon.png',
//                             color: Colors.blue,
//                             width: 30,
//                             height: 30,
//                           ),
//                           SizedBox(width: 4),
//                           const Text(
//                             'Loopt',
//                             style: TextStyle(fontSize: 20),
//                           ),
//                         ],
//                       ),
//                       const Row(
//                         children: [
//                           Icon(
//                             Icons.check_circle_outline,
//                             color: Colors.green,
//                             size: 35,
//                           ),
//                           SizedBox(width: 4),
//                           Text(
//                             'Gereet',
//                             style: TextStyle(fontSize: 20),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: state is UserLoading && (state is UserInitial || state is UserLoaded && (state as UserLoaded).currentPage == 1)
//                       ? Center(child: CircularProgressIndicator())
//                       : ListView.builder(
//                           controller: _scrollController,
//                           itemCount: (state is UserLoaded ? state.users.length : 0) + 1,
//                           itemBuilder: (context, index) {
//                             if (state is UserLoaded && index == state.users.length) {
//                               return Center(child: CircularProgressIndicator());
//                             }

//                             if (state is UserLoaded) {
//                               final user = state.users[index];

//                               return Card(
//                                 margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
//                                 elevation: 5,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Container(
//                                       width: double.infinity,
//                                       decoration: const BoxDecoration(
//                                         color: Colors.amber,
//                                         borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
//                                       ),
//                                       padding: EdgeInsets.all(16.0),
//                                       child: Row(
//                                         children: [
//                                           CircleAvatar(
//                                             backgroundImage: NetworkImage(user.avatar),
//                                             radius: 20,
//                                           ),
//                                           SizedBox(width: 16),
//                                           Expanded(
//                                             child: Column(
//                                               crossAxisAlignment: CrossAxisAlignment.start,
//                                               children: [
//                                                 Text(
//                                                   '${user.firstName} ${user.lastName}',
//                                                   style: const TextStyle(
//                                                     fontSize: 18,
//                                                     fontWeight: FontWeight.bold,
//                                                     color: Colors.white,
//                                                   ),
//                                                 ),
//                                                 Text(
//                                                   user.email,
//                                                   style: const TextStyle(
//                                                     fontSize: 16,
//                                                     color: Colors.white,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.all(16.0),
//                                       child: Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           Row(
//                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Column(
//                                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                                 children: [
//                                                   const Text(
//                                                     'Start Date:',
//                                                     style: TextStyle(
//                                                       fontWeight: FontWeight.bold,
//                                                       fontSize: 16,
//                                                     ),
//                                                   ),
//                                                   SizedBox(height: 5),
//                                                   Text(
//                                                     formattedDate,
//                                                     style: TextStyle(fontSize: 14),
//                                                   ),
//                                                 ],
//                                               ),
//                                               Column(
//                                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                                 children: [
//                                                   const Text(
//                                                     'End Date:',
//                                                     style: TextStyle(
//                                                       fontWeight: FontWeight.bold,
//                                                       fontSize: 16,
//                                                     ),
//                                                   ),
//                                                   SizedBox(height: 5),
//                                                   Text(
//                                                     formattedDate,
//                                                     style: TextStyle(fontSize: 14),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                           SizedBox(height: 10),
//                                           Row(
//                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               const Text(
//                                                 'Show details',
//                                                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                                               ),
//                                               Align(
//                                                 alignment: Alignment.bottomRight,
//                                                 child: GestureDetector(
//                                                   onTap: () {
//                                                     Navigator.push(
//                                                       context,
//                                                       MaterialPageRoute(
//                                                         builder: (context) => UserDetailsPage(user: user),
//                                                       ),
//                                                     );
//                                                   },
//                                                   child: Icon(Icons.arrow_forward_ios, size: 24),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     Container(
//                                       margin: EdgeInsets.only(left: 10, right: 10),
//                                       height: 1,
//                                       color: Colors.grey, // Color of the line
//                                     ),
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         // Normal icons
//                                         Row(
//                                           children: [
//                                             IconButton(
//                                               icon: Icon(Icons.favorite_border_outlined, size: 15),
//                                               onPressed: () {},
//                                             ),
//                                             IconButton(
//                                               icon: Icon(Icons.forward, size: 15),
//                                               onPressed: () {},
//                                             ),
//                                             IconButton(
//                                               icon: Icon(Icons.supervised_user_circle_outlined, size: 15),
//                                               onPressed: () {},
//                                             ),
//                                             IconButton(
//                                               icon: Icon(Icons.message_outlined, size: 15),
//                                               onPressed: () {},
//                                             ),
//                                             IconButton(
//                                               icon: Icon(Icons.more_horiz, size: 15),
//                                               onPressed: () {},
//                                             ),
//                                           ],
//                                         ),
//                                         // Spacer to push the yellow icon to the end
//                                         Spacer(),
//                                         IconButton(
//                                           icon: Icon(Icons.circle_outlined, color: Colors.amber, size: 20),
//                                           onPressed: () {},
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             }

//                             return Container();
//                           },
//                         ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
































































// import 'package:assignment2/bloc/user_bloc.dart';
// import 'package:assignment2/events/user_event.dart';
// import 'package:assignment2/pages/home_user_details.dart';
// import 'package:assignment2/service/user_service.dart';
// import 'package:assignment2/states/user_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:assignment2/service/home_service.dart';

// class UserPage extends StatefulWidget {
//   final VoidCallback showCustomDrawer;

//   UserPage({required this.showCustomDrawer});

//   @override
//   _UserPageState createState() => _UserPageState();
// }

// class _UserPageState extends State<UserPage> {
//   late UserBloc _userBloc;
//   late ScrollController _scrollController;

//   @override
//   void initState() {
//     super.initState();
//     final httpClient = http.Client();
//     final userService = UserService(httpClient);
//     _userBloc = UserBloc(userService);

//     // Initialize ScrollController
//     _scrollController = ScrollController()
//       ..addListener(() {
//         if (_scrollController.position.pixels ==
//             _scrollController.position.maxScrollExtent) {
//           _userBloc.add(LoadUsers(page: (_userBloc.state as UserLoaded).currentPage! + 1));
//         }
//       });

//     // Add LoadUsers event to the bloc
//     _userBloc.add(LoadUsers());
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final dateFormat = DateFormat('yyyy-MM-dd');
//     final currentDate = DateTime.now();
//     final formattedDate = dateFormat.format(currentDate);

//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.amber,
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.menu, color: Colors.white),
//                   onPressed: widget.showCustomDrawer,
//                 ),
//                 Row(
//                   children: [
//                     IconButton(
//                       icon: Icon(Icons.search, color: Colors.white),
//                       onPressed: () {
//                         // Add search functionality if needed
//                       },
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.tune, color: Colors.white),
//                       onPressed: () {
//                         // Add filter functionality if needed
//                       },
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             Text('VerbeterSuggesties', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//           ],
//         ),
//         toolbarHeight: 100,
//       ),
//       body: BlocProvider(
//         create: (context) => _userBloc,
//         child: BlocBuilder<UserBloc, UserState>(
//           builder: (context, state) {
//             return Column(
//               children: [
//                 // Icons and text section at the top
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Row(
//                         children: [
//                           Icon(
//                             Icons.circle_outlined,
//                             color: Colors.amber,
//                             size: 35,
//                           ),
//                           SizedBox(width: 4),
//                           Text(
//                             'Open',
//                             style: TextStyle(fontSize: 20),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Image.asset(
//                             'assets/in_progress_icon.png',
//                             color: Colors.blue,
//                             width: 30,
//                             height: 30,
//                           ),
//                           SizedBox(width: 4),
//                           const Text(
//                             'Loopt',
//                             style: TextStyle(fontSize: 20),
//                           ),
//                         ],
//                       ),
//                       const Row(
//                         children: [
//                           Icon(
//                             Icons.check_circle_outline,
//                             color: Colors.green,
//                             size: 35,
//                           ),
//                           SizedBox(width: 4),
//                           Text(
//                             'Gereet',
//                             style: TextStyle(fontSize: 20),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 // User list or any other widget
//                 Expanded(
//                   child: state is UserLoading && (state is UserInitial || state is UserLoaded && (state as UserLoaded).currentPage == 1)
//                       ? Center(child: CircularProgressIndicator())
//                       : ListView.builder(
//                           controller: _scrollController,
//                           itemCount: state is UserLoaded ? state.users.length + 1 : 0,
//                           itemBuilder: (context, index) {
//                             if (state is UserLoaded && index == state.users.length) {
//                               return Center(child: CircularProgressIndicator());
//                             }

//                             final user = state.users[index];

//                             return Card(
//                               margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
//                               elevation: 5,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Container(
//                                     width: double.infinity,
//                                     decoration: BoxDecoration(
//                                       color: Colors.amber,
//                                       borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
//                                     ),
//                                     padding: EdgeInsets.all(16.0),
//                                     child: Row(
//                                       children: [
//                                         CircleAvatar(
//                                           backgroundImage: NetworkImage(user.avatar),
//                                           radius: 20,
//                                         ),
//                                         SizedBox(width: 16),
//                                         Expanded(
//                                           child: Column(
//                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 '${user.firstName} ${user.lastName}',
//                                                 style: TextStyle(
//                                                   fontSize: 18,
//                                                   fontWeight: FontWeight.bold,
//                                                   color: Colors.white,
//                                                 ),
//                                               ),
//                                               Text(
//                                                 user.email,
//                                                 style: TextStyle(
//                                                   fontSize: 16,
//                                                   color: Colors.white,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(16.0),
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Row(
//                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Column(
//                                               crossAxisAlignment: CrossAxisAlignment.start,
//                                               children: [
//                                                 Text(
//                                                   'Start Date:',
//                                                   style: TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 16,
//                                                   ),
//                                                 ),
//                                                 SizedBox(height: 5),
//                                                 Text(
//                                                   formattedDate,
//                                                   style: TextStyle(fontSize: 14),
//                                                 ),
//                                               ],
//                                             ),
//                                             Column(
//                                               crossAxisAlignment: CrossAxisAlignment.start,
//                                               children: [
//                                                 Text(
//                                                   'End Date:',
//                                                   style: TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 16,
//                                                   ),
//                                                 ),
//                                                 SizedBox(height: 5),
//                                                 Text(
//                                                   formattedDate,
//                                                   style: TextStyle(fontSize: 14),
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                         SizedBox(height: 10),
//                                         Row(
//                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Text(
//                                               'Show details',
//                                               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                                             ),
//                                             Align(
//                                               alignment: Alignment.bottomRight,
//                                               child: GestureDetector(
//                                                 onTap: () {
//                                                   Navigator.push(
//                                                     context,
//                                                     MaterialPageRoute(
//                                                       builder: (context) => UserDetailsPage(user: user),
//                                                     ),
//                                                   );
//                                                 },
//                                                 child: Icon(Icons.arrow_forward_ios, size: 24),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Container(
//                                     margin: EdgeInsets.only(left: 10, right: 10),
//                                     height: 1,
//                                     color: Colors.grey, // Color of the line
//                                   ),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       // Normal icons
//                                       Row(
//                                         children: [
//                                           IconButton(
//                                             icon: Icon(Icons.favorite_border_outlined, size: 15),
//                                             onPressed: () {},
//                                           ),
//                                           IconButton(
//                                             icon: Icon(Icons.forward, size: 15),
//                                             onPressed: () {},
//                                           ),
//                                           IconButton(
//                                             icon: Icon(Icons.supervised_user_circle_outlined, size: 15),
//                                             onPressed: () {},
//                                           ),
//                                           IconButton(
//                                             icon: Icon(Icons.message_outlined, size: 15),
//                                             onPressed: () {},
//                                           ),
//                                           IconButton(
//                                             icon: Icon(Icons.more_horiz, size: 15),
//                                             onPressed: () {},
//                                           ),
//                                         ],
//                                       ),
//                                       // Spacer to push the yellow icon to the end
//                                       Spacer(),
//                                       IconButton(
//                                         icon: Icon(Icons.circle_outlined, color: Colors.amber, size: 20),
//                                         onPressed: () {},
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                         ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }












/* //has main code


import 'package:assignment2/bloc/user_bloc.dart';
import 'package:assignment2/events/user_event.dart'; // Import UserEvent
import 'package:assignment2/pages/home_user_details.dart';
import 'package:assignment2/states/user_state.dart'; // Import UserState
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:assignment2/service/home_service.dart';


class UserPage extends StatefulWidget {
  final VoidCallback showCustomDrawer;

  UserPage({required this.showCustomDrawer});

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late UserBloc _userBloc;

  @override
  void initState() {
    super.initState();
    final httpClient = http.Client();
    final homeService = HomeService(httpClient);
    _userBloc = UserBloc(homeService);

    // Add LoadUsers event to the bloc
    _userBloc.add(LoadUsers());
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy-MM-dd');
    final currentDate = DateTime.now();
    final formattedDate = dateFormat.format(currentDate);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.amber,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.menu, color: Colors.white,),
                  onPressed: widget.showCustomDrawer,
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.search, color: Colors.white),
                      onPressed: () {
                        // Add search functionality if needed
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.tune, color: Colors.white),
                      onPressed: () {
                        // Add search functionality if needed
                      },
                    ),
                  ],
                ),
              ],
            ),
            Text('VerbeterSuggesties', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
        toolbarHeight: 100,
      ),
      


body: BlocProvider(
  create: (context) => _userBloc,
  child: BlocBuilder<UserBloc, UserState>(
    builder: (context, state) {
      return Column(
        children: [
          // Icons and text section at the top
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    const Row(
      children: [
        Icon(
          Icons.circle_outlined,
          color: Colors.amber,
          size: 35,
        ),
        SizedBox(width: 4),
        Text(
          'Open',
          style: TextStyle(fontSize: 20),
        ),
      ],
    ),
    Row(
      children: [
        Image.asset(
          'assets/in_progress_icon.png', 
          color: Colors.blue,
          width: 30,
          height: 30,
        ),
        SizedBox(width: 4),
        const Text(
          'Loopt',
          style: TextStyle(fontSize: 20),
        ),
      ],
    ),
    const Row(
      children: [
        Icon(
          Icons.check_circle_outline,
          color: Colors.green,
          size: 35,
        ),
        SizedBox(width: 4),
        Text(
          'Gereet',
          style: TextStyle(fontSize: 20),
        ),
      ],
    ),
  ],
),

          ),

          // User list or any other widget
          Expanded(
            child: state is UserLoading
                ? Center(child: CircularProgressIndicator())
                : state is UserLoaded
                    ? ListView.builder(
                        itemCount: state.users.length,
                        itemBuilder: (context, index) {
                          final user = state.users[index];

                          return Card(
                            margin: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 8.0),
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(12)),
                                  ),
                                  padding: EdgeInsets.all(16.0),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(user.avatar),
                                        radius: 20,
                                      ),
                                      SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${user.firstName} ${user.lastName}',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              user.email,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                     
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Start Date:',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                formattedDate,
                                                style:
                                                    TextStyle(fontSize: 14),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'End Date:',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                formattedDate,
                                                style:
                                                    TextStyle(fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                     
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Show details',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        UserDetailsPage(
                                                            user: user),
                                                  ),
                                                );
                                              },
                                              child: Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: 24),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                 Container(
                                                    margin: EdgeInsets.only(left: 10, right: 10),
                                                    height: 1,
                                                    color: Colors.grey, // Color of the line
                                                  ),

         Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    // Normal icons
    Row(
      children: [
        IconButton(
          icon: Icon(Icons.favorite_border_outlined, size: 15),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.forward, size: 15),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.supervised_user_circle_outlined, size: 15),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.message_outlined, size: 15),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.more_horiz, size: 15),
          onPressed: () {},
        ),
      ],
    ),
    // Spacer to push the yellow icon to the end
    Spacer(),
    IconButton(
      icon: Icon(Icons.circle_outlined, color: Colors.amber, size: 20),
      onPressed: () {},
    ),
  ],
)

                              ],
                            ),
                          );
                        },
                      )
                    : state is UserError
                        ? Center(
                            child: Text(
                                'Failed to load users: ${state.error}'))
                        : SizedBox(), // Return an empty widget if no state matches
          ),
        ],
      );
    },
  ),
),

 
    );
  }
}



*/






      // body: 
      //     BlocProvider(
      //       create: (context) => _userBloc,
      //       child: BlocBuilder<UserBloc, UserState>(
      //         builder: (context, state) {


      //           if (state is UserLoading) {
      //             return Center(child: CircularProgressIndicator());
      //           } else if (state is UserLoaded) {
      //             return ListView.builder(
      //               itemCount: state.users.length,
      //               itemBuilder: (context, index) {
      //                 final user = state.users[index];
          
      //                 return Card(
      //                   margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      //                   elevation: 5,
      //                   shape: RoundedRectangleBorder(
      //                     borderRadius: BorderRadius.circular(12),
      //                   ),
      //                   child: Column(
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       Container(
      //                         width: double.infinity,
      //                         decoration: BoxDecoration(
      //                           color: Colors.amber,
      //                           borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      //                         ),
      //                         padding: EdgeInsets.all(16.0),
      //                         child: Row(
      //                           children: [
      //                             CircleAvatar(
      //                               backgroundImage: NetworkImage(user.avatar),
      //                               radius: 20,
      //                             ),
      //                             SizedBox(width: 16),
      //                             Expanded(
      //                               child: Column(
      //                                 crossAxisAlignment: CrossAxisAlignment.start,
      //                                 children: [
      //                                   Text(
      //                                     '${user.firstName} ${user.lastName}',
      //                                     style: TextStyle(
      //                                       fontSize: 18,
      //                                       fontWeight: FontWeight.bold,
      //                                       color: Colors.white,
      //                                     ),
      //                                   ),
      //                                   Text(
      //                                     user.email,
      //                                     style: TextStyle(
      //                                       fontSize: 16,
      //                                       color: Colors.white,
      //                                     ),
      //                                   ),
      //                                 ],
      //                               ),
      //                             ),
      //                             Container(
      //                               child: Icon(
      //                                 Icons.check_circle_outline,
      //                                 color: Colors.white,
      //                                 size: 24,
      //                               ),
      //                               padding: EdgeInsets.all(8),
      //                             ),
      //                           ],
      //                         ),
      //                       ),
      //                       Padding(
      //                         padding: const EdgeInsets.all(16.0),
      //                         child: Column(
      //                           crossAxisAlignment: CrossAxisAlignment.start,
      //                           children: [
      //                             Row(
      //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                               children: [
      //                                 Column(
      //                                   crossAxisAlignment: CrossAxisAlignment.start,
      //                                   children: [
      //                                     Text(
      //                                       'Start Date:',
      //                                       style: TextStyle(
      //                                         fontWeight: FontWeight.bold,
      //                                         fontSize: 16,
      //                                       ),
      //                                     ),
      //                                     SizedBox(height: 5),
      //                                     Text(
      //                                       formattedDate,
      //                                       style: TextStyle(fontSize: 14),
      //                                     ),
      //                                   ],
      //                                 ),
      //                                 Column(
      //                                   crossAxisAlignment: CrossAxisAlignment.start,
      //                                   children: [
      //                                     Text(
      //                                       'End Date:',
      //                                       style: TextStyle(
      //                                         fontWeight: FontWeight.bold,
      //                                         fontSize: 16,
      //                                       ),
      //                                     ),
      //                                     SizedBox(height: 5),
      //                                     Text(
      //                                       formattedDate,
      //                                       style: TextStyle(fontSize: 14),
      //                                     ),
      //                                   ],
      //                                 ),
      //                               ],
      //                             ),
      //                             SizedBox(height: 10),
      //                             Row(
      //                               children: [
      //                                 Text('Status:'),
      //                                 SizedBox(width: 8),
      //                                 Text(
      //                                   'Available',
      //                                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      //                                 ),
      //                               ],
      //                             ),
      //                             SizedBox(height: 10),
      //                             Row(
      //                               children: [
      //                                 Text('Order Status:'),
      //                                 SizedBox(width: 8),
      //                                 Text(
      //                                   'In order',
      //                                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      //                                 ),
      //                               ],
      //                             ),
      //                             SizedBox(height: 10),
      //                             Row(
      //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                               children: [
      //                                 Text(
      //                                   'Show details',
      //                                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      //                                 ),
      //                                 Align(
      //                                   alignment: Alignment.bottomRight,
      //                                   child: GestureDetector(
      //                                     onTap: () {
      //                                       Navigator.push(
      //                                         context,
      //                                         MaterialPageRoute(
      //                                           builder: (context) => UserDetailsPage(user: user),
      //                                         ),
      //                                       );
      //                                     },
      //                                     child: Icon(Icons.arrow_forward_ios, size: 24),
      //                                   ),
      //                                 ),
      //                               ],
      //                             ),
      //                           ],
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 );
      //               },
      //             );
      //           } else if (state is UserError) {
      //             return Center(child: Text('Failed to load users: ${state.error}'));
      //           }
      //           return SizedBox(); // Return an empty widget if no state matches
      //         },
      //       ),
      //     ),
        

















// import 'package:assignment2/events/user_event.dart';
// import 'package:assignment2/pages/utils.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:http/http.dart' as http;
// import 'package:assignment2/bloc/user_bloc.dart';
// import 'package:assignment2/states/user_state.dart';
// import 'package:assignment2/service/home_service.dart';


// class UserPage extends StatelessWidget {
//   final void Function(BuildContext) showCustomDrawer;

//   UserPage({required this.showCustomDrawer});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) {
//         final httpClient = http.Client();
//         final userService = HomeService(httpClient);
//         return UserBloc(userService)..add(FetchUser());
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           backgroundColor: Colors.amber,
//           title: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   IconButton(
//                     icon: Icon(Icons.menu, color: Colors.white),
//                     onPressed: () {
//                       showCustomDrawer(context); // Use the utility function
//                     },
//                   ),
//                   Row(
//                     children: [
//                       IconButton(
//                         icon: Icon(Icons.search, color: Colors.white),
//                         onPressed: () {
//                           // Add search functionality if needed
//                         },
//                       ),

//                       IconButton(
//                         icon: Icon(Icons.tune, color: Colors.white),
//                         onPressed: () {
//                           // Add search functionality if needed
//                         },
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               Text('Users', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//             ],
//           ),
//           toolbarHeight: 100,
//         ),
//         body: BlocBuilder<UserBloc, UserState>(
//           builder: (context, state) {
//             if (state is UserLoading) {
//               return Center(child: CircularProgressIndicator());
//             } else if (state is UserLoaded) {
//               final users = state.users;

//               return LayoutBuilder(
//                 builder: (context, constraints) {
//                   int crossAxisCount = constraints.maxWidth ~/ 200;
//                   crossAxisCount = crossAxisCount > 1 ? crossAxisCount : 1;

//                   return GridView.builder(
//                     padding: EdgeInsets.all(16.0),
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: crossAxisCount,
//                       childAspectRatio: 0.7,
//                       crossAxisSpacing: 16.0,
//                       mainAxisSpacing: 16.0,
//                     ),
//                     itemCount: users.length,
//                     itemBuilder: (context, index) {
//                       final user = users[index];
//                       return Card(
//                         elevation: 3,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.stretch,
//                           children: [
//                             Container(
//                               color: Colors.amber,
//                               padding: EdgeInsets.symmetric(vertical: 8.0),
//                               child: Center(
//                                 child: Text(
//                                   '${user.firstName} ${user.lastName}',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ),
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 showAvatarDialog(context, user.avatar); // Use the utility function
//                               },
//                               child: Container(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: CircleAvatar(
//                                   backgroundImage: NetworkImage(user.avatar),
//                                   radius: 50,
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.all(8.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'Email: ${user.email}',
//                                     style: TextStyle(fontSize: 14),
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                   SizedBox(height: 4.0),
//                                   Text(
//                                     'ID: ${user.id}',
//                                     style: TextStyle(fontSize: 14),
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   );
//                 },
//               );
//             } else if (state is UserError) {
//               return Center(child: Text('Error: ${state.message}'));
//             }
//             return Center(child: Text('No data available'));
//           },
//         ),
//       ),
//     );
//   }
// }
