import 'package:enclave/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const EnclaveApp());
}

class EnclaveApp extends StatelessWidget {
  const EnclaveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
