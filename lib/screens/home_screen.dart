import 'package:enclave/models/vault_entry.dart';
import 'package:enclave/widgets/vault_entry_tile.dart';
import 'package:flutter/material.dart';
import 'package:kdbx/kdbx.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.kdbxFile,
  });

  final KdbxFile kdbxFile;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final List<VaultEntry> entries;

  @override
  void initState() {
    super.initState();

    entries = widget.kdbxFile.body.rootGroup.entries
        .map(
          (entry) => VaultEntry(
            title:
                entry
                    .getString(
                      KdbxKeyCommon.TITLE,
                    )
                    ?.getText() ??
                "Untitled",

            username:
                entry
                    .getString(
                      KdbxKeyCommon.USER_NAME,
                    )
                    ?.getText() ??
                "Unknown",

            password: entry
                .getString(
                  KdbxKeyCommon.PASSWORD,
                )
                ?.getText(),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final colors = theme.colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,

        title: Text(
          "Enclave",
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),

        centerTitle: false,

        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search_rounded,
            ),
          ),
        ],
      ),

      body: entries.isEmpty
          ? Center(
              child: Text(
                "No entries found",
                style: theme.textTheme.bodyLarge,
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(
                20,
                8,
                20,
                120,
              ),

              itemCount: entries.length,

              itemBuilder: (context, index) {
                final entry = entries[index];

                return VaultEntryTile(
                  entry: entry,

                  onTap: () {
                    // TODO:
                    // open detail page
                  },
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: colors.primaryContainer,

        foregroundColor: colors.onPrimaryContainer,

        onPressed: () {},

        child: const Icon(
          Icons.add_rounded,
        ),
      ),
    );
  }
}
