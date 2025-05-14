import 'package:flutter/material.dart';

// الألوان الجديدة
const Color kPrimaryDarkBlue = Color(0xFF0A0E2D); // كحلي (أزرق غامق)
const Color kAccentOrange = Color.fromARGB(255, 243, 119, 3); // برتقالي
const Color kBackgroundColor = Color(0xFF0A0E2D);

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phonenumber = TextEditingController();

  Future<void> _signUp() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();
    String name = _nameController.text.trim();
    String phone = _phonenumber.text.trim();

    if (password != confirmPassword) {
      _showMessage("كلمة المرور غير متطابقة!");
      return;
    }

    _showMessage("تم إنشاء الحساب بنجاح!");
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: kAccentOrange,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        title: const Text(
          "إنشاء حساب جديد",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: kAccentOrange,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Image.asset(
              "assets/logo.png",
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 30),
            _buildTextField("الاسم الكامل", Icons.person, TextInputType.text,
                controller: _nameController),
            const SizedBox(height: 30),
            _buildTextField("رقم الهاتف", Icons.phone, TextInputType.phone,
                controller: _phonenumber),
            const SizedBox(height: 20),
            _buildTextField(
                "البريد الإلكتروني", Icons.email, TextInputType.emailAddress,
                controller: _emailController),
            const SizedBox(height: 20),
            _buildTextField("كلمة المرور", Icons.lock, TextInputType.text,
                obscureText: true, controller: _passwordController),
            const SizedBox(height: 20),
            _buildTextField("تأكيد كلمة المرور", Icons.lock, TextInputType.text,
                obscureText: true, controller: _confirmPasswordController),
            const SizedBox(height: 60),
            ElevatedButton(
              onPressed: _signUp,
              style: ElevatedButton.styleFrom(
                backgroundColor: kAccentOrange,
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "إنشاء حساب",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: kBackgroundColor,
    );
  }

  Widget _buildTextField(String label, IconData icon, TextInputType inputType,
      {bool obscureText = false, TextEditingController? controller}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey, fontSize: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: kAccentOrange,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: kAccentOrange,
            width: 2,
          ),
        ),
        prefixIcon: Icon(icon, color: kAccentOrange),
      ),
      keyboardType: inputType,
      obscureText: obscureText,
    );
  }
}
