import 'package:assignment2/events/home_event.dart';
import 'package:assignment2/pages/home_add.dart';
import 'package:assignment2/pages/notification.dart';
import 'package:assignment2/states/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:assignment2/bloc/home_bloc.dart';
import 'package:assignment2/service/home_service.dart';
import 'package:assignment2/pages/home_user_details.dart';
import 'package:assignment2/pages/utils.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc _homeBloc;
  final PageController _pageController = PageController(viewportFraction: 0.9);

  @override
  void initState() {
    super.initState();
    final httpClient = http.Client();
    final homeService = HomeService(httpClient);
    _homeBloc = HomeBloc(homeService);
    _homeBloc.add(LoadUsers());
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy-MM-dd');
    final currentDate = DateTime.now();
    final formattedDate = dateFormat.format(currentDate);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.menu, color: Colors.white),
                  onPressed: () {
                    openFullScreenDrawer(context);
                  },
                ),
                // IconButton(
                //   icon: Icon(Icons.notifications, color: Colors.white,),

                //   onPressed: () {
                //     // Navigator.push(context,MaterialPageRoute(builder: (context)=>NotificationHomePage()));
                //     // Handle notifications
                //   },
                  
                // ),
                Stack(
  children: [
    IconButton(
      icon: Icon(Icons.notifications, color: Colors.white),
      onPressed: () {
        // Handle notifications
      },
    ),
    Positioned(
      right: 11,
      top: 11,
      child: Container(
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(6),
        ),
        constraints: BoxConstraints(
          minWidth: 10,
          minHeight: 10,
        ),
      ),
    ),
  ],
)

              ],
            ),
            Text('Home', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
            Text(
              'Welcome! Nice to see you again',
              style: TextStyle(fontSize: 14, color: Colors.white70),
            ),
          ],
        ),
        toolbarHeight: 100,
        backgroundColor: Colors.blueAccent,
      ),
      body: BlocProvider(
        create: (context) => _homeBloc,
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is HomeLoaded) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Users Heading
                    Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribute space evenly between the children
  children: [
    Expanded(
      child: _buildSectionHeading('VerbeterSuggesties'),
    ),
    IconButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeAdd()));
        // Add your onPressed functionality here
      },
      icon: Icon(Icons.add_circle, color: Colors.blue,),
      tooltip: 'Add', // Optional: Provides a tooltip on hover or long press
    ),
  ],
),

                    SizedBox(height: 10),

                    // User Cards Section
                    Container(
                      height: 300, // Fixed height to ensure visibility
                      child: PageView.builder(
                        controller: _pageController,
                        scrollDirection: Axis.horizontal,
                        itemCount: state.users.length,
                        itemBuilder: (context, index) {
                          final user = state.users[index];

                          return LayoutBuilder(
                            builder: (context, constraints) {
                              return Card(
                                // margin: EdgeInsets.symmetric(vertical: 50.0, horizontal: 8.0), 
                                margin: EdgeInsets.only(top: 8.0 , bottom: 8.0 , left: 8.0, right: 8.0),
                                //// Reduced margin
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity, // Full width of the card
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(255, 102, 173, 231), // Background color
                                        borderRadius: BorderRadius.vertical(top: Radius.circular(12)), // Same border radius as card
                                      ),
                                      padding: EdgeInsets.all(16.0), // Padding inside the colored area
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundImage: NetworkImage(user.avatar),
                                            radius: 20, // Decreased size of the avatar
                                          ),
                                          SizedBox(width: 16),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${user.firstName} ${user.lastName}',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white, // Text color for better contrast
                                                  ),
                                                ),
                                                Text(
                                                  user.email,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white, // Text color for better contrast
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: const Icon(
                                              Icons.check_circle_outline, // Checkmark inside a circle
                                              color: Colors.white, // Color of the icon
                                              size: 24, // Size of the icon
                                            ),
                                            padding: EdgeInsets.all(8), // Padding inside the circle
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0), // Padding for the content below the blue area
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
                                                        
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Text(
                                                      formattedDate,
                                                      style: TextStyle(fontSize: 14,
                                                      fontWeight: FontWeight.bold,),
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
                                                        
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Text(
                                                      formattedDate,
                                                      style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              children: [
                                                const Text(
                                                  'Status',
                                                ),
                                                SizedBox(width: 20,),
                                                Text(
                                                  '           Lopend',
                                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            const Row(
                                              children: [
                                                Text(
                                                  'Order Status',
                                                ),
                                                SizedBox(width: 20,),
                                                Text(
                                                  '  In order',
                                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                const Text(
                                                  'Analyseer lange doorlooptijd ',
                                                  style: TextStyle(fontSize: 16),
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
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),

                    // SizedBox(height: 15),

                    // Score Heading
                    _buildSectionHeading('Score'),
                    SizedBox(height: 15),

                  LayoutBuilder(
  builder: (context, constraints) {
    double cardWidth = constraints.maxWidth * 0.9; // Match width proportionally

    return Center(
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          width: cardWidth, // Set the width of the card
          child: Padding(
            padding: const EdgeInsets.all(16.0),
           child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    // Icon and text row
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Center the row items
      children: [
        Image.asset(
          'assets/score_icon.png',
          height: 50,
          width: 50,
        ),
        
        const Text(
          '65',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color: Colors.amber,
          ),
        ),
      ],
    ),
    SizedBox(height: 10,),
    const Text(
      'Goed bezig. #1 Emma Green!',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
  ],
),

          ),
        ),
      ),
    );
  },
),


                    // SizedBox(height: 20),

                    // Mood Indicator Heading
                    _buildSectionHeading('Moodindicator'),
                    SizedBox(height: 10),

 LayoutBuilder(
  builder: (context, constraints) {
    double cardWidth = constraints.maxWidth * 0.9;
    double iconSize = constraints.maxWidth * 0.1;
    double textSize = constraints.maxWidth * 0.02;
    double spacing = constraints.maxWidth * 0.02;
    double runSpacing = constraints.maxWidth * 0.01;

    return Center(
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          width: cardWidth,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
              'Hoeveel plezier heb je momenteel in je werk?',
                style: TextStyle(
                  fontSize: 18, // Responsive font size
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Row(
                // spacing: spacing, // Responsive horizontal spacing
                // runSpacing: runSpacing, // Responsive vertical spacing
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios, size: 15,color: Colors.grey)),
                  // Heart icon
                  Column(
                    children: [
                      Icon(Icons.favorite, size: iconSize, color: Colors.grey), // Responsive size
                      Text('6', style: TextStyle(fontSize: 15, color: Colors.grey)), // Responsive text size
                    ],
                  ),
                  // Smiley face with hearts
                  Column(
                    children: [
                      Icon(Icons.sentiment_very_satisfied, size: iconSize, color: Colors.grey), // Responsive size
                      Text('7', style: TextStyle(fontSize: 15,color: Colors.grey)), // Responsive text size
                    ],
                  ),
                  // Smiley face
                  Column(
                    children: [
                      Icon(Icons.sentiment_satisfied, size: iconSize, color: Colors.yellow), // Responsive size
                      Text('8', style: TextStyle(fontSize: 15,color: Colors.black)), // Responsive text size
                    ],
                  ),
                  // Alternative smiley face
                  Column(
                    children: [
                      Icon(Icons.sentiment_satisfied_alt, size: iconSize, color: Colors.grey), // Responsive size
                      Text('9', style: TextStyle(fontSize: 15,color: Colors.grey)), // Responsive text size
                    ],
                  ),
                  // Neutral face
                  Column(
                    children: [
                      Icon(Icons.sentiment_neutral, size: iconSize, color: Colors.grey), // Responsive size
                      Text('10', style: TextStyle(fontSize: 15,color: Colors.grey)), // Responsive text size
                    ],
                  ),
                   IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios,size: 15,color: Colors.grey,)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  },
),






                  ],
                ),
              );
            } else if (state is HomeError) {
              return Center(child: Text('Error: ${state.error}'));
            } else {
              return Center(child: Text('No Data'));
            }
          },
        ),
      ),
    );
  }


Widget _buildSectionHeading(String title) {
  return LayoutBuilder(
    builder: (context, constraints) {
      double padding = constraints.maxWidth * 0.05; // Adjust padding as a percentage of screen width
      return Padding(
        padding: EdgeInsets.only(left: padding,top: padding,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20, // Responsive font size
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4), // Adjust height as needed
            Container(
              height: 2,
              width: 50, // Adjust width as a percentage of screen width
              color: Colors.blue, // Blue underline
            ),
          ],
        ),
      );
    },
  );
}

}






