// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  String id;
  String name;
  String email;
  String user_id;
  String? phone;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.user_id,
    this.phone,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? user_id,
    String? phone,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      user_id: user_id ?? this.user_id,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'user_id': user_id,
      'phone': phone,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      user_id: map['user_id'] as String,
      phone: map['phone'] != null ? map['phone'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, user_id: $user_id, phone: $phone)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.user_id == user_id &&
        other.phone == phone;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        user_id.hashCode ^
        phone.hashCode;
  }
}
