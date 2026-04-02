class Client {
  final String id;
  final String fullName;
  final String phoneNumber;
  final String email;
  final bool savedToDirectory;

  const Client({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.savedToDirectory,
  });
}
