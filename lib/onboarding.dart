import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'main.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      showSkipButton: true,
      skip: Text("Skip", style: TextStyle(fontWeight: FontWeight.w600)),
      done: Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
      next: Text("Next", style: TextStyle(fontWeight: FontWeight.w600)),
      pages: [
        PageViewModel(
          image: Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: Container(
              child: Image.asset('assets/images/onboarding1.png'),
            ),
          ),
          title: "Jelajahi berbagai Guide",
          body:
              "Dengan aplikasi kami, Anda dapat menjelajahi ribuan panduan yang berbeda untuk memenuhi berbagai kebutuhan Anda.",
        ),
        PageViewModel(
          image: Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: Container(
              child: Image.asset('assets/images/onboarding2.png'),
            ),
          ),
          title: "Dapatkan Semua yang Anda Butuhkan",
          body:
              "Tidak perlu lagi mencari panduan Anda secara terpisah di berbagai sumber. Dengan aplikasi kami, Anda dapat memiliki akses ke semua panduan",
        ),
        PageViewModel(
          image: Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: Container(
              child: Image.asset('assets/images/onboarding3.png'),
            ),
          ),
          title: "Temukan Guide yang Anda Inginkan",
          body:
              "Sekarang saatnya bagi Anda untuk mengeksplorasi panduan yang Anda inginkan. Dengan aplikasi kami",
        ),
      ],
      onSkip: () {
        // masuk ke main.dart
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  MyHomePage()), // Ganti dengan halaman tujuan yang diinginkan
        );
      },
      onDone: () {
        // masuk ke main.dart
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  MyHomePage()), // Ganti dengan halaman tujuan yang diinginkan
        );
      },
    );
  }
}
