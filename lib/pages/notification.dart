// // import 'package:assignment2/pages/home.dart';
// // import 'package:assignment2/pages/utils.dart';
// // import 'package:assignment2/service/home_service.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:intl/intl.dart';
// // import 'package:assignment2/bloc/home_bloc.dart'; // Adjust the path as needed
// // import 'package:assignment2/pages/home_user_details.dart'; // Adjust the path as needed
// // import 'package:http/http.dart' as http;

// // class NotificationHomePage extends StatefulWidget {
// //   @override
// //   _NotificationHomePageState createState() => _NotificationHomePageState();
// // }

// // class _NotificationHomePageState extends State<NotificationHomePage> {
// //   late HomeBloc _homeBloc;

// //   @override
// //   void initState() {
// //     super.initState();
// //     final httpClient = http.Client();
// //     final homeService = HomeService(httpClient);
// //     _homeBloc = HomeBloc(homeService);
// //     _homeBloc.add(LoadUsers());
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final dateFormat = DateFormat('yyyy-MM-dd');
// //     final currentDate = DateTime.now();
// //     final formattedDate = dateFormat.format(currentDate);

// //     return Scaffold(
// //       appBar: AppBar(
        
           
// //         automaticallyImplyLeading: false,
// //         title: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 IconButton(
// //                   icon: Icon(Icons.menu, color: Colors.white),
// //                   onPressed: () {
// //                     openFullScreenDrawer(context);
// //                   },
// //                 ),

// //                  IconButton(
// //               icon: Icon(Icons.close, color: Colors.white,),
// //               onPressed: () {
// //                 // Navigator.of(context).pop();
// //                 Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
// //               },
// //             ),
              
// //               ],
// //             ),
// //             Text('Notifications', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
// //             Text(
// //               'Here are your notifications',
// //               style: TextStyle(fontSize: 14, color: Colors.white70),
// //             ),
// //           ],
// //         ),
// //         toolbarHeight: 100,
// //         backgroundColor: Colors.blueAccent,
// //       ),
// //       body: BlocProvider(
// //         create: (context) => _homeBloc,
// //         child: BlocBuilder<HomeBloc, HomeState>(
// //           builder: (context, state) {
// //             if (state is HomeLoading) {
// //               return Center(child: CircularProgressIndicator());
// //             } else if (state is HomeLoaded) {
// //               return ListView.builder(
// //                 padding: EdgeInsets.all(16.0),
// //                 itemCount: state.users.length,
// //                 itemBuilder: (context, index) {
// //                   final user = state.users[index];

// //                   return Card(
// //                     elevation: 5,
// //                     margin: EdgeInsets.symmetric(vertical: 8.0),
// //                     child: ListTile(
// //                       contentPadding: EdgeInsets.all(16.0),
// //                       leading: CircleAvatar(
// //                         backgroundImage: NetworkImage(user.avatar),
// //                       ),
// //                       title: Text('${user.firstName} ${user.lastName}'),
// //                       subtitle: Text(user.email),
// //                       trailing: Icon(Icons.arrow_forward_ios),
// //                       onTap: () {
// //                         Navigator.push(
// //                           context,
// //                           MaterialPageRoute(
// //                             builder: (context) => UserDetailsPage(user: user),
// //                           ),
// //                         );
// //                       },
// //                     ),
// //                   );
// //                 },
// //               );
// //             } else {
// //               return Center(child: Text('Failed to load notifications'));
// //             }
// //           },
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:assignment2/pages/home.dart';
// import 'package:assignment2/pages/utils.dart';
// import 'package:assignment2/service/home_service.dart';
// import 'package:assignment2/states/home_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:assignment2/bloc/home_bloc.dart'; // Adjust the path as needed
// import 'package:assignment2/pages/home_user_details.dart'; // Adjust the path as needed
// import 'package:http/http.dart' as http;

// class NotificationHomePage extends StatefulWidget {
//   @override
//   _NotificationHomePageState createState() => _NotificationHomePageState();
// }

// class _NotificationHomePageState extends State<NotificationHomePage> {
//   late HomeBloc _homeBloc;

//   @override
//   void initState() {
//     super.initState();
//     final httpClient = http.Client();
//     final homeService = HomeService(httpClient);
//     _homeBloc = HomeBloc(homeService);
//     _homeBloc.add(LoadUsers());
//   }

//   @override
//   Widget build(BuildContext context) {
//     final dateFormat = DateFormat('yyyy-MM-dd');
//     final currentDate = DateTime.now();
//     final formattedDate = dateFormat.format(currentDate);

//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.menu, color: Colors.white),
//                   onPressed: () {
//                     openFullScreenDrawer(context);
//                   },
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.close, color: Colors.white),
//                   onPressed: () {
//                     Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
//                   },
//                 ),
//               ],
//             ),
//             Text('Notifications', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
//             Text(
//               'Here are your notifications',
//               style: TextStyle(fontSize: 14, color: Colors.white70),
//             ),
//           ],
//         ),
//         toolbarHeight: 100,
//         backgroundColor: Colors.amber,
//       ),
//       body: Stack(
//         children: [
//           // Positioned background at the top of the screen
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             height: MediaQuery.of(context).size.height / 10, // Adjust the height as needed
//             child: Container(
//               color: Colors.amber, // Background color
//             ),
//           ),
//           // Positioned body content
//           Positioned.fill(
//             top: MediaQuery.of(context).size.height / 150, // Offset for the background
//             child: BlocProvider(
//               create: (context) => _homeBloc,
//               child: BlocBuilder<HomeBloc, HomeState>(
//                 builder: (context, state) {
//                   if (state is HomeLoading) {
//                     return Center(child: CircularProgressIndicator());
//                   } else if (state is HomeLoaded) {
//                     return ListView.builder(
//                       padding: EdgeInsets.all(16.0),
//                       itemCount: state.users.length,
//                       itemBuilder: (context, index) {
//                         final user = state.users[index];

//                         return Card(
//                           elevation: 5,
//                           margin: EdgeInsets.symmetric(vertical: 8.0),
//                           child: ListTile(
//                             contentPadding: EdgeInsets.all(16.0),
//                             leading: CircleAvatar(
//                               backgroundImage: NetworkImage(user.avatar),
//                             ),
//                             title: Text('${user.firstName} ${user.lastName}'),
//                             subtitle: Text(user.email),
                            
//                           ),
//                         );
//                       },
//                     );
//                   } else {
//                     return Center(child: Text('Failed to load notifications'));
//                   }
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
