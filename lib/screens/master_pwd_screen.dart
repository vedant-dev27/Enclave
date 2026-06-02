import 'dart:io';

import 'package:enclave/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:kdbx/kdbx.dart';
import 'package:permission_handler/permission_handler.dart';

class MasterPwdScreen extends StatefulWidget {
  const MasterPwdScreen({super.key});

  @override
  State<MasterPwdScreen> createState() => _MasterPwdScreenState();
}

class _MasterPwdScreenState extends State<MasterPwdScreen> {
  final String dbPath = "/storage/emulated/0/Vault/t";

  final TextEditingController _controller = TextEditingController();

  bool _obscureText = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _unlockVault() async {
    final messenger = ScaffoldMessenger.of(context);

    final navigator = Navigator.of(context);

    final password = _controller.text.trim();

    if (password.isEmpty) {
      messenger.showSnackBar(
        const SnackBar(
          content: Text("Enter master password"),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final status = await Permission.manageExternalStorage.request();

      if (!status.isGranted) {
        messenger.showSnackBar(
          const SnackBar(
            content: Text(
              "Storage permission denied",
            ),
          ),
        );
        return;
      }

      final bytes = await File(dbPath).readAsBytes();

      final file = await KdbxFormat().read(
        bytes,
        Credentials(
          ProtectedValue.fromString(
            password,
          ),
        ),
      );

      if (!mounted) return;

      navigator.pushReplacement(
        MaterialPageRoute(
          builder: (_) => HomeScreen(
            kdbxFile: file,
          ),
        ),
      );
    } catch (_) {
      messenger.showSnackBar(
        const SnackBar(
          content: Text(
            "Incorrect password",
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 28,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 420,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // centered hero
                  Container(
                    height: 88,
                    width: 88,
                    decoration: BoxDecoration(
                      color: colors.secondaryContainer,
                      borderRadius: BorderRadius.circular(
                        28,
                      ),
                    ),
                    child: Icon(
                      Icons.lock_rounded,
                      size: 38,
                      color: colors.onSecondaryContainer,
                    ),
                  ),

                  const SizedBox(
                    height: 28,
                  ),

                  Text(
                    "Unlock vault",
                    style: theme.textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(
                    height: 40,
                  ),

                  TextField(
                    controller: _controller,
                    obscureText: _obscureText,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => _unlockVault(),
                    decoration: InputDecoration(
                      labelText: "Master password",
                      filled: true,
                      fillColor: colors.surfaceContainerHighest,

                      prefixIcon: const Icon(
                        Icons.key_rounded,
                      ),

                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_rounded
                              : Icons.visibility_off_rounded,
                        ),
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          28,
                        ),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 24,
                  ),

                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: FilledButton(
                      onPressed: _isLoading ? null : _unlockVault,
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            20,
                          ),
                        ),
                      ),
                      child: _isLoading
                          ? SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: colors.onPrimary,
                              ),
                            )
                          : const Text(
                              "Unlock",
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
