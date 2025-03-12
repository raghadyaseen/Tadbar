import 'package:face/constants/constants.dart';
import 'package:face/screens/authentication/login.dart';
import 'package:flutter/material.dart';

class Forgotpassword extends StatefulWidget {
  const Forgotpassword({super.key});

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  final _forgotPassword = GlobalKey<FormState>();

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
                  height: height * 0.3,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: lightBlue, spreadRadius: 1, blurRadius: 1)
                    ],
                    color: background,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Form(
                    key: _forgotPassword,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 16),
                          Text(
                            "FORGOT PASSWORD",
                            style: TextStyle(
                              fontSize: fontlg,
                              color: navyBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Confirm your email and we will send the instruction",
                            style: TextStyle(
                                fontSize: fontxs, color: Colors.black45),
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            decoration: InputDecoration(
                              label:
                                  Text("E-mail", style: TextStyle(color: blue)),
                              focusColor: blue,
                              // hintText: "E-mail or Phone",
                              prefixIcon: Icon(Icons.email, color: blue),
                              hintStyle: TextStyle(color: blue),
                            ),
                          ),
                          SizedBox(height: 25),
                          Container(
                            width: width * 0.7,
                            height: height * 0.04,
                            decoration: BoxDecoration(
                              color: navyBlue,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                "RESET PASSWORD",
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
                top: height * 0.5,
                left: width * 0.35,
                child: Row(
                  children: [
                    Icon(Icons.arrow_back, size: fontmd, color: navyBlue),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                      child: Text(
                        " Back to login",
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
