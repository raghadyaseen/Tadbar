import 'package:face/constants/constants.dart';
import 'package:face/screens/home/facescanner.dart';
import 'package:face/screens/home/idcardscanner.dart';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Map<String, String>> _options = [
    {"title": "ScanID", "image": 'assets/images/cardscan.jpg'},
    {"title": "FaceID", "image": 'assets/images/scanfase.png'},
  ];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white, // لون خلفية مريح للعين
        appBar: AppBar(
          backgroundColor: Colors.white, // لون أزرق للـ AppBar
          title: Image.asset(
            "assets/images/logotext.png",
            height: height * 0.3, // تكبير الصورة
            fit: BoxFit.contain,
          ),
          centerTitle: true,
          elevation: 0, // إزالة الظل
        ),
        body: Column(
          children: [
            // حقل البحث
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search by Name or ID", // نص الإرشاد
                  prefixIcon:
                      Icon(Icons.search, color: Colors.blue), // أيقونة البحث
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
            ),
            // المربعات
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(20), // إضافة padding حول المربعات
                physics: NeverScrollableScrollPhysics(), // إزالة التمرير
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, // عدد الأعمدة (مربع واحد في الصف)
                  mainAxisSpacing: 20.0, // المسافة بين الصفوف
                  childAspectRatio: 2, // نسبة العرض إلى الارتفاع للمربعات
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      if (index == 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => IdCardScanner()),
                        );
                      } else if (index == 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FaceScanner()),
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            height: height * 0.1, // تكبير الصور داخل المربعات
                            "${_options[index]["image"]}",
                            fit: BoxFit.contain,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "${_options[index]["title"]}",
                            style: TextStyle(
                              fontSize: fontmd,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: _options.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
