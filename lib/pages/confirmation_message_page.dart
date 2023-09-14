import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_app/pages/contact_page.dart';
import 'package:my_app/pages/home_page.dart';

class ConfirmationMessage extends StatelessWidget {
  final bool success;
  const ConfirmationMessage({super.key, required this.success});

  @override
  Widget build(BuildContext context) {
    String lottieAnimation = success
        ? 'assets/animations/animation_lmggsxht.json'
        : 'assets/animations/animation_lmggseyf.json';
    String message = success
        ? "Our team will connect with you in 24 hours"
        : "Please try again";

    String buttonText = success ? "Done" : "Try Again";
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center vertically
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0), // Add padding to all sides
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Lottie.asset(lottieAnimation)),
            ),
            const SizedBox(height: 20),
            Text(
              message,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: success
                      ? const Color(0xFF2CDA94)
                      : const Color(0xFFE25B5B),
                  foregroundColor: Colors.white,
                  elevation: 10,
                ),
                onPressed: () {
                  if (success) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                        (Route<dynamic> route) => false);
                  } else {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) =>
                                ContactUsForm(submissionSuccessful: success)),
                        (Route<dynamic> route) => false);
                  }
                },
                child: Text(
                  buttonText,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
          ]),
    );
  }
}
