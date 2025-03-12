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
                top: height * 0.14,
                left: width * 0.11,
                child: Container(
                  width: width * 0.8,
                  height: height * 0.6,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: lightBlue, spreadRadius: 1, blurRadius: 1)
                    ],
                    color: background,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Form(
                    key: _signupKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 16),
                          Text(
                            "Sign UP",
                            style: TextStyle(
                              fontSize: fontlg,
                              color: navyBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            controller: _name,
                            decoration: InputDecoration(
                              label:
                                  Text("Name", style: TextStyle(color: blue)),
                              focusColor: blue,
                              // hintText: "E-mail or Phone",
                              prefixIcon: Icon(Icons.person, color: blue),
                              hintStyle: TextStyle(color: blue),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            controller: _phone,
                            decoration: InputDecoration(
                              label:
                                  Text("Phone", style: TextStyle(color: blue)),
                              focusColor: blue,
                              prefix: const Text(
                                "+962 ",
                                style: TextStyle(
                                    color: Colors.black45, fontSize: 18),
                              ),
                              // hintText: "E-mail or Phone",
                              prefixIcon: Icon(Icons.phone, color: blue),
                              hintStyle: TextStyle(color: blue),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Phone';
                              } else if (!RegExp(r"/^\+?[1-9][0-9]{7,14}$/")
                                  .hasMatch(value)) {
                                return 'Invalid email format';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            controller: _email,
                            decoration: InputDecoration(
                              label:
                                  Text("E-mail", style: TextStyle(color: blue)),
                              focusColor: blue,
                              prefixIcon: Icon(Icons.email, color: blue),
                              hintStyle: TextStyle(color: blue),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your E-mail';
                              } else if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z]+",
                              ).hasMatch(value)) {
                                return 'Invalid email format';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            controller: _password,
                            obscureText: true,
                            decoration: InputDecoration(
                              label: Text("Password",
                                  style: TextStyle(color: blue)),
                              focusColor: blue,
                              // hintText: "E-mail or Phone",
                              prefixIcon: Icon(Icons.lock, color: blue),
                              hintStyle: TextStyle(color: blue),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              } else if (!RegExp(
                                r"/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@.#$!%*?&])[A-Za-z\d@.#$!%*?&]{8,15}$/",
                              ).hasMatch(value)) {
                                return 'Invalid password format';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 40),
                          Container(
                            width: width * 0.7,
                            height: height * 0.05,
                            decoration: BoxDecoration(
                              color: navyBlue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextButton(
                              onPressed: () {
                                if (_signupKey.currentState!.validate()) {
                                  _signupKey.currentState!.save();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          "Form Submitted { $_name, $_email, $_phone }"),
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                "Create Account ",
                                style:
                                    TextStyle(fontSize: 18, color: background),
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
                top: height * 0.8,
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
}
