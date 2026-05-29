import 'package:flutter/material.dart';
import 'package:kdbx/kdbx.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:enclave/screens/home_screen.dart';

class MasterPwdScreen extends StatefulWidget {
  const MasterPwdScreen({super.key});

  @override
  State<MasterPwdScreen> createState() => _MasterPwdScreenState();
}

class _MasterPwdScreenState extends State<MasterPwdScreen> {
  final dbPath = "/storage/emulated/0/Vault/t";
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
            onPressed: () async {
              final navigator = Navigator.of(context);
              final messenger = ScaffoldMessenger.of(context);
              String masterPassword = _controller.text;
              final status = await Permission.manageExternalStorage.request();
              if (status.isGranted) {
                try {
                  final bytes = await File(dbPath).readAsBytes();
                  final file = await KdbxFormat().read(
                    bytes,
                    Credentials(
                      ProtectedValue.fromString(masterPassword),
                    ),
                  );

                  navigator.pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(kdbxFile: file),
                    ),
                  );
                } catch (e) {
                  messenger.showSnackBar(
                    const SnackBar(
                      content: Text("Error opening database"),
                    ),
                  );
                }
              }
            },
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }
}
