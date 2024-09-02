import 'package:assignment2/model/home_user_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting date

class UserDetailsPage extends StatelessWidget {
  final User user;

  const UserDetailsPage({required this.user});

  // Function to get the current date formatted
  String getCurrentDateFormatted() {
    // to get current date 
    final DateTime now = DateTime.now();
    // formatting the date 
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(now);
  }

  @override
  Widget build(BuildContext context) {
    String currentDate = getCurrentDateFormatted();

    return Scaffold(
      appBar: AppBar(
        // to remove back button
        automaticallyImplyLeading: false,
        //to increase app bar height
        toolbarHeight: 150,
        //to add multiple widgets in titile
        title: Padding(
          padding: const EdgeInsets.only(top: 40, left: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back_ios, color: Colors.white,)),
                const Text('VerbeterSuggestie\n Details',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
            ],
          ),
        ),
        backgroundColor: Colors.amber,
      ),
      body: Stack(
        children: [
          // Background color
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height / 15, // Adjust height for background
            child: Container(
              color: Colors.amber, // Background color
            ),
          ),
          // Main content
          Align(
            alignment: Alignment.topCenter,
            // for bilding the dynamic layout
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  // to limit the child constraints 
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      // Max width as 90% of screen width
                      maxWidth: constraints.maxWidth * 0.9, 
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Common container for both cards
                        Container(
                          width: double.infinity, // Ensures the container takes up full width within constraints
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // User Details Card
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  // elevation: 4.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Center(
                                          child: CircleAvatar(
                                            backgroundImage: NetworkImage(user.avatar),
                                            radius: 50,
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        Center(
                                          child: Text(
                                            '${user.firstName} ${user.lastName}',
                                            style: Theme.of(context).textTheme.titleLarge,
                                          ),
                                        ),
                                        Divider(), // Divider after the name
                                        const SizedBox(height: 8),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'First Name',
                                              style: Theme.of(context).textTheme.bodyMedium,
                                            ),
                                            Text(
                                              '${user.firstName}',
                                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(), // Divider after the first name
                                        SizedBox(height: 8),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Last Name',
                                              style: Theme.of(context).textTheme.bodyMedium,
                                            ),
                                            Text(
                                              '${user.lastName}',
                                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(), // Divider after the last name
                                        SizedBox(height: 16),

                                        // Row for Start Date and End Date
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
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
                                                    currentDate,
                                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,),
                                                  ),
                                                  // Line below Start Date
                                                  Container(
                                                    margin: EdgeInsets.only(left: 0, right: 30),
                                                    height: 1,
                                                    color: const Color.fromARGB(255, 225, 224, 224), // Color of the line
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'End Date:',
                                                    style: TextStyle(
                                                      
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    currentDate,
                                                    style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,),
                                                  ),
                                                  // Line below End Date
                                                  Container(
                                                    margin: EdgeInsets.only(left: 0, right: 30),
                                                    height: 1,
                                                    color: const Color.fromARGB(255, 218, 215, 215), // Color of the line
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(height: 16),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Email',
                                              style: Theme.of(context).textTheme.bodyMedium,
                                            ),
                                             Text(
                                              '${user.email}',
                                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(), // Divider after the email
                                        SizedBox(height: 8),
                                        Column(
                                          children: [
                                            Text(
                                              'ID',
                                              style: Theme.of(context).textTheme.bodyMedium,
                                            ),
                                            Text(
                                              '${user.id}',
                                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(), // Divider after the ID
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // Status Card
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: double.infinity, // Ensures the width is the same as the User Details Card
                                  child: Card(
                                    // elevation: 4.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          
                                          SizedBox(height: 8),
                                          Column(
                                            
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Ok status',
                                                style: Theme.of(context).textTheme.bodyMedium,
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    'IN Order',
                                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  IconButton(
                                                    icon: Icon(Icons.check_circle_outline, color: Colors.green),
                                                    onPressed: () {},
                                                  ),
                                                ],
                                              ),
   



                                            ],

                                          ),
                                                                                                                   SizedBox(height: 5),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                            'Status',
                                            style: Theme.of(context).textTheme.titleSmall,
                                          ),
                                                  Row(
                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                      children: [
                                                                        // Normal icons
                                                                        Row(
                                                                          children: [
                                                                            IconButton(
                                                                              icon: Icon(Icons.favorite_border_outlined, size:  25),
                                                                              onPressed: () {},
                                                                            ),
                                                                            IconButton(
                                                                              icon: Icon(Icons.forward_outlined, size:  25),
                                                                              onPressed: () {},
                                                                            ),
                                                                            IconButton(
                                                                              icon: Icon(Icons.supervised_user_circle_outlined, size:  25),
                                                                              onPressed: () {},
                                                                            ),
                                                                            IconButton(
                                                                              icon: Icon(Icons.message_outlined, size:  25),
                                                                              onPressed: () {},
                                                                            ),
                                                                            IconButton(
                                                                              icon: Icon(Icons.more_horiz, size:  25),
                                                                              onPressed: () {},
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        // Spacer to push the yellow icon to the end
                                                                        Spacer(),
                                                                        IconButton(
                                                                          icon: Icon(Icons.circle_outlined, color: Colors.amber, size: 25),
                                                                          onPressed: () {},
                                                                        ),
                                                                      ],
                                                                    ),
                                                ],
                                              ),

                                          
                    ],
          ),
         ),
       ),

                                  
     ),
   ),
   SizedBox(height: 16),
               Text(
                 'Related Actions',
                 style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold
                 ),
               ),
                Container(
              height: 2,
              width: 50, // Adjust width as a percentage of screen width
              color: Colors.amber, // Blue underline
            ),
                                          SizedBox(height: 8),
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    border: Border.all(
                                                      color: Colors.grey
                                                    )
                                                    
                                                  ),
                                                  child: Text('Test double acthouler'),
                                                  
                                                ),
                                                SizedBox(width: 8),
                                                Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    border: Border.all(
                                                      color: Colors.grey
                                                    )
                                                    
                                                  ),
                                                  child: Text('uitizoken'),
                                                  
                                                ),
                                                SizedBox(width: 8),
                                                Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    border: Border.all(
                                                      color: Colors.grey
                                                    )
                                                    
                                                  ),
                                                  child: Text('Test double acthouler'),
                                                  
                                                ),
                                                SizedBox(width: 8),
                                                Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    border: Border.all(
                                                      color: Colors.grey
                                                    )
                                                    
                                                  ),
                                                  child: Text('Test double acthouler'),
                                                  
                                                ),
                                                SizedBox(width: 8),
                                               Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    border: Border.all(
                                                      color: Colors.grey
                                                    )
                                                    
                                                  ),
                                                  child: Text('Test double acthouler'),
                                                  
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    
    );
  }
}









