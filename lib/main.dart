import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starforce_sim_flutter/screens/home_screen.dart';

void main() {
  runApp(const ProviderScope(child: StarforceSimApp()));
}

class StarforceSimApp extends StatelessWidget {
  const StarforceSimApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Starforce Sim',
      theme: ThemeData(
        // Define the default brightness and color scheme
        brightness: Brightness.light,
        primaryColor: Colors.blue, // AppBar and primary color
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.blue,
          secondary: Colors.orange, // Secondary color
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(), // Default border for all input fields
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2.0),
          ),
        ),
        elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.blue),
            foregroundColor: WidgetStatePropertyAll(Colors.white),
          ),
        ),
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.white,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
