import 'package:flutter/material.dart';
import '../auth/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // الألوان الجديدة
  final Color kPrimaryDarkBlue = const Color(0xFF0A0E2D); // كحلي (أزرق غامق)
  final Color kAccentOrange = const Color(0xFFE88F3C); // برتقالي

  // النصوص الدينية المعدلة
  final List<Map<String, dynamic>> onboardingPages = [
    {
      "title": "تطبيق مجموعات تدبّر القرءان العظيم",
      "description": "",
      "image": "assets/onbording1.png",
    },
    {
      "title":
          "وَقَالَ ٱلرَّسُولُ يَٰرَبِّ إِنَّ قَوْمِى ٱتَّخَذُوا۟ هَٰذَا ٱلْقُرْءَانَ مَهْجُورًا",
      "description": "",
      "image": "assets/onbording2.png",
    },
    {
      "title":
          "َفَلَا يَتَدَبَّرُونَ ٱلْقُرْءَانَ وَلَوْ كَانَ مِنْ عِندِ غَيْرِ ٱللَّهِ لَوَجَدُوا۟ فِيهِ ٱخْتِلَٰفًا كَثِيرًا",
      "description": "",
      "image": "assets/onbording3.png",
    },
  ];

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryDarkBlue, // الخلفية كحلي
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: onboardingPages.length,
              onPageChanged: _onPageChanged,
              itemBuilder: (context, index) {
                return OnboardingPage(
                  title: onboardingPages[index]['title'],
                  description: onboardingPages[index]['description'],
                  image: onboardingPages[index]['image'],
                  primaryColor: kAccentOrange, // اللون البرتقالي
                  backgroundColor: kPrimaryDarkBlue, // الخلفية كحلي
                );
              },
            ),
          ),
          PageIndicator(
            itemCount: onboardingPages.length,
            currentIndex: _currentPage,
            primaryColor: kAccentOrange, // اللون البرتقالي
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_currentPage == onboardingPages.length - 1) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    } else {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: kAccentOrange, // اللون البرتقالي
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    _currentPage == onboardingPages.length - 1
                        ? "ابدأ الآن"
                        : "التالي",
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final Color primaryColor;
  final Color backgroundColor;

  const OnboardingPage({
    required this.title,
    required this.description,
    required this.image,
    required this.primaryColor,
    required this.backgroundColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      color: backgroundColor, // الخلفية كحلي
      width: double.infinity,
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: height * 0.4,
              width: width * 0.8,
              child: Image.asset(
                image,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 25),
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: primaryColor, // اللون البرتقالي
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                description,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white, // نص أبيض
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PageIndicator extends StatelessWidget {
  final int itemCount;
  final int currentIndex;
  final Color primaryColor;

  const PageIndicator({
    required this.itemCount,
    required this.currentIndex,
    required this.primaryColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          itemCount,
          (index) => AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 5),
            height: 10,
            width: currentIndex == index ? 20 : 10,
            decoration: BoxDecoration(
              color: currentIndex == index ? primaryColor : Colors.grey[300],
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ),
    );
  }
}
