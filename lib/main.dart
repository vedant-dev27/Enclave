import 'package:dynamic_color/dynamic_color.dart';
import 'package:enclave/screens/master_pwd_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const EnclaveApp());
}

class EnclaveApp extends StatelessWidget {
  const EnclaveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder:
          (
            ColorScheme? lightDynamic,
            ColorScheme? darkDynamic,
          ) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              themeMode: ThemeMode.system,

              theme: ThemeData(
                useMaterial3: true,
                colorScheme:
                    lightDynamic ??
                    ColorScheme.fromSeed(
                      seedColor: Colors.blue,
                    ),
              ),

              darkTheme: ThemeData(
                useMaterial3: true,
                colorScheme:
                    darkDynamic ??
                    ColorScheme.fromSeed(
                      seedColor: Colors.blue,
                      brightness: Brightness.dark,
                    ),
              ),

              home: const MasterPwdScreen(),
            );
          },
    );
  }
}
