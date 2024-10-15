import 'package:bike_tuk_tuk/login_register.dart';
import 'package:flutter/material.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  // PageController to track which page is currently being displayed
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Sample onboarding data
  final List<Map<String, String>> onboardingData = [
    {
      "image": "assets/Locate.png", // Add your onboarding images here
      "title": "Welcome to Our App",
      "description": "Discover amazing features that enhance your experience."
    },
    {
      "image": "assets/Unlock.png",
      "title": "Stay Connected",
      "description": "Always stay updated with notifications and alerts."
    },
    {
      "image": "assets/Ride.png",
      "title": "Get Started",
      "description": "Join our community and explore endless possibilities."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: onboardingData.length,
            itemBuilder: (context, index) => OnBoardingContent(
              image: onboardingData[index]["image"]!,
              title: onboardingData[index]["title"]!,
              description: onboardingData[index]["description"]!,
            ),
          ),
          // Indicator and button positioned at the bottom
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Column(
              children: [
                // Dots indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    onboardingData.length,
                    (index) => buildDot(index),
                  ),
                ),
                const SizedBox(height: 20),
                // "Get Started" or "Next" button
                _currentPage == onboardingData.length - 1
                    ? ElevatedButton(
                        onPressed: () {
                          // Navigate to home or login screen
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginRegisterPage()));
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          // backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 80, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          "Get Started",
                          style: TextStyle(color: Colors.black, fontSize: 17),
                        ),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          // backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 80, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text("Next",
                            style:
                                TextStyle(color: Colors.black, fontSize: 17)),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Dot indicator for current page
  Widget buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 8),
      height: 10,
      width: _currentPage == index ? 20 : 10,
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.deepPurple : Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

class OnBoardingContent extends StatelessWidget {
  final String image, title, description;

  const OnBoardingContent({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          image,
          // height: 600,
          // width: 400,
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
