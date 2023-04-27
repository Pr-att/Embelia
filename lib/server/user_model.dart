class AutoGenerate {
  AutoGenerate({
    required this.name,
    required this.email,
  });
  late final String name;
  late final String email;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
    };
  }

  factory AutoGenerate.fromMap(Map<String, dynamic> map) {
    return AutoGenerate(
      name: map['name'] as String,
      email: map['email'] as String,
    );
  }
}
