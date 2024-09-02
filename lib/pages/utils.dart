import 'package:assignment2/pages/home.dart';
import 'package:flutter/material.dart';

import 'package:assignment2/pages/login.dart';
import 'package:assignment2/pages/user_page.dart';
import 'package:photo_view/photo_view.dart';

// Function to show a responsive full-screen avatar in a square format
void showAvatarDialog(BuildContext context, String avatarUrl) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      // Using MediaQuery to determine screen size
      double screenWidth = MediaQuery.of(context).size.width;
      double screenHeight = MediaQuery.of(context).size.height;
      
      // Calculate the size of the square based on the smaller dimension of the screen
      double squareSize = screenWidth < screenHeight ? screenWidth * 0.8 : screenHeight * 0.8;

      return Dialog(
        // backgroundColor: Colors.white,
        child: Container(
          width: squareSize, // Set width based on screen size
          height: squareSize, // Set height based on screen size
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10), // Optional: Rounded corners
            child: PhotoView(
              imageProvider: NetworkImage(avatarUrl),
              // to cover the image within give space 
              minScale: PhotoViewComputedScale.contained,
              // to zoomed the image 
              maxScale: PhotoViewComputedScale.covered * 2,
            ),
          ),
        ),
      );
    },
  );
}
void openFullScreenDrawer(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevents closing the drawer by tapping outside
    builder: (BuildContext context) {
      // Determine the screen width
      double screenWidth = MediaQuery.of(context).size.width;

      // Set the crossAxisCount based on the screen width
      int crossAxisCount = screenWidth < 600 ? 2 : 4; // 2 columns on mobile, 4 on desktop

      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          automaticallyImplyLeading: false, // Hide default back button
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Coimbee',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.close, color: Colors.white),
              onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage())); // Close the drawer
              },
            ),
          ],
        ),
        body: Stack(
          children: [
            // Background color for the top portion
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: MediaQuery.of(context).size.height / 10, // Further reduced height
              child: Container(
                color: Colors.amber, // Background color
              ),
            ),
            // Grid view with an offset to show background color on top
            Positioned.fill(
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 200), // Further reduced top padding
                  child: GridView.builder(
                    padding: EdgeInsets.all(16.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      childAspectRatio: 1, // Aspect ratio for the grid items
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                    ),
                    itemCount: 6, // Total number of items in the grid
                    itemBuilder: (context, index) {
                      // Define the grid items
                      List<Map<String, dynamic>> gridItems = [
                        {
                          'image': 'assets/bulb_icon.png',
                          'text': 'Verbeter-\nsuggesties',
                          'onTap': () {
                            Navigator.pop(context); // Close the drawer
                            // Navigate to UserPage
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserPage(
                                  showCustomDrawer: () => openFullScreenDrawer(context),
                                ),
                              ),
                            );
                          }
                        },
                        {
                          'image': 'assets/action_Icon.png',
                          'text': 'Minjn Acties',
                          'onTap': () {
                            Navigator.pop(context); // Close drawer
                          }
                        },
                        {
                          'image': 'assets/graph_icon.png',
                          'text': 'MoodIndicator',
                          'onTap': () {
                            Navigator.pop(context); // Close drawer
                          }
                        },
                        {
                          'image': 'assets/score_icon.png',
                          'text': 'Scores',
                          'onTap': () {
                            Navigator.pop(context); // Close drawer
                          }
                        },
                        {
                          'image': 'assets/msgs_icon.png',
                          'text': 'Berichten',
                          'onTap': () {
                            Navigator.pop(context); // Close drawer
                          }
                        },
                        {
                          'image': 'assets/settings_icon.png',
                          'text': 'Instellingen',
                          'onTap': () {
                            Navigator.pop(context); // Close drawer
                          }
                        },
                      ];

                      // Create the grid item
                      return GestureDetector(
                        onTap: gridItems[index]['onTap'],
                        child: Card(
                          elevation: 2,
                          margin: EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(gridItems[index]['image'], height: 50, width: 50), // Use Image.asset instead of Icon
                              SizedBox(height: 10),
                              Text(
                                gridItems[index]['text'],
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}


// void openFullScreenDrawer(BuildContext context) {
//   showDialog(
//     context: context,
//     barrierDismissible: false, // Prevents closing the drawer by tapping outside
//     builder: (BuildContext context) {
//       // Determine the screen width
//       double screenWidth = MediaQuery.of(context).size.width;

//       // Set the crossAxisCount based on the screen width
//       int crossAxisCount = screenWidth < 600 ? 2 : 4; // 2 columns on mobile, 4 on desktop

//       return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.amber,
//           automaticallyImplyLeading: false, // Hide default back button
//           title: Text('Menu',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
//           actions: [
//             IconButton(
//               icon: Icon(Icons.close, color: Colors.white,),
//               onPressed: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
//               },
//             ),
//           ],
//         ),
//         body: Stack(
//           children: [
//             // Background color for the top portion
//             Positioned(
//               top: 0,
//               left: 0,
//               right: 0,
//               height: MediaQuery.of(context).size.height / 10, // Further reduced height
//               child: Container(
//                 color: Colors.amber, // Background color with some opacity
//               ),
//             ),
//             // Grid view with an offset to show background color on top
//             Positioned.fill(
//               child: Align(
//                 alignment: Alignment.topCenter,
//                 child: Padding(
//                   padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 200), // Further reduced top padding
//                   child: GridView.builder(
//                     padding: EdgeInsets.all(16.0),
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: crossAxisCount,
//                       childAspectRatio: 1, // Aspect ratio for the grid items
//                       crossAxisSpacing: 16.0,
//                       mainAxisSpacing: 16.0,
//                     ),
//                     itemCount: 6, // Total number of items in the grid
//                     itemBuilder: (context, index) {
//                       // Define the grid items
//                       List<Map<String, dynamic>> gridItems = [
//                         {
//                           'image': 'assets/bulb_icon.png',
//                           'text': 'VerbeterSuggesties',
//                           'onTap': () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => UserPage(
//                                   showCustomDrawer: openFullScreenDrawer(),
//                                 ),
//                               ),
//                             ); // Clo
//                           }
//                         },
//                         {
//                           'image': 'assets/action_Icon.png',
//                           'text': 'Minjn Acties',
//                           'onTap': () {
//                             Navigator.pop(context); // Close drawer
//                           }
//                         },
//                         {
//                           'image': 'assets/graph_icon.png',
//                           'text': 'MoodIndicator',
//                           'onTap': () {
//                             Navigator.pop(context);
//                           }
//                         },
//                         {
//                           'image': 'assets/score_icon.png',
//                           'text': 'Score',
//                           'onTap': () {
//                             Navigator.pop(context); // Close drawer
//                           }
//                         },
//                         {
//                           'image': 'assets/msgs_icon.png',
//                           'text': 'Messages',
//                           'onTap': () {
//                             Navigator.pop(context); // Close drawer
//                           }
//                         },
//                         {
//                           'image': 'assets/settings_icon.png',
//                           'text': 'Settings',
//                           'onTap': () {
//                              Navigator.pop(context); 
//                             // Close drawer
//                           }
//                         },
//                       ];

//                       // Create the grid item
//                       return GestureDetector(
//                         onTap: gridItems[index]['onTap'],
//                         child: Card(
//                           elevation: 2,
//                           margin: EdgeInsets.all(8.0),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Image.asset(gridItems[index]['image'], height: 50, width: 50), // Use Image.asset instead of Icon
//                               SizedBox(height: 10),
//                               Text(
//                                 gridItems[index]['text'],
//                                 style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }
