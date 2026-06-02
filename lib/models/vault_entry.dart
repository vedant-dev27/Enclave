class VaultEntry {
  final String title;
  final String username;
  final String? password;
  final String? url;
  final String? notes;
  final String? icon;

  const VaultEntry({
    required this.title,
    required this.username,
    this.password,
    this.url,
    this.notes,
    this.icon,
  });
}
