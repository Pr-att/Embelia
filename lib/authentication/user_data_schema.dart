import 'dart:convert';

class UserDataSchema {
  final String email;
  final int healthScore;
  final int totalTask;
  final int streak;
  final int prizeMoney;

  UserDataSchema({
    required this.email,
    required this.healthScore,
    required this.totalTask,
    required this.streak,
    required this.prizeMoney,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'healthScore': healthScore,
      'totalTask': totalTask,
      'streak': streak,
      'prizeMoney': prizeMoney,
    };
  }

  factory UserDataSchema.fromMap(Map<String, dynamic> map) {
    return UserDataSchema(
      email: map['email'] as String,
      healthScore: map['healthScore'] as int,
      totalTask: map['totalTask'] as int,
      streak: map['streak'] as int,
      prizeMoney: map['prizeMoney'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDataSchema.fromJson(String source) =>
      UserDataSchema.fromMap(json.decode(source) as Map<String, dynamic>);
}
