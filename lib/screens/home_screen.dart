import 'package:flutter/material.dart';
import 'package:kdbx/kdbx.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.kdbxFile});

  final KdbxFile kdbxFile;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enclave'),
        leading: Icon(Icons.menu),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        onPressed: () {},
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
