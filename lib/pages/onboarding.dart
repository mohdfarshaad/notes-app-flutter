import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingContent> _contents = [
    OnboardingContent(
      title: "Ideas deserve a home",
      image: "assets/images/bg.svg",
      description: "Capture your thoughts and inspirations instantly",
    ),
    OnboardingContent(
      title: "Organize effortlessly",
      image: "assets/images/notes.svg",
      description: "Categorize and find your ideas with ease",
    ),
    OnboardingContent(
      title: "Share your brilliance",
      image: "assets/images/add.svg",
      description: "Collaborate and get feedback on your ideas",
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Text(
                "Brain Drop",
                style: TextStyle(
                  fontFamily: 'Playwrite_Ro',
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemCount: _contents.length,
                itemBuilder: (context, index) {
                  return buildOnboardingPage(_contents[index]);
                },
              ),
            ),
            buildPageIndicator(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _currentPage > 0
                      ? TextButton(
                    onPressed: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Text(
                      "Back",
                      style: TextStyle(
                        fontFamily: "Roboto_Flex",
                        fontSize: 16,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  )
                      : const SizedBox(width: 60),
                  ElevatedButton(
                    onPressed: () {
                      if (_currentPage == _contents.length - 1) {
                        // Navigate to the main app
                        Navigator.pushReplacementNamed(context, '/home');
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child: Text(
                      _currentPage == _contents.length - 1
                          ? "Get Started"
                          : "Next",
                      style: const TextStyle(
                        fontFamily: "Roboto_Flex",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOnboardingPage(OnboardingContent content) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            content.image,
            width: 280,
            height: 280,
          ),
          const SizedBox(height: 40),
          Text(
            content.title,
            style: const TextStyle(
              fontFamily: "Roboto_Flex",
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            content.description,
            style: TextStyle(
              fontFamily: "Roboto_Flex",
              fontSize: 16,
              color: Colors.grey[700],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _contents.length,
            (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: _currentPage == index ? 24 : 8,
          decoration: BoxDecoration(
            color: _currentPage == index
                ? Theme.of(context).primaryColor
                : Colors.grey[300],
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}

class OnboardingContent {
  final String title;
  final String image;
  final String description;

  OnboardingContent({
    required this.title,
    required this.image,
    required this.description,
  });
}