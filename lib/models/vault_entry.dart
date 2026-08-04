class VaultEntry {
  final String title;
  final String username;
  final String? password;

  const VaultEntry({
    required this.title,
    required this.username,
    this.password,
  });
}
