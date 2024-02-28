import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:mobile_learning/pages/home_page.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

  String email="", password="";
  TextEditingController mailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  userLogin()async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      // Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage() ));
      Navigator.pushNamed(context, '/homepage');
    }on FirebaseAuthException catch(e){
      if(e.code=='user-not-found'){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "No User Found for that Email",
              style: TextStyle(fontSize: 18.0),
            )));
    }else if(e.code=='wrong-password'){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            "Wrong Password Provided by User",
            style: TextStyle(fontSize: 18.0),
          )));
    }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  "https://www.bnet-tech.com/wp-content/uploads/2021/01/218_2-small.jpg",
                  fit: BoxFit.cover,
                )),
            SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 2.0, horizontal: 30.0),
                      decoration: BoxDecoration(
                          color: Color(0xFFedf0f8),
                          borderRadius: BorderRadius.circular(30)),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter E-mail';
                          }
                          return null;
                        },
                        controller: mailcontroller,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Email",
                            hintStyle: TextStyle(
                                color: Color(0xFFb2b7bf), fontSize: 18.0)),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 2.0, horizontal: 30.0),
                      decoration: BoxDecoration(
                          color: Color(0xFFedf0f8),
                          borderRadius: BorderRadius.circular(30)),
                      child: TextFormField(
                        controller: passwordcontroller,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Password';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Password",
                            hintStyle: TextStyle(
                                color: Color(0xFFb2b7bf), fontSize: 18.0)),
                   obscureText: true,   ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    GestureDetector(
                      onTap: (){
                        if(_formkey.currentState!.validate()){
                          setState(() {
                            email= mailcontroller.text;
                            password=passwordcontroller.text;
                          });
                        }
                        userLogin();
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(
                              vertical: 13.0, horizontal: 30.0),
                          decoration: BoxDecoration(
                              color: Color(0xFF273671),
                              borderRadius: BorderRadius.circular(30)),
                          child: Center(
                              child: Text(
                            "Log In",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22.0,
                                fontWeight: FontWeight.w500),
                          ))),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            // GestureDetector(
            //   onTap: (){
            //     Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgotPassword()));
            //   },
            //   child: Text("Forgot Password?",
            //       style: TextStyle(
            //           color: Color(0xFF8c8e98),
            //           fontSize: 18.0,
            //           fontWeight: FontWeight.w500)),
            // ),
            // SizedBox(
            //   height: 40.0,
            // ),
            // Text(
            //   "or LogIn with",
            //   style: TextStyle(
            //       color: Color(0xFF273671),
            //       fontSize: 22.0,
            //       fontWeight: FontWeight.w500),
            // ),
            // SizedBox(
            //   height: 30.0,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     GestureDetector(
            //       onTap: (){
            //         AuthMethods().signInWithGoogle(context);
            //       },
            //       child: Image.asset(
            //         "images/google.png",
            //         height: 45,
            //         width: 45,
            //         fit: BoxFit.cover,
            //       ),
            //     ),
            //     SizedBox(
            //       width: 30.0,
            //     ),
            //     GestureDetector(
            //       onTap: (){
            //         AuthMethods().signInWithApple();
            //       },
            //       child: Image.asset(
            //         "images/apple1.png",
            //         height: 50,
            //         width: 50,
            //         fit: BoxFit.cover,
            //       ),
            //     )
            //   ],
            // ),
            // SizedBox(
            //   height: 40.0,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text("Don't have an account?",
            //         style: TextStyle(
            //             color: Color(0xFF8c8e98),
            //             fontSize: 18.0,
            //             fontWeight: FontWeight.w500)),
            //     SizedBox(
            //       width: 5.0,
            //     ),
            //     GestureDetector(
            //       onTap: () {
            //         Navigator.push(context,
            //             MaterialPageRoute(builder: (context) => SignUp()));
            //       },
            //       child: Text(
            //         "SignUp",
            //         style: TextStyle(
            //             color: Color(0xFF273671),
            //             fontSize: 20.0,
            //             fontWeight: FontWeight.w500),
            //       ),
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:google_sign_in/google_sign_in.dart';

// class LoginPage extends StatelessWidget {
//   final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

//   LoginPage({Key? key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Login with Google'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () => _handleSignIn(context),
//           child: const Text('Sign in with Google'),
//         ),
//       ),
//     );
//   }

//   void _handleSignIn(BuildContext context) async {
//     try {
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//       if (googleUser != null) {
//         final authentication = await googleUser.authentication;
//         final idToken = authentication.idToken;

//         final response = await http.get(
//           Uri.parse('https://stem-backend.vercel.app/auth/google/callback'),
//           headers: {'Authorization': 'Bearer $idToken'},
//         );

//         if (response.statusCode == 200) {
//           // Handle successful authentication
//           Navigator.pushReplacementNamed(context, '/');
//         } else {
//           // Handle authentication failure
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Authentication failed')),
//           );
//         }
//       } else {
//         // Handle Google Sign-In failure
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Google Sign-In failed')),
//         );
//       }
//     } catch (error) {
//       print('Google Sign-In Error: $error');
//       // Handle Google Sign-In error
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Google Sign-In Error')),
//       );
//     }
//   }
// }
