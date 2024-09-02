import 'package:assignment2/bloc/login_bloc.dart';
import 'package:assignment2/events/login_event.dart';
import 'package:assignment2/states/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Key to identify the form
  final _formKey = GlobalKey<FormState>(); //?
  // to take email input from textfield
  final TextEditingController _emailController = TextEditingController();
   // to take email input from textfield
  final TextEditingController _passwordController = TextEditingController();
  //toggle forpassword visbility
  bool _obscureText = true;
  // late indicating that this variable will be initialized later 
  late LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 200,
        // to rebmove that back button on left top corner of the page 
        automaticallyImplyLeading: false,
        // to create flexible space in the app bar we have used it so that we can have cmplex widgets in app bar as well
        flexibleSpace: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Padding(
            padding: EdgeInsets.only(top: 50,left: 8) ,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Inloggen", style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold)),
                Text("Log in met uw inloggegevens", style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
        ),
      ),
      //bloc provider makes bloc availablefor all its child widget
      body: BlocProvider(
        //create returns instance of bloc
        create: (context) => _loginBloc,
        //bloc consumer handels the listener and builder when state changes 
        child: BlocConsumer<LoginBloc, LoginState>(
          //listenr is a call back function it is called when state changes it has two parameter represents current state and and current context
          listener: (context, state) {
            if (state is LoginSuccess) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
              //snack bar shows that login is succesfull
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Login Successful.'), backgroundColor: const Color.fromARGB(255, 110, 173, 246)),
              );
            } else if (state is LoginFailure) {
              //snackbar to show that login faliure occured 
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error), backgroundColor: const Color.fromARGB(255, 255, 48, 7)),
              );
            }
          },
          builder: (context, state) {
            // used to create layout dynamically 
            return LayoutBuilder(
              builder: (context, constraints) {
                // extract width from constraints 
                double screenWidth = constraints.maxWidth;

                return 
                 Center(
                  child:
                   Container(
                  
                    // responsive with based on screen size 
                    width: screenWidth > 600 ? 400 : screenWidth * 0.9,
                    //conent inside the container has 20px width
                    padding: const EdgeInsets.all(20),

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      //giving default border color 
                      border: Border.all(color: Colors.grey.shade300), 
                    ),
                    child: Form(
                      //here if we use this autovalidate mode then if we start interacting with component of the container rest will give error 
                      // autovalidateMode: AutovalidateMode.onUserInteraction,

                      //this form key is the our key wich uniquely identify the form
                      key: _formKey, 
                      child: Column(
                        // to take minimum space 
                        mainAxisSize: MainAxisSize.min,
                        //to start from left side in horizontal axis 
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         
                              const Padding(
                                padding: EdgeInsets.only(bottom: 8),
                                child: Text(
                                  "Email",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              TextFormField(
                                // real time validation when user interacts with the field 
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                //to access input from textfield 
                                controller: _emailController,
                                //styling of inout field
                                decoration: InputDecoration(
                                  // it shows that email icon inside the textfield
                                  prefixIcon: Icon(Icons.email),
                                  //to give corner of a textfield a rounde shape
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  //it is used when user interacts with the text field so the border color will b changed
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.amber, width: 2),
                                  ),
                                  
                                ),
                                //it checks validation for input that the email is in proper formate or not 
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                                    return 'Enter a valid email';
                                  }
                                  return null;
                                },
                              ),
                         //togive space between text field and next component
                          SizedBox(height: 16),
                          
                              const Padding(
                                //to give spacebetween text andits below text field 
                                padding: EdgeInsets.only(bottom: 8),
                                child: Text(
                                  "Password",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              TextFormField(
                                // for real time validation based on input 
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                // to acccess the value form textfield 
                                controller: _passwordController,
                                // to hide the password at initial level
                                obscureText: _obscureText,
                                // styling of text field
                                decoration: InputDecoration(
                                  // icon showing at start of the text field 
                                  prefixIcon: Icon(Icons.key),
                                  //evey icon for toggle visibility 
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      //it replaces icon based on obscureText variable its default value is true 
                                      _obscureText ? Icons.visibility_off : Icons.visibility,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.amber, width: 2),
                                  ),
                                ),
                                validator: (value) {
                                  // validates  the value should not be null
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                   // (?=.) ensure that patern must be present (*) ensure that patter can be at any position in the string ([a-z]) ensure that patter form this alphabates 
                                  if (!RegExp(r'(?=.*[a-z])').hasMatch(value)) {
                                    return 'Password must contain at least one lowercase letter';
                                  }
                                  //validates for cpaital letters 
                                  if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
                                    return 'Password must contain at least one uppercase letter';
                                  }
                                  //validates for number
                                  if (!RegExp(r'(?=.*\d)').hasMatch(value)) {
                                    return 'Password must contain at least one number';
                                  }
                                  //validates for special character 
                                  if (!RegExp(r'(?=.*[@$!%*?&])').hasMatch(value)) {
                                    return 'Password must contain at least one special character';
                                  }
                                  //validates for for length of Password
                                  if (value.length < 8) {
                                    return 'Password must be at least 8 characters';
                                  }
                                  return null;
                                },
                              ),
                         
                          SizedBox(height: 20),
                          Align(
                            // to be visbile from right to left 
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                // Navigate to registration page
                              },
                              child: const Text(
                                "Don't have an account? Register",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            height: 50,
                            // to take all the available space 
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                //id the value is not null it will execute the function
                                if (_formKey.currentState?.validate() ?? false) {
                                  _loginBloc.add(
                                    LoginSubmitted(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    ),
                                  );
                                }
                              },
                              //styling the elevated button
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                "InLoggen",
                                style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                   
                  ),


                );



              },
            );
          },
        ),
      ),
    );
  }
}






































// import 'package:assignment2/bloc/login_bloc.dart';
// import 'package:assignment2/events/login_event.dart';
// import 'package:assignment2/states/login_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'home.dart';

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _formKey = GlobalKey<FormState>(); // Key to identify the form
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _obscureText = true;
//   late LoginBloc _loginBloc;

//   @override
//   void initState() {
//     super.initState();
//     _loginBloc = LoginBloc();
//   }

//   @override
//   void dispose() {
//     _loginBloc.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         flexibleSpace: const Padding(
//           padding: EdgeInsets.only(left: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text("Login", style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold)),
//               Text("Welcome to the Login", style: TextStyle(fontSize: 12)),
//             ],
//           ),
//         ),
//       ),
//       body: BlocProvider(
//         create: (context) => _loginBloc,
//         child: BlocConsumer<LoginBloc, LoginState>(
//           listener: (context, state) {
//             if (state is LoginSuccess) {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => HomePage()),
//               );
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text('Login Successful.'), backgroundColor: const Color.fromARGB(255, 91, 231, 206)),
//               );
//             } else if (state is LoginFailure) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text(state.error), backgroundColor: Colors.amber.withOpacity(0.02)),
//               );
//             }
//           },
//           builder: (context, state) {
//             return LayoutBuilder(
//               builder: (context, constraints) {
//                 double screenWidth = constraints.maxWidth;

//                 return Center(
//                   child: Container(
//                     width: screenWidth > 600 ? 400 : screenWidth * 0.9,
//                     padding: const EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(color: Colors.grey.shade300), // Optional border
//                     ),
//                     child: Form(
//                       // autovalidateMode: AutovalidateMode.onUserInteraction,
//                       key: _formKey, // Assign the form key
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Padding(
//                                 padding: EdgeInsets.only(bottom: 8.0),
//                                 child: Text(
//                                   "Email",
//                                   style: TextStyle(fontSize: 15),
//                                 ),
//                               ),
//                               TextFormField(
//                                 autovalidateMode: AutovalidateMode.onUserInteraction,
//                                 controller: _emailController,
//                                 decoration: InputDecoration(
//                                   prefixIcon: Icon(Icons.email),
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                     borderSide: BorderSide(color: Colors.amber, width: 2),
//                                   ),
//                                   enabledBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                     borderSide: BorderSide(color: Colors.grey, width: 1),
//                                   ),
//                                 ),
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return 'Please enter your email';
//                                   } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//                                     return 'Enter a valid email';
//                                   }
//                                   return null;
//                                 },
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 16),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Padding(
//                                 padding: EdgeInsets.only(bottom: 8.0),
//                                 child: Text(
//                                   "Password",
//                                   style: TextStyle(fontSize: 15),
//                                 ),
//                               ),
//                               TextFormField(
//                                 autovalidateMode: AutovalidateMode.onUserInteraction,
//                                 controller: _passwordController,
//                                 obscureText: _obscureText,
//                                 decoration: InputDecoration(
//                                   prefixIcon: Icon(Icons.key),
//                                   suffixIcon: IconButton(
//                                     icon: Icon(
//                                       _obscureText ? Icons.visibility_off : Icons.visibility,
//                                     ),
//                                     onPressed: () {
//                                       setState(() {
//                                         _obscureText = !_obscureText;
//                                       });
//                                     },
//                                   ),
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                     borderSide: BorderSide(color: Colors.amber, width: 2),
//                                   ),
//                                 ),
//                                                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return 'Please enter your password';
//                                   }

//                                   if (!RegExp(r'(?=.*[a-z])').hasMatch(value)) {
//                                     return 'Password must contain at least one lowercase letter';
//                                   }
//                                   if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
//                                     return 'Password must contain at least one uppercase letter';
//                                   }
//                                   if (!RegExp(r'(?=.*\d)').hasMatch(value)) {
//                                     return 'Password must contain at least one number';
//                                   }
//                                   if (!RegExp(r'(?=.*[@$!%*?&])').hasMatch(value)) {
//                                     return 'Password must contain at least one special character';
//                                   }
//                                   if (value.length < 8) {
//                                     return 'Password must be at least 8 characters';
//                                   }
//                                   return null;
//                                 },
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 20),
//                           Align(
//                             alignment: Alignment.centerRight,
//                             child: TextButton(
//                               onPressed: () {
//                                 // Navigate to registration page
//                               },
//                               child: const Text(
//                                 "Don't have an account? Register",
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   color: Colors.blue,
//                                   decoration: TextDecoration.underline,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 20),
//                           Container(
//                             height: 50,
//                             width: double.infinity,
//                             child: ElevatedButton(
//                               onPressed: () {
//                                 if (_formKey.currentState?.validate() ?? false) {
//                                   _loginBloc.add(
//                                     LoginSubmitted(
//                                       email: _emailController.text,
//                                       password: _passwordController.text,
//                                     ),
//                                   );
//                                 }
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.amber,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                               ),
//                               child: const Text(
//                                 "Login",
//                                 style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w100),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
