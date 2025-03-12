import 'package:face/constants/constants.dart';
import 'package:face/screens/authentication/forgotpassword.dart';
import 'package:face/screens/authentication/signup.dart';
import 'package:face/screens/home/home.dart'; // تأكد من استيراد صفحة HomeScreen
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  void _login() {
    // يمكنك إضافة التحقق من صحة البيانات هنا قبل الانتقال إلى HomeScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );
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
                top: height * 0.14,
                left: width * 0.11,
                child: Container(
                  width: width * 0.8,
                  height: height * 0.5,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: lightBlue, spreadRadius: 1, blurRadius: 1)
                    ],
                    color: background,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Form(
                    key: _loginKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 16),
                          Text(
                            "Login",
                            style: TextStyle(
                              fontSize: fontlg,
                              color: navyBlue,
                              fontWeight: FontWeight.bold,
                            ),
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
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            controller: _password,
                            obscureText: true,
                            decoration: InputDecoration(
                              label: Text("Password",
                                  style: TextStyle(color: blue)),
                              focusColor: blue,
                              prefixIcon: Icon(Icons.lock, color: blue),
                              hintStyle: TextStyle(color: blue),
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Forgotpassword()),
                                  );
                                },
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                      color: navyBlue,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 40),
                          Container(
                            width: width * 0.7,
                            height: height * 0.05,
                            decoration: BoxDecoration(
                              color: navyBlue,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextButton(
                              onPressed: _login, // استدعاء دالة تسجيل الدخول
                              child: Text(
                                "Login",
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
                top: height * 0.7,
                left: width * 0.25,
                child: Row(
                  children: [
                    Text(
                      "No account yet?",
                      style: TextStyle(
                          color: const Color.fromARGB(255, 148, 148, 148)),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupScreen()),
                        );
                      },
                      child: Text(
                        " Create one",
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
