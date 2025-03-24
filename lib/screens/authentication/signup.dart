import 'package:firebase_auth/firebase_auth.dart';
import 'package:face/constants/constants.dart';
import 'package:face/screens/authentication/login.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _signupKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  // Firebase Auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _createUser() async {
   
      try {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: _email.text.trim(),
          password: _password.text.trim(),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("User Created Successfully")),
        );

        // Redirect to login screen or home screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } on FirebaseAuthException catch (e) {
        String errorMessage = "An error occurred";
        if (e.code == 'weak-password') {
          errorMessage = 'The password is too weak';
        } else if (e.code == 'email-already-in-use') {
          errorMessage = 'The account already exists for that email';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: background,
      body: SafeArea(
        child: SizedBox(
          height: height,
          child: Stack(
            children: [
              Container(color: navyBlue, height: height * 0.3, width: width),
              Positioned(
                top: height * 0.1,
                left: width * 0.1,
                child: Container(
                  width: width * 0.8,
                  height: height * 0.7, // Increased height for better visibility
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(color: lightBlue, spreadRadius: 1, blurRadius: 1)
                    ],
                    color: background,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Form(
                    key: _signupKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: height * 0.05), // Adjusted the top margin
                          Text(
                            "Sign UP",
                            style: TextStyle(
                              fontSize: fontlg,
                              color: navyBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20),
                          _buildTextField("Name", _name, Icons.person),
                          SizedBox(height: 16),
                          _buildTextField("Phone", _phone, Icons.phone, isPhone: true),
                          SizedBox(height: 16),
                          _buildTextField("E-mail", _email, Icons.email),
                          SizedBox(height: 16),
                          _buildTextField("Password", _password, Icons.lock, isPassword: true),
                          SizedBox(height: 40),
                          Container(
                            width: width * 0.7,
                            height: height * 0.07, // Increased button height for better usability
                            decoration: BoxDecoration(
                              color: navyBlue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextButton(
                              
                              onPressed: _createUser,
                              child: Text(
                                "Create Account",
                                style: TextStyle(fontSize: 18, color: background),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: height * 0.05, // Adjusted position to be more flexible
                left: width * 0.25,
                child: Row(
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                          color: const Color.fromARGB(255, 148, 148, 148)),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                      child: Text(
                        " Sign In",
                        style: TextStyle(
                            color: navyBlue, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable method to build text fields
  Widget _buildTextField(String label, TextEditingController controller, IconData icon, {bool isPhone = false, bool isPassword = false}) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        label: Text(label, style: TextStyle(color: blue)),
        focusColor: blue,
        prefixIcon: Icon(icon, color: blue),
        hintStyle: TextStyle(color: blue),
        prefix: isPhone ? const Text("+962 ", style: TextStyle(color: Colors.black45, fontSize: 18)) : null,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $label';
        }
        if (isPhone && !RegExp(r"^\+962\d{8}$").hasMatch(value)) {
          return 'Invalid phone number format';
        }
        if (isPassword && value.length < 6) {
          return 'Password must be at least 6 characters long';
        }
        return null;
      },
    );
  }
}
