import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:users_app/widgets/loading_dialog.dart';

import '../methods/common_methods.dart';
import '../pages/home_page.dart';
import 'login_screen.dart';

// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});

//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   TextEditingController userNametextEditingController = TextEditingController();
//   TextEditingController emailtextEditingController = TextEditingController();
//   TextEditingController passwordtextEditingController = TextEditingController();
//   TextEditingController userPhonetextEditingController =
//       TextEditingController();
//   CommonMethods cMethods = CommonMethods();

//   checkIfNetworkIsAvailable() {
//     cMethods.checkConnectivity(context);
//     signUpFormValidation();
//   }

//   signUpFormValidation() {
//     if (userNametextEditingController.text.trim().length < 3) {
//       cMethods.displaySnackBar(
//           'Your name must be atleast 4 or more characters', context);
//     } else if (userPhonetextEditingController.text.trim().length < 7) {
//       cMethods.displaySnackBar(
//           'Your phone number must be atleast 8 or more characters', context);
//     } else if (!emailtextEditingController.text.contains('@')) {
//       cMethods.displaySnackBar('Please enter a valid email', context);
//     } else if (passwordtextEditingController.text.trim().length < 5) {
//       cMethods.displaySnackBar(
//           'Your password must be atleast 6 or more characters', context);
//     } else {
//       registerNewUser();
//     }
//   }

//   registerNewUser() async {
//     showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext context) =>
//             LoadingDialog(messageText: 'Registering your account.....'));

//     // ignore: unused_local_variable
//     final User? userFirebase = (await FirebaseAuth.instance
//             .createUserWithEmailAndPassword(
//       email: emailtextEditingController.text.trim(),
//       password: passwordtextEditingController.text.trim(),
//     )
//             .catchError((errorMsg) {
//       Navigator.pop(context);
//       cMethods.displaySnackBar(errorMsg, context);
//     }))
//         .user;

//     if (context.mounted) return;
//     Navigator.pop(context);
//     DatabaseReference usersRef = FirebaseDatabase.instance
//         .ref()
//         .child('users')
//         .child('userFirebase.uid');
//     // ignore: unused_local_variable
//     Map userDataMap = {
//       'name': userNametextEditingController.text.trim(),
//       'email': emailtextEditingController.text.trim(),
//       'phone': userPhonetextEditingController.text.trim(),
//       'id': userFirebase!.uid,
//       'blockStatus': 'no',
//     };
//     usersRef.set(userDataMap);

//     Navigator.push(
//         context, MaterialPageRoute(builder: (c) => const HomePage()));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(10),
//           child: Column(
//             children: [
//               Image.asset('assets/images/logo.png'),
//               const Text(
//                 'Create a User Account',
//                 style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
//               ),
//               //textfield-buton
//               Padding(
//                 padding: const EdgeInsets.all(22),
//                 child: Column(
//                   children: [
//                     TextField(
//                       controller: userNametextEditingController,
//                       keyboardType: TextInputType.emailAddress,
//                       decoration: const InputDecoration(
//                         labelText: 'User Name',
//                         labelStyle: TextStyle(fontSize: 14, color: Colors.grey),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 22,
//                     ),
//                     TextField(
//                       controller: userPhonetextEditingController,
//                       keyboardType: TextInputType.emailAddress,
//                       decoration: const InputDecoration(
//                         labelText: 'Phone Number',
//                         labelStyle: TextStyle(fontSize: 14, color: Colors.grey),
//                       ),
//                     ),
//                     const SizedBox(height: 22),
//                     TextField(
//                       controller: emailtextEditingController,
//                       keyboardType: TextInputType.emailAddress,
//                       decoration: const InputDecoration(
//                         labelText: 'Email',
//                         labelStyle: TextStyle(fontSize: 14, color: Colors.grey),
//                       ),
//                     ),
//                     const SizedBox(height: 22),
//                     TextField(
//                       controller: passwordtextEditingController,
//                       obscureText: true,
//                       keyboardType: TextInputType.emailAddress,
//                       decoration: const InputDecoration(
//                         labelText: 'Password',
//                         labelStyle: TextStyle(fontSize: 14, color: Colors.grey),
//                       ),
//                     ),
//                     const SizedBox(height: 32),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.purple,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 80, vertical: 20),
//                       ),
//                       onPressed: () {
//                         checkIfNetworkIsAvailable();
//                       },
//                       child: const Text(
//                         'Sign Up',
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               //already have an account

//               const SizedBox(
//                 height: 12,
//               ),
//               TextButton(
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const LoginScreen()));
//                 },
//                 child: const Text(
//                   'Already have an account? Login here',
//                   style: TextStyle(
//                     color: Colors.grey,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController userNameTextEditingController = TextEditingController();
  TextEditingController userPhoneTextEditingController =
      TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  CommonMethods cMethods = CommonMethods();

  checkIfNetworkIsAvailable() {
    cMethods.checkConnectivity(context);

    signUpFormValidation();
  }

  signUpFormValidation() {
    if (userNameTextEditingController.text.trim().length < 3) {
      cMethods.displaySnackBar(
          "your name must be atleast 4 or more characters.", context);
    } else if (userPhoneTextEditingController.text.trim().length < 7) {
      cMethods.displaySnackBar(
          "your phone number must be atleast 8 or more characters.", context);
    } else if (!emailTextEditingController.text.contains("@")) {
      cMethods.displaySnackBar("please write valid email.", context);
    } else if (passwordTextEditingController.text.trim().length < 5) {
      cMethods.displaySnackBar(
          "your password must be atleast 6 or more characters.", context);
    } else {
      registerNewUser();
    }
  }

  registerNewUser() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) =>
          LoadingDialog(messageText: "Registering your account..."),
    );

    final User? userFirebase = (await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
      email: emailTextEditingController.text.trim(),
      password: passwordTextEditingController.text.trim(),
    )
            .catchError((errorMsg) {
      Navigator.pop(context);
      cMethods.displaySnackBar(errorMsg.toString(), context);
    }))
        .user;

    if (!context.mounted) return;
    Navigator.pop(context);

    DatabaseReference usersRef =
        FirebaseDatabase.instance.ref().child("users").child(userFirebase!.uid);
    Map userDataMap = {
      "name": userNameTextEditingController.text.trim(),
      "email": emailTextEditingController.text.trim(),
      "phone": userPhoneTextEditingController.text.trim(),
      "id": userFirebase.uid,
      "blockStatus": "no",
    };
    usersRef.set(userDataMap);

    Navigator.push(context, MaterialPageRoute(builder: (c) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Image.asset("assets/images/logo.png"),

              const Text(
                "Create a User\'s Account",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              //text fields + button
              Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  children: [
                    TextField(
                      controller: userNameTextEditingController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: "User Name",
                        labelStyle: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    TextField(
                      controller: userPhoneTextEditingController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: "User Phone",
                        labelStyle: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    TextField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: "User Email",
                        labelStyle: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    TextField(
                      controller: passwordTextEditingController,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: "User Password",
                        labelStyle: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        checkIfNetworkIsAvailable();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 80, vertical: 10)),
                      child: const Text("Sign Up"),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 12,
              ),

              //textbutton
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => const LoginScreen()));
                },
                child: const Text(
                  "Already have an Account? Login Here",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
