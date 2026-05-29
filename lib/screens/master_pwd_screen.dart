import 'package:flutter/material.dart';
import 'package:enclave/screens/home_screen.dart';

class MasterPwdScreen extends StatefulWidget {
  const MasterPwdScreen({super.key});

  @override
  State<MasterPwdScreen> createState() => _MasterPwdScreenState();
}

class _MasterPwdScreenState extends State<MasterPwdScreen> {
  final String pwd = "123456";
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: "Master Password",
            ),
          ),
          ElevatedButton(
            onPressed: () {
              String masterPassword = _controller.text;
              if (masterPassword == pwd) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              }
            },
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }
}
