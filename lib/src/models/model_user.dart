class ModelUser {
  final String token;
  final int id;
  final String username;
  final String email;
  final String provider;
  final bool confirmed;
  final bool blocked;
  final DateTime createdAt;
  final DateTime updatedAt;

  ModelUser(
    this.token,
    this.id,
    this.username,
    this.email,
    this.provider,
    this.confirmed,
    this.blocked,
    this.createdAt,
    this.updatedAt,
  );

  factory ModelUser.fromJson(Map<String, Object?> json) {
    final user = json['user'] as Map<String, Object?>;
    return ModelUser(
          json['jwt'] as String,
          user['id'] as int,
          user['username'] as String,
          user['email'] as String,
          user['provider'] as String,
          user['confirmed'] as bool,
          user['blocked'] as bool,
          DateTime.parse(user['createdAt'] as String),
          DateTime.parse(user['updatedAt'] as String),
        );
  }

  Map<String, Object?> toJson() => {
        'token': token,
        'id': id,
        'username': username,
        'email': email,
        'provider': provider,
        'confirmed': confirmed,
        'blocked': blocked,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}
