
enum UserRole {
  miembro,
  organizador,
  admin,
}

class DemoUser {
  final String name;
  final String email;
  final String password;
  final UserRole role;

  const DemoUser({
    required this.name,
    required this.email,
    required this.password,
    required this.role,
  });
}

class DemoAuth {
  DemoAuth._();

  static final List<DemoUser> _users = [
    const DemoUser(
      name: 'Alan',
      email: 'miembro@splitflow.demo',
      password: '12345678',
      role: UserRole.miembro,
    ),
    const DemoUser(
      name: 'Daniel',
      email: 'organizador@splitflow.demo',
      password: '12345678',
      role: UserRole.organizador,
    ),
    const DemoUser(
      name: 'Administrador',
      email: 'admin@splitflow.demo',
      password: '12345678',
      role: UserRole.admin,
    ),
  ];

  static DemoUser? currentUser;

  static String? register({
    required String name,
    required String email,
    required String password,
  }) {
    final normalizedEmail = email.trim().toLowerCase();

    if (_users.any((user) => user.email == normalizedEmail)) {
      return 'Ya existe una cuenta con ese correo.';
    }

    final user = DemoUser(
      name: name.trim(),
      email: normalizedEmail,
      password: password,
      role: UserRole.miembro,
    );

    _users.add(user);
    currentUser = user;

    return null;
  }

  static String? login({
    required String email,
    required String password,
  }) {
    final normalizedEmail = email.trim().toLowerCase();

    for (final user in _users) {
      if (user.email == normalizedEmail &&
          user.password == password) {
        currentUser = user;
        return null;
      }
    }

    return 'Correo o contraseña incorrectos.';
  }

  static void logout() {
    currentUser = null;
  }
}
