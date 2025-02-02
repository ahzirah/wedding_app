import 'package:carro_weddings_ag/screens/home_screen.dart';
import 'package:carro_weddings_ag/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(MainApp(showHome: showHome));
  });
}

class MainApp extends StatelessWidget {
  final bool showHome;

  const MainApp({
    super.key,
    required this.showHome,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Main App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: createMaterialColor(Colors.black),
        hintColor: Colors.blueGrey,
        scaffoldBackgroundColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1), // Black border for input fields
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2), // Black border when focused
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2), // Black border by default
          ),
          labelStyle: const TextStyle(color: Colors.black), // Set label text color to black
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Colors.black, // Text color in the button
          ),
        ),
      ),
      home: showHome ? const HomeScreen() : const SplashScreen(),
    );
  }

  MaterialColor createMaterialColor(Color color) {
    // ignore: deprecated_member_use
    return MaterialColor(color.value, <int, Color>{
      50: color.withValues(),
      100: color.withValues(),
      200: color.withValues(),
      300: color.withValues(),
      400: color.withValues(),
      500: color.withValues(),
      600: color.withValues(),
      700: color.withValues(),
      800: color.withValues(),
      900: color.withValues(),
    });
  }
}
