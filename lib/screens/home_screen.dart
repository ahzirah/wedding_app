import 'package:carro_weddings_ag/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Home Screen', style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.setBool('showHome', false);

              // ignore: use_build_context_synchronously
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const OnboardingScreen()));
            },
             icon: const Icon(Icons.logout))
        ],
      ),
      body: const Center(
        child: Text('Welcome to the Home Screen!', style: TextStyle(fontSize: 35, color: Colors.black),),
      ),
    );
  }
}
