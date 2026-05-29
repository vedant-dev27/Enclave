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
    List<KdbxEntry> ls = widget.kdbxFile.body.rootGroup.entries.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Enclave'),
        leading: Icon(Icons.menu),
      ),
      body: ListView.builder(
        itemCount: ls.length,
        itemBuilder: (context, index) {
          final entry = ls[index];

          return ListTile(
            title: Text(
              entry.getString(KdbxKeyCommon.TITLE)?.getText() ?? 'Untitled',
            ),
            subtitle: Text(
              entry.getString(KdbxKeyCommon.PASSWORD)?.getText() ?? "Unknown",
            ),
          );
        },
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
