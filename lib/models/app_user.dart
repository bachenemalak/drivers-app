enum UserRole { manager, driver }

class AppUser {
  final String id;
  final String fullName;
  final String email;
  final UserRole role;

  const AppUser({
    required this.id,
    required this.fullName,
    required this.email,
    required this.role,
  });
}
