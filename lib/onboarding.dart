// onboarding.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_1/logn_in.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/themeNotifier.dart';

class Onboarding extends ConsumerStatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends ConsumerState<Onboarding> {
  @override
  Widget build(BuildContext context) {
    final currentTheme = ref.watch(themeProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: (currentTheme == ThemeMode.dark)
                      ? Icon(Icons.light_mode, color: Theme.of(context).colorScheme.secondary)
                      : Icon(Icons.dark_mode, color: Theme.of(context).colorScheme.primary),
                  onTap: () {
                    ref.read(themeProvider.notifier).toggleTheme();
                  },
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  'Your AI Assistant',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  'Using this software, you can ask your questions and receive articles using an artificial intelligence assistant',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontSize: 16, // Smaller font size
                  ),
                  textAlign: TextAlign.center,
                  /*style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),*/
                ),
              ],
            ),
            SizedBox(height: 32),
            Image.asset('assets/onboarding.png'),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Continue'
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
